<?php

require '../sql/conexion.php';

$params = $_POST;

try{

    $sql = "SELECT u.idusuario, u.nombre_usuario, u.estado, c.clave_usuario
            FROM usuario u
            INNER JOIN clave c ON u.idusuario = c.idusuario
            WHERE u.nombre_usuario = '{$params['usuario']}'
            AND c.fecha_vencimiento >= NOW()
            AND CAST(c.estado AS UNSIGNED) = 1";

        $resultado = mysqli_query($con, $sql);

        if(!$resultado){
            throw new Exception(mysqli_error($con));
        }

        if(mysqli_num_rows($resultado)==0){
            throw new Exception('No hay coincidencia en las credenciales');
        }

        $datosUsuario = mysqli_fetch_assoc($resultado);

        if($datosUsuario['estado'] == 0){
            throw new Exception('Su cuenta está inactiva');
        }

        if (!password_verify($params['clave'], $datosUsuario['clave_usuario'])) {
            throw new Exception('No hay coincidencia en las credenciales');
        }


        session_start();

        $_SESSION['restoran'] = true;
        $_SESSION['restoran_id_usuario'] = $datosUsuario['idusuario'];
        $_SESSION['restoran_usuario'] = $datosUsuario['nombre_usuario'];
        //$_SESSION['vehiculos_name'] = $datosUsuario['nombres'] . " " . $datosUsuario["apellidos"];
        //$_SESSION['vehiculos_id_rol'] = $datosUsuario['id_rol'];
        //$_SESSION['vehiculos_rol'] = $datosUsuario['rol'];

        /*$sql ="INSERT INTO bitacora(fecha, accion, tabla, id_afectado, id_usuario)
        VALUES(NOW(), 1, 'no aplica', 0, '$_SESSION[vehiculos_id_usuario]')";
        $resultado = mysqli_query($con, $sql);*/

        $response = array('success'=>true, 'url'=>"?mod=inicio");        

}catch(Exception $e){
    $response = array(
        'success'=>false,
        'error'=>$e->getMessage()
    );
}

echo json_encode($response);

?>