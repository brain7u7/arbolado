<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session == null || session.getAttribute("user_name") == null) {
        response.sendRedirect("login.jsp?error=No%20autorizado");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consulta Pública</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
    <header class="bg-primary text-white p-3">
        <h1 class="text-center">Bienvenido, <c:out value="${sessionScope.user_name}" /></h1>
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item"><a href="consultaPublica.jsp" class="nav-link">Inicio</a></li>
                <li class="nav-item"><a href="contacto.jsp" class="nav-link">Contacto</a></li>
                <li class="nav-item"><a href="logout" class="nav-link">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
    <main class="container mt-5">
        <h2 class="text-center">Árboles Censados</h2>
        <c:if test="${not empty arboles}">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Nombre Común</th>
                        <th>Ubicación</th>
                        <th>Estado de Salud</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="arbol" items="${arboles}">
                        <tr>
                            <td><c:out value="${arbol.nombreComun}" /></td>
                            <td><c:out value="${arbol.ubicacion}" /></td>
                            <td><c:out value="${arbol.estadoSalud}" /></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${empty arboles}">
            <div class="alert alert-info">
                No se encontraron registros de árboles.
            </div>
        </c:if>
    </main>
</body>
</html>
