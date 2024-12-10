<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel del Brigadista</title>
    <link rel="stylesheet" href="styles.css">

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

        <!-- Mensajes de éxito o error -->
        <c:if test="${param.success != null}">
            <p class="success">Árbol registrado correctamente.</p>
        </c:if>
        <c:if test="${param.error == 'validacion'}">
            <p class="error">Todos los campos obligatorios deben estar completos.</p>
        </c:if>
        <c:if test="${param.error == 'bd'}">
            <p class="error">Hubo un problema al registrar el árbol. Inténtalo de nuevo.</p>
        </c:if>

        <!-- Formulario de registro -->
        <form action="registrarArbol" method="post" onsubmit="return validarFormulario()">
            <div class="form-group">
                <label for="nombreComun">Nombre Común *</label>
                <input type="text" name="nombreComun" id="nombreComun" placeholder="Nombre Común" required maxlength="100" class="form-control">
            </div>
            <div class="form-group">
                <label for="nombreCientifico">Nombre Científico</label>
                <input type="text" name="nombreCientifico" id="nombreCientifico" placeholder="Nombre Científico" maxlength="100" class="form-control">
            </div>
            <div class="form-group">
                <label for="ubicacion">Ubicación *</label>
                <input type="text" name="ubicacion" id="ubicacion" placeholder="Ubicación" required maxlength="150" class="form-control">
            </div>
            <div class="form-group">
                <label for="estadoSalud">Estado de Salud *</label>
                <select name="estadoSalud" id="estadoSalud" required class="form-control">
                    <option value="">Seleccione el estado de salud</option>
                    <option value="bueno">Bueno</option>
                    <option value="regular">Regular</option>
                    <option value="malo">Malo</option>
                </select>
            </div>
            <button type="submit" class="btn btn-success">Registrar Árbol</button>
        </form>

    </main>

    <script>
        function validarFormulario() {
            const nombreComun = document.getElementById("nombreComun").value.trim();
            const ubicacion = document.getElementById("ubicacion").value.trim();
            const estadoSalud = document.getElementById("estadoSalud").value;

            if (!nombreComun) {
                alert("El nombre común del árbol es obligatorio.");
                return false;
            }

            if (!ubicacion) {
                alert("La ubicación es obligatoria.");
                return false;
            }

            if (!estadoSalud) {
                alert("Debe seleccionar el estado de salud.");
                return false;
            }

            return true;
        }
    </script>
</body>
</html>


