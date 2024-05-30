<?php

error_reporting(E_ERROR);

$servidor = '127.0.0.1';
$usuario = 'root';
$clave = 'root';
$bd = 'mydb';

$con = mysqli_connect($servidor, $usuario,$clave, $bd);

if($con){
    //utf-8
    $con->set_charset("utf8");
}else{
    $response = array(
        'success'=>false,
        'error'=>'No hay conexión a la base de datos'
    );

    echo json_encode($response);

    exit();
}

?>