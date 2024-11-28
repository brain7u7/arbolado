/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author bsanc
 */
package LoginServlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import Databaseconnection.DatabaseConnection;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("LoginServlet invoked");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try (Connection conn = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM usuarios WHERE email = ? AND password = MD5(?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            stmt.setString(2, password);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("user_id", rs.getInt("id"));
                session.setAttribute("user_name", rs.getString("nombre"));
                session.setAttribute("user_role", rs.getString("rol"));

                String role = rs.getString("rol");
                switch (role) {
                    case "coordinador" -> response.sendRedirect("coordinador.jsp");
                    case "brigadista" -> response.sendRedirect("brigadista.jsp");
                    case "visitante" -> response.sendRedirect("visitante.jsp");
                }
            } else {
                response.sendRedirect("index.jsp?error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("index.jsp?error=2");
        }
    }
}