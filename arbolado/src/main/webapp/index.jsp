<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sistema de Gestión de Árboles</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <!-- Header -->
    <header class="bg-primary text-white text-center py-4">
        <h1 class="mb-0">Sistema de Gestión de Árboles</h1>
    </header>

    <!-- Main Content -->
    <main class="container mt-5">
        <div class="text-center">
            <c:choose>
                <c:when test="${not empty sessionScope.user_name}">
                    <p class="lead">Bienvenido, <span class="font-weight-bold"><c:out value="${sessionScope.user_name}" /></span>.</p>
                    <p class="lead">Tu rol: <span class="font-italic text-info"><c:out value="${sessionScope.user_role}" /></span></p>
                    <c:choose>
                        <c:when test="${sessionScope.user_role == 'coordinador'}">
                            <a href="coordinador.jsp" class="btn btn-primary btn-lg">Panel del Coordinador</a>
                        </c:when>
                        <c:when test="${sessionScope.user_role == 'brigadista'}">
                            <a href="brigadista.jsp" class="btn btn-primary btn-lg">Panel del Brigadista</a>
                        </c:when>
                        <c:when test="${sessionScope.user_role == 'visitante'}">
                            <a href="consultaPublica.jsp" class="btn btn-primary btn-lg">Consulta Pública</a>
                        </c:when>
                        <c:otherwise>
                            <p class="text-danger">No se reconoce tu rol. Contacta al administrador.</p>
                        </c:otherwise>
                    </c:choose>
                    <a href="logout" class="btn btn-danger mt-3">Cerrar Sesión</a>
                </c:when>
                <c:otherwise>
                    <p class="lead">No has iniciado sesión. Por favor, <a href="login.jsp" class="btn btn-primary btn-lg">inicia sesión aquí</a>.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </main>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">Sistema de Gestión de Árboles © 2024</p>
        <small>
            <a href="contacto.jsp" class="text-white">Contacto</a> | 
            <a href="terminos.jsp" class="text-white">Términos de Uso</a>
        </small>
    </footer>

    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
