<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="taglibs.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">

    <!-- Page-specific title (default if not overridden) -->
    <title>${pageTitle != null ? pageTitle : 'My Application'}</title>

    <!-- Header CSS -->
    <link rel="stylesheet" href="<c:url value='/resources/css/header.css' />" >

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

    <!-- Allow page-specific CSS -->
    ${pageCSS}
</head>

<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light p-3 shadow-sm">
    <a class="navbar-brand" href="#">MyLogo</a>

    <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="/">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="/">About</a></li>
        <li class="nav-item"><a class="nav-link" href="/">Contact Us</a></li>
    </ul>
</nav>
