<?php

require '../sql/conexion.php';
    session_start();
    //session_destroy();

    /*$sql ="INSERT INTO bitacora(fecha, accion, tabla, id_afectado, id_usuario)
        VALUES(NOW(), 2, 'no aplica', 0, '$_SESSION[vehiculos_id_usuario]')";
    $resultado = mysqli_query($con, $sql);*/

    unset(
        $_SESSION['restoran'],
        $_SESSION['restoran_id_usuario'],
        $_SESSION['restoran_usuario']
    );

    $response=array('success'=>true, 'url'=>"?mod=login");

    echo json_encode($response);

?>