/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package LoginServlet;

/**
 *
 * @author bsanc
 */


import java.io.Serializable;

/**
 * Clase Usuario que encapsula los datos del usuario autenticado.
 */
public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;

    private final String nombre;
    private final String rol;

    /**
     * Constructor que inicializa el usuario con nombre y rol.
     * 
     * @param nombre El nombre del usuario.
     * @param rol El rol del usuario (por ejemplo, coordinador, brigadista, visitante).
     */
    public Usuario(String nombre, String rol) {
        this.nombre = nombre;
        this.rol = rol;
    }

    /**
     * Obtiene el nombre del usuario.
     * 
     * @return El nombre del usuario.
     */
    public String getNombre() {
        return nombre;
    }

    /**
     * Obtiene el rol del usuario.
     * 
     * @return El rol del usuario.
     */
    public String getRol() {
        return rol;
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "nombre='" + nombre + '\'' +
                ", rol='" + rol + '\'' +
                '}';
    }
}

