<?php

require '../../sql/conexion.php';

try {

    $params = $_POST;
    $response = array();

    $sql = "SELECT b.idbebida, b.cantidad, b.precio, tb.idtipo_bebida, tb.nombre_bebida
            FROM bebida b
            INNER JOIN tipo_bebida tb ON b.idtipo_bebida = tb.idtipo_bebida
            WHERE b.idbebida = '$params[idbebida]' AND b.estado = '1'";

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
                'error' => 'No se encontró la bebida seleccionada'
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