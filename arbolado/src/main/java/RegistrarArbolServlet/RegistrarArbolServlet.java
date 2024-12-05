/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author bsanc
 */
package RegistrarArbolServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import Databaseconnection.DatabaseConnection;

@WebServlet("/registrarArbol")
public class RegistrarArbolServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombreComun = request.getParameter("nombreComun");
        String nombreCientifico = request.getParameter("nombreCientifico");
        String ubicacion = request.getParameter("ubicacion");
        String estadoSalud = request.getParameter("estadoSalud");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "INSERT INTO arboles (nombre_comun, nombre_cientifico, ubicacion, estado_salud, registrado_por) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, nombreComun);
            stmt.setString(2, nombreCientifico);
            stmt.setString(3, ubicacion);
            stmt.setString(4, estadoSalud);
            stmt.setInt(5, (Integer) request.getSession().getAttribute("user_id"));

            stmt.executeUpdate();
            response.sendRedirect("brigadista.jsp?success=1");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("brigadista.jsp?error=1");
        }
    }
}
