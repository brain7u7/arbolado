<%-- 
    Document   : brigadista
    Created on : 21 nov 2024, 1:04:27 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Brigadista</title>
    <link rel="stylesheet" href="styles.css">
    
    <% if (request.getParameter("success") != null) { %>
    <p class="success">Árbol registrado correctamente.</p>
<% } else if ("validacion".equals(request.getParameter("error"))) { %>
    <p class="error">Todos los campos obligatorios deben estar completos.</p>
<% } else if ("bd".equals(request.getParameter("error"))) { %>
    <p class="error">Hubo un problema al registrar el árbol. Inténtalo de nuevo.</p>
<% } %>

<style>
    .success {
        color: green;
        font-weight: bold;
    }
    .error {
        color: red;
        font-weight: bold;
    }
</style>

</head>
<body>
    <header>
        <h1>Bienvenido, Brigadista</h1>
        <nav>
            <ul>
                <li><a href="inicioBrigadista.jsp">Inicio</a></li>
                <li><a href="registroArboles.jsp">Registrar Árbol</a></li>
                <li><a href="consultaArboles.jsp">Consultar Árboles</a></li>
                <li><a href="logout">Cerrar Sesión</a></li>
            </ul>
        </nav>
    </header>
    <main>
        <h2>Registro de Árboles</h2>
        <form action="registrarArbol" method="post" onsubmit="return validarFormulario()">
    <input type="text" name="nombreComun" id="nombreComun" placeholder="Nombre Común" required>
    <input type="text" name="nombreCientifico" id="nombreCientifico" placeholder="Nombre Científico">
    <input type="text" name="ubicacion" id="ubicacion" placeholder="Ubicación" required>
    <select name="estadoSalud" id="estadoSalud" required>
        <option value="">Seleccione el estado de salud</option>
        <option value="bueno">Bueno</option>
        <option value="regular">Regular</option>
        <option value="malo">Malo</option>
    </select>
    <button type="submit">Registrar Árbol</button>
</form>

<script>
    function validarFormulario() {
        const nombreComun = document.getElementById("nombreComun").value.trim();
        const ubicacion = document.getElementById("ubicacion").value.trim();
        const estadoSalud = document.getElementById("estadoSalud").value;

        if (nombreComun === "") {
            alert("El nombre común del árbol es obligatorio.");
            return false;
        }

        if (ubicacion === "") {
            alert("La ubicación es obligatoria.");
            return false;
        }

        if (estadoSalud === "") {
            alert("Debe seleccionar el estado de salud.");
            return false;
        }

        return true;
    }
    
</script>

    </main>
</body>
</html>

