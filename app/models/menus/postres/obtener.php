<?php

require '../../sql/conexion.php';

try {

    $params = $_POST;
    $response = array();

    $sql = "SELECT p.idpostre, p.nombre_postre as postre, p.descripcion, p.precio, p.estado
            FROM postre p
            WHERE p.idpostre = '$params[idpostre]' AND p.estado = '1'";

    $resultado = mysqli_query($con, $sql);

    if ($resultado) {
        if (mysqli_num_rows($resultado) > 0) {
            $items = array();
            while ($fila = mysqli_fetch_assoc($resultado)) {
                array_push($items, $fila);
            }

            $response = array(
                'success' => true,
                'resultado' => $items,
                'total' => COUNT($items)
            );
        } else {
            $response = array(
                'success' => false,
                'error' => 'No se encontró el postre seleccionado'
            );
        }
    } else {
        $response = array(
            'success' => false,
            'error' => mysqli_error($con)
        );
    }

    echo json_encode($response);
} catch (Exception $e) {
    $response = array(
        'success' => false,
        'error' => 'Error en la consulta: ' . $e->getMessage()
    );

    echo json_encode($response);
}

$con->close();
unset($response);

?>