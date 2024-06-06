<?php

require '../sql/conexion.php';

try{

    $params = $_POST;
    $response = array();

    $sql = "SELECT u.idusuario, u.nombre_usuario AS usuario, u.fecha_creacion, r.idrol as id_rol,
        r.nombre_rol AS rol, r.descripcion
        FROM usuario u
        INNER JOIN rol_usuario ru ON u.idusuario = ru.usuario_idusuario
        INNER JOIN rol r ON ru.idrol = r.idrol
        WHERE u.idusuario = '$params[idusuario]' AND u.estado = '1'";

    $resultado = mysqli_query($con, $sql);

    if($resultado){
        if(mysqli_num_rows($resultado)>0){
            $items = array();
            while($fila = mysqli_fetch_assoc($resultado)){
                array_push($items, $fila);
            }

            $response = array(
                'success' => true,
                'resultado' => $items,
                'total' => COUNT($items)
            );
        }else{
            $response = array(
                'success'=>false,
                'error'=>'No se encontró el usuario seleccionado'
            );
        }
    }else{
        $response = array(
            'success'=>false,
            'error'=>mysqli_error($con)
        );
    }

    echo json_encode($response);
}catch(Exception $e){
    $response = array(
        'success'=>false,
        'error'=>'Error en la consulta: ' . $e->getMessage()
    );

    echo json_encode($response);
}

$con->close();
unset($response);

?>