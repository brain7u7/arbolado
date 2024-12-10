<%-- 
    Document   : error
    Created on : 2 dic 2024, 2:18:48 p.m.
    Author     : bsanc
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %>
<%@ taglib uri="http://xmlns.jcp.org/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error</title>
    <link rel="stylesheet" href="styles.css">
</head>
<body>
    <div class="error-container">
        <h1>Ha ocurrido un error</h1>
        <p>Ocurrió un problema inesperado. Por favor, inténtalo más tarde.</p>
        
        <c:if test="${pageContext.errorData.throwable != null}">
            <p><strong>Detalles técnicos:</strong> <c:out value="${pageContext.errorData.throwable.message}" /></p>
        </c:if>

        <a href="javascript:history.back()" class="btn btn-secondary">Volver</a>
        <a href="login.jsp" class="btn btn-primary">Ir al Inicio</a>
    </div>
</body>
</html>

