<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST;
    $response = array();

    // Verificar que el idbebida esté presente en los parámetros
    if (!isset($params['idbebida'])) {
        throw new Exception("El ID de la bebida no está presente en los parámetros.");
    }

    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Extraer la información anterior de la bebida
    $sql_select = "SELECT * FROM bebida WHERE idbebida = '$params[idbebida]'";
    $result_select = mysqli_query($con, $sql_select);
    $bebida_anterior = mysqli_fetch_assoc($result_select);

    // Actualizar el estado de la bebida a 0 para un borrado lógico
    $sql = "UPDATE bebida SET estado = '0' WHERE idbebida = '$params[idbebida]'";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de bebida: " . mysqli_error($con));
    }

    // Llamar al procedimiento almacenado para registrar en la bitacora
    $json = json_encode($bebida_anterior);
    $sql_bitacora = "CALL registrarBitacora($params[idbebida], 'bebida', $_SESSION[restoran_id_usuario], 4, '$json', 'Bebida eliminada')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Bebida eliminada exitosamente'
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
?>