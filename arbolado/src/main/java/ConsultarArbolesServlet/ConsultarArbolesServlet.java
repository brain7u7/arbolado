/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author bsanc
 */
package ConsultarArbolesServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Databaseconnection.DatabaseConnection;

@WebServlet("/consultarArboles")
public class ConsultarArbolesServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM arboles";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            StringBuilder arboles = new StringBuilder();
            while (rs.next()) {
                arboles.append(rs.getString("nombre_comun")).append(", ")
                        .append(rs.getString("ubicacion")).append(", ")
                        .append(rs.getString("estado_salud")).append("<br>");
            }

            response.setContentType("text/html");
            response.getWriter().write(arboles.toString());
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error en la base de datos.");
        }
    }
}
