<?php
$servername = "localhost";
$username = "root"; // Cambia esto por tu usuario de MySQL
$password = "tu_contraseña"; // Cambia esto por tu contraseña de MySQL
$dbname = "mydb"; // Nombre de la base de datos

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Conexión fallida: " . $conn->connect_error);
}

// Obtener el ID del cargo desde la consulta GET
$id = isset($_GET['id']) ? intval($_GET['id']) : 0;

// Consulta para obtener los datos de la tabla cargo para el ID especificado
$sql = "SELECT nombre_cargo, descripcion FROM cargo WHERE idcargo = ? AND estado = '1'";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $id);
$stmt->execute();
$result = $stmt->get_result();

// Crear un array para almacenar los resultados
$cargos = array();

if ($result->num_rows > 0) {
    // Obtener cada fila de resultado y añadirla al array
    while($row = $result->fetch_assoc()) {
        $cargos[] = $row;
    }
}

// Convertir el array a formato JSON y devolverlo
echo json_encode($cargos);

// Cerrar la conexión
$stmt->close();
$conn->close();
?>
