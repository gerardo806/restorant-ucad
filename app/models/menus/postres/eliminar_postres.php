<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST;
    $response = array();

    // Verificar que el idpostre esté presente en los parámetros
    if (!isset($params['idpostre'])) {
        throw new Exception("El ID del postre no está presente en los parámetros.");
    }

    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Extraer la información anterior del postre
    $sql_select = "SELECT * FROM postre WHERE idpostre = '$params[idpostre]'";
    $result_select = mysqli_query($con, $sql_select);
    $postre_anterior = mysqli_fetch_assoc($result_select);

    // Actualizar el estado del postre a 0 para un borrado lógico
    $sql = "UPDATE postre SET estado = '0' WHERE idpostre = '$params[idpostre]'";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de postre: " . mysqli_error($con));
    }

    // Llamar al procedimiento almacenado para registrar en la bitacora
    $json = json_encode($postre_anterior);
    $sql_bitacora = "CALL registrarBitacora($params[idpostre], 'postre', $_SESSION[restoran_id_usuario], 4, '$json', 'Postre eliminado')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Postre eliminado exitosamente'
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