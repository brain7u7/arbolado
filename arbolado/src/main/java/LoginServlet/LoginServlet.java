/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
/**
 *
 * @author bsanc
 */
package LoginServlet;

import Databaseconnection.DatabaseConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(LoginServlet.class.getName());

    private static final String COORDINADOR_PAGE = "coordinador.jsp";
    private static final String BRIGADISTA_PAGE = "brigadista.jsp";
    private static final String VISITANTE_PAGE = "consultaPublica.jsp";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (!validarEntradas(email, password, response)) {
            return;
        }

        try (Connection conn = DatabaseConnection.getConnection()) {
            Usuario usuario = autenticarUsuario(conn, email, password);

            if (usuario != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user_name", usuario.getNombre());
                session.setAttribute("user_role", usuario.getRol());
                session.setMaxInactiveInterval(30 * 60); // 30 minutos de sesión
                LOGGER.log(Level.INFO, "Usuario autenticado: {0}, Rol: {1}", new Object[]{usuario.getNombre(), usuario.getRol()});
                redirigirSegunRol(usuario.getRol(), response);
            } else {
                LOGGER.log(Level.WARNING, "Intento de inicio de sesión fallido para el correo: {0}", email);
                response.sendRedirect("login.jsp?error=Usuario%20o%20contrase%C3%B1a%20inv%C3%A1lidos");
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error interno durante el inicio de sesión", e);
            response.sendRedirect("login.jsp?error=Ocurri%C3%B3%20un%20error%20interno");
        }
    }

    private boolean validarEntradas(String email, String password, HttpServletResponse response) throws IOException {
        if (email == null || email.isEmpty() || !email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            response.sendRedirect("login.jsp?error=Correo%20inv%C3%A1lido");
            return false;
        }
        if (password == null || password.isEmpty()) {
            response.sendRedirect("login.jsp?error=Contrase%C3%B1a%20inv%C3%A1lida");
            return false;
        }
        return true;
    }

    private Usuario autenticarUsuario(Connection conn, String email, String password) throws SQLException {
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                            rs.getString("nombre"),
                            rs.getString("rol")
                    );
                }
            }
        }
        return null;
    }

    private void redirigirSegunRol(String rol, HttpServletResponse response) throws IOException {
        switch (rol) {
            case "coordinador" -> response.sendRedirect(COORDINADOR_PAGE);
            case "brigadista" -> response.sendRedirect(BRIGADISTA_PAGE);
            case "visitante" -> response.sendRedirect(VISITANTE_PAGE);
            default -> {
                LOGGER.log(Level.WARNING, "Rol desconocido: {0}", rol);
                response.sendRedirect("login.jsp?error=Rol%20desconocido");
            }
        }
    }
}
