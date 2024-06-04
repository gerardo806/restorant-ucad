<?php

/*session_start();
date_default_timezone_set('America/El_salvador');
setlocale(LC_TIME, 'spanish');

require_once('conf.php');

if(isset($_GET['mod'])){
    $modulo = $_GET['mod'];
}else{
    $modulo = MODULO_DEFECTO;
}*/

session_start();
date_default_timezone_set('America/El_salvador');
setlocale(LC_TIME, 'spanish');

require_once('conf.php');

// Capturar la URL amigable
$url = isset($_GET['mod']) ? $_GET['mod'] : '';
$url = rtrim($url, '/');
$url = filter_var($url, FILTER_SANITIZE_URL);
$url = explode('/', $url);

// Aquí puedes manejar las rutas amigables
$modulo = !empty($url[0]) ? $url[0] : MODULO_DEFECTO;

if (isset($conf[$modulo]['layout'])) {
    $path_layout = LAYOUT_PATH . '/' . $conf[$modulo]['layout'];
    if (!empty($conf[$modulo]['layout'])) {
        include($path_layout);
    } else {
        $modulo = 'inicio';
        $path_layout = LAYOUT_PATH . '/' . $conf[$modulo]['layout'];
        include($path_layout);
    }
}

/* $clave = '1234';
$clave_encriptada = password_hash($clave, PASSWORD_DEFAULT);
echo $clave_encriptada; */

?>