<?php

require '../sql/conexion.php';

$params = $_POST;

// Parámetros desde el datatable
$params['limit'] = $params['length'];
$params['order_column'] = $params['columns'][$params['order'][0]['column']]['data'];
$params['order'] = $params['order'][0]['dir'];
$params['query'] = ($params['search']['value'] != "") ? "%" . $params['search']['value'] . "%" : "%";

// Consulta SQL con INNER JOIN
$sql = "
    SELECT @numero:=@numero+1,
        u.idusuario,
        u.nombre_usuario as usuario, 
        u.fecha_creacion, 
        r.nombre_rol AS rol, 
        r.descripcion
    FROM 
        `mydb`.`usuario` u
    INNER JOIN 
        `mydb`.`rol_usuario` ru ON u.idusuario = ru.usuario_idusuario
    INNER JOIN 
        `mydb`.`rol` r ON ru.idrol = r.idrol
    WHERE
        u.nombre_usuario LIKE '$params[query]' AND u.estado = '1'
    ORDER BY 
        " . $params['order_column'] . " " . $params['order'] . 
    " LIMIT " . $params['start'] . ", " . $params['limit'];

$select_usuarios = mysqli_query($con, $sql);

// Consulta para el conteo total de registros
$sql_count = "
    SELECT COUNT(*) as total
    FROM 
        `mydb`.`usuario` u
    INNER JOIN 
        `mydb`.`rol_usuario` ru ON u.idusuario = ru.usuario_idusuario
    INNER JOIN 
        `mydb`.`rol` r ON ru.idrol = r.idrol
    WHERE
        u.nombre_usuario LIKE '$params[query]'";

$select_conteo = mysqli_query($con, $sql_count);

$response = array();
$response['data'] = array();
$response['params'] = $params;

/*if (mysqli_num_rows($select_usuarios) > 0) {
    while ($fila = mysqli_fetch_assoc($select_usuarios)) {
        $response['data'][] = array(
            'numero'=> $fila['numero'],
            'idusuario'=> $fila['idusuario'],
            'usuario' => $fila['usuario'],
            'fecha_creacion' => $fila['fecha_creacion'],
            'rol' => $fila['rol'],
            'descripcion' => $fila['descripcion']
        );
    }
}*/

if (mysqli_num_rows($select_usuarios) > 0) {
    $usuarios = array();
    while ($fila = mysqli_fetch_assoc($select_usuarios)) {
        if (!isset($usuarios[$fila['idusuario']])) {
            $usuarios[$fila['idusuario']] = array(
                'numero' => $fila['numero'],
                'idusuario' => $fila['idusuario'],
                'usuario' => $fila['usuario'],
                'fecha_creacion' => $fila['fecha_creacion'],
                'rol' => $fila['rol'],
                'descripcion' => $fila['descripcion']
            );
        }
    }
    $response['data'] = array_values($usuarios);
}

if (mysqli_num_rows($select_conteo) > 0) {
    $fila = mysqli_fetch_assoc($select_conteo);
    $total = intval($fila['total']);
} else {
    $total = 0;
}

$response['recordsTotal'] = $total;
$response['recordsFiltered'] = $total;
$response['success'] = true;

echo json_encode($response);

$con->close();
?>