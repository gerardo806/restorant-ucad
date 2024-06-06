<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Obtener la información previa del platillo
    $sql_previa = "SELECT * FROM `mydb`.`platillo` WHERE `idplatillo` = $params[id_platillo]";
    $result_previa = mysqli_query($con, $sql_previa);
    $info_previa = mysqli_fetch_assoc($result_previa);
    $info_previa_json = json_encode($info_previa);

    // Actualizar en la tabla platillo
    $sql = "UPDATE `mydb`.`platillo` 
            SET `nombre_platillo` = '$params[platilloUpdate]', 
                `descripcion` = '$params[descripcionUpdate]', 
                `precio` = '$params[precioUpdate]' 
            WHERE `idplatillo` = $params[id_platillo]";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de platillo: " . mysqli_error($con));
    }

    // Obtener la información posterior del platillo
    $sql_posterior = "SELECT * FROM `mydb`.`platillo` WHERE `idplatillo` = $params[id_platillo]";
    $result_posterior = mysqli_query($con, $sql_posterior);
    $info_posterior = mysqli_fetch_assoc($result_posterior);
    $info_posterior_json = json_encode($info_posterior);

    // Insertar en la bitácora
    $sql_bitacora = "CALL registrarBitacora($params[id_platillo], 'platillo', $_SESSION[restoran_id_usuario], 3, '$info_previa_json', '$info_posterior_json')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Platillo actualizado exitosamente'
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