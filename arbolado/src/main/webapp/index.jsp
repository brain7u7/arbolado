<%-- 
    Document   : index
    Created on : 21 nov 2024, 1:02:11 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="login-container">
        <h1>Iniciar Sesión</h1>
        <form action="login" method="post">
            <input type="email" name="email" placeholder="Correo electrónico" required>
            <input type="password" name="password" placeholder="Contraseña" required>
            <button type="submit">Ingresar</button>
        </form>
        <% if (request.getParameter("error") != null) { %>
            <p class="error">Credenciales incorrectas. Inténtalo de nuevo.</p>
        <% } %>
    </div>
</body>
</html>










