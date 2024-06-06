<?php
session_start();
require '../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Paso 1: Insertar en la tabla usuario
    $sql1 = "INSERT INTO `mydb`.`usuario` (`nombre_usuario`, `fecha_creacion`, `estado`)
             VALUES ('$params[usuario]', NOW(), '1')";
    if (!mysqli_query($con, $sql1)) {
        throw new Exception("Error en la inserción de usuario: " . mysqli_error($con));
    }

    // Obtener el ID del usuario insertado
    $idusuario = mysqli_insert_id($con);

    // Paso 2: Insertar en la tabla rol_usuario
    $sql2 = "INSERT INTO `mydb`.`rol_usuario` (`estado`, `usuario_idusuario`, `idrol`)
             VALUES ('1', $idusuario, $params[id_rol])"; // Reemplaza 1 con el ID del rol correspondiente
    if (!mysqli_query($con, $sql2)) {
        throw new Exception("Error en la inserción de rol_usuario: " . mysqli_error($con));
    }

    $clave = password_hash($params["clave"], PASSWORD_DEFAULT);
    // Paso 3: Insertar en la tabla clave
    $sql3 = "INSERT INTO `mydb`.`clave` (`clave_usuario`, `fecha_creacion`, `fecha_vencimiento`, `estado`, `idusuario`)
             VALUES ('$clave', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', $idusuario)";
    if (!mysqli_query($con, $sql3)) {
        throw new Exception("Error en la inserción de clave: " . mysqli_error($con));
    }

    // Paso 4: Llamar al procedimiento almacenado registrarBitacora
    $json = json_encode($params);
    $sql4 = "CALL registrarBitacora($idusuario, 'usuario', $_SESSION[restoran_id_usuario], 2, '', '$json')";
    if (!mysqli_query($con, $sql4)) {
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
//unset($response);

?>