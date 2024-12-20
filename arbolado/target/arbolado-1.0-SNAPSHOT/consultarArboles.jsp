<%-- 
    Document   : consultarArboles
    Created on : 21 nov 2024, 1:17:36 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Consulta de Árboles</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <header>
        <h1>Consulta de Árboles</h1>
        <a href="brigadista.jsp">Volver</a>
    </header>
    <main>
        <table>
            <thead>
                <tr>
                    <th>Nombre Común</th>
                    <th>Nombre Científico</th>
                    <th>Ubicación</th>
                    <th>Estado de Salud</th>
                </tr>
            </thead>
            <tbody>
                <%
                    ResultSet arboles = (ResultSet) request.getAttribute("arboles");
                    while (arboles != null && arboles.next()) {
                %>
                <tr>
                    <td><%= arboles.getString("nombre_comun") %></td>
                    <td><%= arboles.getString("nombre_cientifico") %></td>
                    <td><%= arboles.getString("ubicacion") %></td>
                    <td><%= arboles.getString("estado_salud") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </main>
</body>
</html>

