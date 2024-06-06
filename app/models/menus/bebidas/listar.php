<?php

require '../../sql/conexion.php';

$params = $_POST;

// Parámetros desde el datatable
$params['limit'] = $params['length'];
$params['order_column'] = $params['columns'][$params['order'][0]['column']]['data'];
$params['order'] = $params['order'][0]['dir'];
$params['query'] = ($params['search']['value'] != "") ? "%" . $params['search']['value'] . "%" : "%";

// Consulta SQL con INNER JOIN
$sql = "
    SELECT
        @numero:=@numero+1,
        b.idbebida,
        tb.nombre_bebida as bebida, 
        b.precio, 
        b.cantidad,  
        b.estado
    FROM 
        `mydb`.`bebida` b
    INNER JOIN 
        `mydb`.`tipo_bebida` tb ON b.idtipo_bebida = tb.idtipo_bebida
    WHERE
        b.estado = '1' AND tb.nombre_bebida LIKE '$params[query]'
    ORDER BY 
        " . $params['order_column'] . " " . $params['order'] . 
    " LIMIT " . $params['start'] . ", " . $params['limit'];

$select_bebidas = mysqli_query($con, $sql);

// Consulta para el conteo total de registros
$sql_count = "
    SELECT COUNT(*) as total
    FROM 
        `mydb`.`bebida` b
    INNER JOIN 
        `mydb`.`tipo_bebida` tb ON b.idtipo_bebida = tb.idtipo_bebida
    WHERE
        b.estado = '1' AND tb.nombre_bebida LIKE '$params[query]'";

$select_conteo = mysqli_query($con, $sql_count);

$response = array();
$response['data'] = array();
$response['params'] = $params;

if (mysqli_num_rows($select_bebidas) > 0) {
    while ($fila = mysqli_fetch_assoc($select_bebidas)) {
        $response['data'][] = array(
            'numero'=> $fila['numero'],
            'idbebida'=> $fila['idbebida'],
            'cantidad' => $fila['cantidad'],
            'bebida' => $fila['bebida'],
            'precio' => $fila['precio'],
            'estado' => $fila['estado'] == 1? 'Activo' : 'Inactivo'
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