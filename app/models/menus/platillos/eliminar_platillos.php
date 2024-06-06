<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST;
    $response = array();

    // Verificar que el idplatillo esté presente en los parámetros
    if (!isset($params['idplatillo'])) {
        throw new Exception("El ID del platillo no está presente en los parámetros.");
    }

    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Extraer la información anterior del platillo
    $sql_select = "SELECT * FROM platillo WHERE idplatillo = '$params[idplatillo]'";
    $result_select = mysqli_query($con, $sql_select);
    $platillo_anterior = mysqli_fetch_assoc($result_select);

    // Actualizar el estado del platillo a 0 para un borrado lógico
    $sql = "UPDATE platillo SET estado = '0' WHERE idplatillo = '$params[idplatillo]'";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de platillo: " . mysqli_error($con));
    }

    // Llamar al procedimiento almacenado para registrar en la bitacora
    $json = json_encode($platillo_anterior);
    $sql_bitacora = "CALL registrarBitacora($params[idplatillo], 'platillo', $_SESSION[restoran_id_usuario], 4, '$json', 'Platillo eliminado')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Platillo eliminado exitosamente'
    );

    echo json_encode($response);
} catch (Exception $e) {
    // Revertir la transacción en caso de error
    mysqli_rollback($con);

    $response = array(
        'success' => false,
        'error' => 'Error en la consulta: ' . $e->getMessage()
    );

    echo json_encode($response);
}

$con->close();
unset($response);