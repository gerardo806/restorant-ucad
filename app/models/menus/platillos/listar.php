<?php

require '../../sql/conexion.php';

// Parámetros desde el datatable
$params = $_POST;
$params['limit'] = $params['length'];
$params['order_column'] = $params['columns'][$params['order'][0]['column']]['data'];
$params['order'] = $params['order'][0]['dir'];
$params['query'] = ($params['search']['value'] != "") ? "%" . $params['search']['value'] . "%" : "%";

// Consulta SQL para seleccionar todos los registros de la tabla platillo
$sql = "
    SELECT
        @numero:=@numero+1,
        idplatillo,
        nombre_platillo as platillo,
        descripcion,
        precio,
        estado
    FROM 
        `mydb`.`platillo`
    WHERE
        nombre_platillo LIKE '$params[query]' AND estado = '1'
    ORDER BY 
        " . $params['order_column'] . " " . $params['order'] . 
    " LIMIT " . $params['start'] . ", " . $params['limit'];

$select_platillos = mysqli_query($con, $sql);

// Consulta para el conteo total de registros
$sql_count = "
    SELECT COUNT(*) as total
    FROM 
        `mydb`.`platillo`
    WHERE
        nombre_platillo LIKE '$params[query]'";

$select_conteo = mysqli_query($con, $sql_count);

$response = array();
$response['data'] = array();
$response['params'] = $params;

if (mysqli_num_rows($select_platillos) > 0) {
    while ($fila = mysqli_fetch_assoc($select_platillos)) {
        $response['data'][] = array(
            'numero'=> $fila['numero'],
            'idplatillo' => $fila['idplatillo'],
            'platillo' => $fila['platillo'],
            'descripcion' => $fila['descripcion'],
            'precio' => $fila['precio'],
            'estado' => $fila['estado'] == '1'? 'Activo' : 'Inactivo'
        );
    }
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