/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author bsanc
 */
package GestionUsuariosServlet;

import Databaseconnection.DatabaseConnection;
import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/gestionUsuarios")
public class GestionUsuariosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Mostrar la lista de usuarios
        response.sendRedirect("gestionUsuarios.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try (Connection conn = DatabaseConnection.getConnection()) {
            if ("add".equals(action)) {
                String nombre = request.getParameter("nombre");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String rol = request.getParameter("rol");

                String sql = "INSERT INTO usuarios (nombre, email, password, rol) VALUES (?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, nombre);
                    stmt.setString(2, email);
                    stmt.setString(3, password);
                    stmt.setString(4, rol);
                    stmt.executeUpdate();
                }

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String sql = "DELETE FROM usuarios WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    stmt.executeUpdate();
                }
            }

            response.sendRedirect("gestionUsuarios.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("gestionUsuarios.jsp?error=bd");
        }
    }
}

