<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel del Coordinador</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <header class="bg-primary text-white text-center py-4">
        <h1 class="mb-0">Bienvenido, Coordinador</h1>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a href="dashboard.jsp" class="nav-link">Dashboard</a></li>
                <li class="nav-item"><a href="gestionUsuarios.jsp" class="nav-link">Gestión de Usuarios</a></li>
                <li class="nav-item"><a href="gestionArboles.jsp" class="nav-link">Gestión de Árboles</a></li>
                <li class="nav-item"><a href="historial.jsp" class="nav-link">Historial</a></li>
                <li class="nav-item"><a href="logout" class="nav-link">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
    <main class="container mt-5">
        <h2 class="text-center">Estadísticas del Sistema</h2>

        <div class="stats mt-5">
            <div class="mb-4">
                <h4 class="text-center">Estado de Salud de los Árboles</h4>
                <canvas id="estadoSaludChart"></canvas>
            </div>
            <div class="mb-4">
                <h4 class="text-center">Usuarios Registrados por Rol</h4>
                <canvas id="usuariosRolChart"></canvas>
            </div>
        </div>
    </main>

    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">Sistema de Gestión de Árboles © 2024</p>
    </footer>

    <!-- Script para Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Cargar datos dinámicos desde el servlet
        fetch('/estadisticas')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al obtener las estadísticas');
                }
                return response.json();
            })
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
            .catch(error => {
                console.error('Error cargando estadísticas:', error);
                alert("Hubo un problema al cargar las estadísticas. Inténtelo más tarde.");
            });
    </script>
</body>
</html>
