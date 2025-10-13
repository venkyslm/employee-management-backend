<%-- 
    Document   : header
    Created on : 13-Oct-2025, 4:03:22 pm
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="<c:url value="/resources/css/header.css" />" />
<!--        <title>JSP Page</title>-->
    </head>
    <body>
        <nav>
            <div class="logo">MyLogo</div>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/">About</a></li>
                <li><a href="/">Contact us</a></li>
            </ul>
        </nav>
    </body>
</html>
