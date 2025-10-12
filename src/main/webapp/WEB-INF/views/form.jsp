<%-- 
    Document   : form
    Created on : 12-Oct-2025, 5:17:40 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Add Employee</h1>
        <form:form modelAttribute="employee" action="/addEmployee" method="POST">
            <div>
            <form:label path="name">Name:</form:label>
            <form:input path="name" />
            </div>
         
            <div>
            <form:label path="email">Email:</form:label>
            <form:input path="email" />
            </div>
            
            <div>
            <form:label path="department">Department:</form:label>
            <form:input path="department" />
            </div>
            
            <div>
            <form:label path="salary">Salary:</form:label>
            <form:input path="salary" />
            </div>
            
            <div>
            <form:label path="designation">Designation:</form:label>
            <form:input path="designation" />
            </div>
            
            <input type="submit" value="Add Employee" />
        </form:form>
        <a href="/">Home Page</a>
    </body>
</html>
