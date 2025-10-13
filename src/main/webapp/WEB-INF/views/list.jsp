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
        <link rel="stylesheet" href="<c:url value='/resources/css/list.css' />">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <title>Home Page</title>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        
        <h1>Employee Management</h1>
        
        <!--Search Inputs-->
        <div>
        <input type="text" id="name" placeholder="Name" >
        <input type="text" id="email" placeholder="Email">
        <input type="text" id="department" placeholder="Department">
        <input type="text" id="designation" placeholder="Desingation">
        <button id="searchBtn">Search</button>
        </div>

        <br/>
        
        <a href="/addEmployee">
            <button>Add Employee</button>
        </a> <br/>
        
        <c:if test="${not empty employees}">
            <table id="employeeTable" border="1">
                <thead>
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>email</th>
                    <th>department</th>
                    <th>salary</th>
                    <th>designation</th>
                    <th>Options</th>
                </tr>
                </thead>

                <tbody id="employeeTableBody">
                <c:forEach var="emp" items="${employees}">
                <tr>
                    <td>${emp.id}</td>
                    <td>${emp.name}</td>
                    <td>${emp.email}</td>
                    <td>${emp.department}</td>
                    <td>${emp.salary}</td>
                    <td>${emp.designation}</td>
                    <td>
                        <button>Edit</button>
                        <button>Delete</button>
                    </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:if>
        
        <c:if test="${empty employees}">
            <p id="noDataMsg">No employees found. Please add some!</p>
        </c:if>
        
        <!--Ajax Call to REST endpoint-->
        
    </body>
</html>
