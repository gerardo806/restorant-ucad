<?php
session_start();
require '../../sql/conexion.php';

try {
    $params = $_POST['form'];
    // Iniciar la transacción
    mysqli_begin_transaction($con);

    // Paso 1: Insertar en la tabla postre
    $sql1 = "INSERT INTO `mydb`.`postre` (`nombre_postre`, `descripcion`, `precio`, `estado`)
             VALUES ('$params[postre]', '$params[descripcion]', '$params[precio]', '1')";
    if (!mysqli_query($con, $sql1)) {
        throw new Exception("Error en la inserción de postre: " . mysqli_error($con));
    }

    // Obtener el ID del postre insertado
    $idpostre = mysqli_insert_id($con);

    // Paso 2: Llamar al procedimiento almacenado registrarBitacora
    $json = json_encode($params);
    $sql2 = "CALL registrarBitacora($idpostre, 'postre', $_SESSION[restoran_id_usuario], 2, '', '$json')";
    if (!mysqli_query($con, $sql2)) {
        throw new Exception("Error en la llamada al procedimiento almacenado: " . mysqli_error($con));
    }

    // Confirmar la transacción
    mysqli_commit($con);

    $response = array(
        'success' => true,
        'message' => '¡Postre guardado exitosamente!'
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