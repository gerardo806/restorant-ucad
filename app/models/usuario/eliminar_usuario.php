<?php
session_start();
require '../sql/conexion.php';

try {
    $params = $_POST;
    $response = array();

    // Verificar que el idusuario esté presente en los parámetros
    if (!isset($params['idusuario'])) {
        throw new Exception("El ID del usuario no está presente en los parámetros.");
    }

    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Extraer la información anterior del usuario
    $sql_select = "SELECT * FROM usuario WHERE idusuario = '$params[idusuario]'";
    $result_select = mysqli_query($con, $sql_select);
    $usuario_anterior = mysqli_fetch_assoc($result_select);

    // Actualizar el estado del usuario a 0 para un borrado lógico
    $sql = "UPDATE usuario SET estado = '0' WHERE idusuario = '$params[idusuario]'";
    if (!mysqli_query($con, $sql)) {
        throw new Exception("Error en la actualización de usuario: " . mysqli_error($con));
    }

    // Llamar al procedimiento almacenado para registrar en la bitacora
    $json = json_encode($usuario_anterior);
    $sql_bitacora = "CALL registrarBitacora($params[idusuario], 'usuario', $_SESSION[restoran_id_usuario], 4, '$json', 'Usuario eliminado')";
    if (!mysqli_query($con, $sql_bitacora)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => 'Usuario eliminado exitosamente'
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