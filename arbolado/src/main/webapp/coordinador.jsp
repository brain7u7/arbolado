<%-- 
    Document   : coordinador
    Created on : 21 nov 2024, 1:03:36 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Coordinador</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Bienvenido, Coordinador</h1>
        <nav>
            <ul>
                <li><a href="dashboard.jsp">Dashboard</a></li>
                <li><a href="gestionUsuarios.jsp">Gestión de Usuarios</a></li>
                <li><a href="gestionArboles.jsp">Gestión de Árboles</a></li>
                <li><a href="historial.jsp">Historial</a></li>
                <li><a href="logout">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h2>Estadísticas del Sistema</h2>
        <div class="stats">
            <div>Usuarios Registrados: <span id="usuarios">0</span></div>
            <div>Árboles Censados: <span id="arboles">0</span></div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <script>
    // Cargar datos dinámicos desde el servlet
    fetch('/estadisticas')
        .then(response => response.json())
        .then(data => {
            // Datos de árboles
            const estadoSaludData = {
                labels: ['Bueno', 'Regular', 'Malo'],
                datasets: [{
                    label: 'Cantidad de Árboles',
                    data: [
                        data.arboles.bueno || 0,
                        data.arboles.regular || 0,
                        data.arboles.malo || 0
                    ],
                    backgroundColor: ['#4CAF50', '#FFC107', '#F44336'],
                }]
            };

            // Datos de usuarios
            const usuariosRolData = {
                labels: ['Coordinador', 'Brigadista', 'Visitante'],
                datasets: [{
                    label: 'Usuarios',
                    data: [
                        data.usuarios.coordinador || 0,
                        data.usuarios.brigadista || 0,
                        data.usuarios.visitante || 0
                    ],
                    backgroundColor: ['#007BFF', '#28A745', '#FFC107'],
                }]
            };

            // Crear gráficos
            const ctx1 = document.getElementById('estadoSaludChart').getContext('2d');
            new Chart(ctx1, {
                type: 'bar',
                data: estadoSaludData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: true },
                        tooltip: { enabled: true }
                    }
                }
            });

            const ctx2 = document.getElementById('usuariosRolChart').getContext('2d');
            new Chart(ctx2, {
                type: 'pie',
                data: usuariosRolData,
                options: {
                    responsive: true,
                    plugins: {
                        legend: { display: true },
                        tooltip: { enabled: true }
                    }
                }
            });
        })
        .catch(error => console.error('Error cargando estadísticas:', error));
</script>

</body>
</html>