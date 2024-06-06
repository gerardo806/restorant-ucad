<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Obtener la información previa del postre
    $sql_previa = "SELECT * FROM `mydb`.`postre` WHERE `idpostre` = $params[idpostre]";
    $result_previa = mysqli_query($con, $sql_previa);
    $info_previa = mysqli_fetch_assoc($result_previa);
    $info_previa_json = json_encode($info_previa);

    // Actualizar en la tabla postre
    $sql = "UPDATE `mydb`.`postre` 
            SET `nombre_postre` = '$params[postreUpdate]', 
                `descripcion` = '$params[descripcionUpdate]', 
                `precio` = '$params[precioUpdate]' 
            WHERE `idpostre` = $params[idpostre]";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de postre: " . mysqli_error($con));
    }

    // Obtener la información posterior del postre
    $sql_posterior = "SELECT * FROM `mydb`.`postre` WHERE `idpostre` = $params[idpostre]";
    $result_posterior = mysqli_query($con, $sql_posterior);
    $info_posterior = mysqli_fetch_assoc($result_posterior);
    $info_posterior_json = json_encode($info_posterior);

    // Insertar en la bitácora
    $sql_bitacora = "CALL registrarBitacora($params[idpostre], 'postre', $_SESSION[restoran_id_usuario], 3, '$info_previa_json', '$info_posterior_json')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Postre actualizado exitosamente'
    );
} catch (Exception $e) {
    // Revertir la transacción en caso de error
    mysqli_rollback($con);

    $response = array(
        'success' => false,
        'error' => 'Error en la consulta: ' . $e->getMessage()
    );
}

echo json_encode($response);

$con->close();
?>