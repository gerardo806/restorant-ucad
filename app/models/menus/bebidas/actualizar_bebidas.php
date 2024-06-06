<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Paso 1: Actualizar en la tabla bebida
    $sql1 = "UPDATE `mydb`.`bebida` SET `cantidad` = '$params[cantidadUpdate]', `idtipo_bebida` = $params[id_bebidaUpdate], `precio` = $params[precioUpdate] WHERE `idbebida` = $params[idbebida]";
    if (!mysqli_query($con, $sql1)) {
        throw new Exception("Error en la actualización de bebida: " . mysqli_error($con));
    }

    // Paso 2: Obtener la información previa de la bebida
    $sql_previa = "SELECT * FROM `mydb`.`bebida` WHERE `idbebida` = $params[idbebida]";
    $result_previa = mysqli_query($con, $sql_previa);
    $info_previa = mysqli_fetch_assoc($result_previa);
    $info_previa_json = json_encode($info_previa);

    // Paso 3: Llamar al procedimiento almacenado registrarBitacora
    $json = json_encode($params);
    $sql2 = "CALL registrarBitacora($params[idbebida], 'bebida', $_SESSION[restoran_id_usuario], 3, '$info_previa_json', '$json')";
    if (!mysqli_query($con, $sql2)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Operación completada exitosamente'
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