/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author bsanc
 */

package EstadisticasServlet;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;
import com.google.gson.Gson;
import Databaseconnection.DatabaseConnection;


@WebServlet("/estadisticas")
public class EstadisticasServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Estadísticas de árboles por estado de salud
            String sqlArboles = "SELECT estado_salud, COUNT(*) AS cantidad FROM arboles GROUP BY estado_salud";
            PreparedStatement stmtArboles = conn.prepareStatement(sqlArboles);
            ResultSet rsArboles = stmtArboles.executeQuery();

            Map<String, Integer> arbolesData = new HashMap<>();
            while (rsArboles.next()) {
                arbolesData.put(rsArboles.getString("estado_salud"), rsArboles.getInt("cantidad"));
            }

            // Estadísticas de usuarios por rol
            String sqlUsuarios = "SELECT rol, COUNT(*) AS cantidad FROM usuarios GROUP BY rol";
            PreparedStatement stmtUsuarios = conn.prepareStatement(sqlUsuarios);
            ResultSet rsUsuarios = stmtUsuarios.executeQuery();

            Map<String, Integer> usuariosData = new HashMap<>();
            while (rsUsuarios.next()) {
                usuariosData.put(rsUsuarios.getString("rol"), rsUsuarios.getInt("cantidad"));
            }

            // Convertir los datos a JSON
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            out.print("{");
            out.print("\"arboles\": " + new Gson().toJson(arbolesData) + ",");
            out.print("\"usuarios\": " + new Gson().toJson(usuariosData));
            out.print("}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
