<%-- 
    Document   : visitante
    Created on : 21 nov 2024, 1:04:51 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta Pública</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Bienvenido, Visitante</h1>
        <nav>
            <ul>
                <li><a href="consultaPublica.jsp">Inicio</a></li>
                <li><a href="contacto.jsp">Contacto</a></li>
                <li><a href="logout">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h2>Árboles Censados</h2>
        <table>
            <thead>
                <tr>
                    <th>Nombre Común</th>
                    <th>Ubicación</th>
                    <th>Estado de Salud</th>
                </tr>
            </thead>
            <tbody>
                <!-- Los datos se cargarían dinámicamente desde la base de datos -->
                <tr>
                    <td>Roble</td>
                    <td>Parque Central</td>
                    <td>Bueno</td>
                </tr>
                <tr>
                    <td>Pino</td>
                    <td>Zona Norte</td>
                    <td>Regular</td>
                </tr>
            </tbody>
        </table>
    </main>
</body>
</html>