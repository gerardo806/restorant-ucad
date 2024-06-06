<?php
session_start();
require '../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Paso 1: Actualizar en la tabla usuario
    $sql1 = "UPDATE `mydb`.`usuario` SET `nombre_usuario` = '$params[usuarioUpdate]' WHERE `idusuario` = $params[id_usuario]";
    if (!mysqli_query($con, $sql1)) {
        throw new Exception("Error en la actualización de usuario: " . mysqli_error($con));
    }

    // Paso 2: Colocar en estado 0 el registro de la tabla rol_usuario si se selecciona otro rol
    $sql2 = "UPDATE `mydb`.`rol_usuario` SET `estado` = '0' WHERE `usuario_idusuario` = $params[id_usuario]";
    if (!mysqli_query($con, $sql2)) {
        throw new Exception("Error en la actualización de rol_usuario: " . mysqli_error($con));
    }

    // Paso 3: Insertar el nuevo rol en la tabla rol_usuario
    $sql3 = "INSERT INTO `mydb`.`rol_usuario` (`estado`, `usuario_idusuario`, `idrol`)
             VALUES ('1', $params[id_usuario], $params[id_rolUpdate])";
    if (!mysqli_query($con, $sql3)) {
        throw new Exception("Error en la inserción de nuevo rol_usuario: " . mysqli_error($con));
    }

    // Verificar si se enviaron las claves
    if (!empty($params['claveUpdate']) && !empty($params['confirmarClaveUpdate'])) {
        $clave = password_hash($params["claveUpdate"], PASSWORD_DEFAULT);

        // Paso 4: Colocar en estado 0 el registro de la clave anterior
        $sql4 = "UPDATE `mydb`.`clave` SET `estado` = '0' WHERE `idusuario` = $params[id_usuario]";
        if (!mysqli_query($con, $sql4)) {
            throw new Exception("Error en la actualización de clave: " . mysqli_error($con));
        }

        // Paso 5: Insertar la nueva clave en la tabla clave
        $sql5 = "INSERT INTO `mydb`.`clave` (`clave_usuario`, `fecha_creacion`, `fecha_vencimiento`, `estado`, `idusuario`)
                 VALUES ('$clave', NOW(), DATE_ADD(NOW(), INTERVAL 1 YEAR), '1', $params[id_usuario])";
        if (!mysqli_query($con, $sql5)) {
            throw new Exception("Error en la inserción de nueva clave: " . mysqli_error($con));
        }
    }

    // Paso 6: Llamar al procedimiento almacenado registrarBitacora
    $json = json_encode($params);

    // Obtener la información previa del usuario
    $sql_previa = "SELECT * FROM `mydb`.`usuario` WHERE `idusuario` = $params[id_usuario]";
    $result_previa = mysqli_query($con, $sql_previa);
    $info_previa = mysqli_fetch_assoc($result_previa);
    $info_previa_json = json_encode($info_previa);

    $sql6 = "CALL registrarBitacora($params[id_usuario], 'usuario', $_SESSION[restoran_id_usuario], 3, '$info_previa_json', '$json')";
    if (!mysqli_query($con, $sql6)) {
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
