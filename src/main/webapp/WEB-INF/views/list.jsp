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
<c:forEach var="emp" items="employees">l̥
            <table border="1">
<thead>
<tr>
<th>id</th>
<th>name</th>
<th>email</th>
<th>department</th>
<th>salary</th>
<th>designation</th>
</tr>
</thead>
<tbody>
<tr>
<td>${emp.id}</td>
<td>${emp.name}</td>
<td>${emp.email}</td>
<td>${emp.department}</td>
<td>${emp.salary}</td>
<td>${emp.designation}</td>
</tr>
</tbody>
</table>

</c:forEach>
    </body>
</html>
