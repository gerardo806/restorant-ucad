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

<<<<<<< HEAD
$conf['bebidas'] = array(
    'archivo'=>'menus/bebidas.html',
    'layout'=>LAYOUT_DESKTOP
);

=======
>>>>>>> 84a94823acacae0ef695b867f5a927511f5ff0e7
?>