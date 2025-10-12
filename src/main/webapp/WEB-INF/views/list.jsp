<%-- 
    Document   : list
    Created on : 12-Oct-2025, 6:46:27 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Welcome to Student Management App!</h1>
        <a href="/addEmployee">Add Employee</a>
        <c:forEach var="emp" items="employees">
            
        </c:forEach>
    </body>
</html>
