/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author bsanc
 */
package RegistrarArbolServlet;

import Databaseconnection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/registrarArbol")
public class RegistrarArbolServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreComun = request.getParameter("nombreComun");
        String nombreCientifico = request.getParameter("nombreCientifico");
        String ubicacion = request.getParameter("ubicacion");
        String estadoSalud = request.getParameter("estadoSalud");

        // Validar campos obligatorios
        if (nombreComun == null || nombreComun.isEmpty() || ubicacion == null || ubicacion.isEmpty() || estadoSalud == null || estadoSalud.isEmpty()) {
            response.sendRedirect("brigadista.jsp?error=validacion");
            return;
        }

        // Insertar en la base de datos y obtener el ID generado
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO arboles (nombre_comun, nombre_cientifico, ubicacion, estado_salud) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                stmt.setString(1, nombreComun);
                stmt.setString(2, nombreCientifico);
                stmt.setString(3, ubicacion);
                stmt.setString(4, estadoSalud);

                int affectedRows = stmt.executeUpdate();

                if (affectedRows > 0) {
                    try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            int idGenerado = generatedKeys.getInt(1);
                            System.out.println("Árbol registrado con ID: " + idGenerado);
                            response.sendRedirect("brigadista.jsp?success=true&id=" + idGenerado);
                        }
                    }
                } else {
                    response.sendRedirect("brigadista.jsp?error=bd");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("brigadista.jsp?error=bd");
        }
    }
}
