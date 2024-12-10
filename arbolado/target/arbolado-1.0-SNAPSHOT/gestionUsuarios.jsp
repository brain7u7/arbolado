<%-- 
    Document   : gestionUsuarios
    Created on : 9 dic 2024, 8:39:31 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Usuarios</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <h1>Gestión de Usuarios</h1>

    <!-- Formulario para agregar usuario -->
    <h2>Agregar Usuario</h2>
    <form action="gestionUsuarios" method="post">
        <input type="hidden" name="action" value="add">
        <input type="text" name="nombre" placeholder="Nombre" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="password" name="password" placeholder="Contraseña" required>
        <select name="rol" required>
            <option value="coordinador">Coordinador</option>
            <option value="brigadista">Brigadista</option>
            <option value="visitante">Visitante</option>
        </select>
        <button type="submit">Agregar Usuario</button>
    </form>

    <!-- Listado de usuarios -->
    <h2>Lista de Usuarios</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Email</th>
            <th>Rol</th>
            <th>Acciones</th>
        </tr>
        <%
            try (Connection conn = Databaseconnection.DatabaseConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM usuarios")) {
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("nombre") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("rol") %></td>
            <td>
                <form action="gestionUsuarios" method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" onclick="return confirm('¿Estás seguro de eliminar este usuario?')">Eliminar</button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="5">Error al cargar los usuarios.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>

