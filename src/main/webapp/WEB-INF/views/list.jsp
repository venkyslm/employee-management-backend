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
        <title>Home Page</title>
    </head>
    <body>
        <h1>Welcome to Student Management App!</h1>
        <a href="/addEmployee">Add Employee</a>
        
        <c:if test="${not empty employees}">
            <table border="1">
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>email</th>
                    <th>department</th>
                    <th>salary</th>
                    <th>designation</th>
                </tr>
                
                <c:forEach var="emp" items="${employees}">
                <tr>
                    <td>${emp.id}</td>
                    <td>${emp.name}</td>
                    <td>${emp.email}</td>
                    <td>${emp.department}</td>
                    <td>${emp.salary}</td>
                    <td>${emp.designation}</td>
                    </tr>
                </c:forEach>
            </table>
        </c:if>
        
        <c:if test="${empty employees}">
            <p>No employees found. Please add some!</p>
        </c:if>
    </body>
</html>
