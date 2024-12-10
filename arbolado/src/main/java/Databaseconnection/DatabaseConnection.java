/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author bsanc
 */
package Databaseconnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    // Parámetros de conexión
    private static final String URL = "jdbc:mysql://localhost:3306/sistema_arbolado?serverTimezone=UTC&useSSL=false";
    private static final String USER = "root";       // Cambia según tu configuración
    private static final String PASSWORD = "";       // Cambia según tu configuración

    /**
     * Método para obtener una conexión a la base de datos MySQL.
     *
     * @return Connection - objeto de conexión a la base de datos
     * @throws SQLException si hay un error en la conexión
     */
    public static Connection getConnection() throws SQLException {
        try {
            // Cargar el driver de MySQL
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver MySQL no encontrado", e);
        }

        // Establecer y retornar la conexión
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
