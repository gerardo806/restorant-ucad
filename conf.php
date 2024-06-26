<?php

define('MODULO_DEFECTO', 'login');
define('LAYOUT_LOGIN', 'login.php');
define('LAYOUT_DESKTOP', 'desktop.php');
define('MODULO_PATH', realpath('app/views'));
define('LAYOUT_PATH', realpath('app/templates'));

$conf['login'] = array(
    'archivo'=>'login.html',
    'layout'=>LAYOUT_LOGIN
);

$conf['inicio'] = array(
    'archivo'=>'inicio.php',
    'layout'=>LAYOUT_DESKTOP
);

$conf['empleados'] = array(
    'archivo'=>'empleados.html',
    'layout'=>LAYOUT_DESKTOP
);

$conf['usuarios'] = array(
    'archivo'=>'usuarios.html',
    'layout'=>LAYOUT_DESKTOP
);

$conf['platillos'] = array(
    'archivo'=>'menus/platillos.html',
    'layout'=>LAYOUT_DESKTOP
);

$conf['bebidas'] = array(
    'archivo'=>'menus/bebidas.html',
    'layout'=>LAYOUT_DESKTOP
);

$conf['postres'] = array(
    'archivo'=>'menus/postres.html',
    'layout'=>LAYOUT_DESKTOP
);
?>