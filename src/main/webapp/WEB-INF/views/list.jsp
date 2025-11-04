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
    <tbody id="employeeTableBody"></tbody>
</table>
        
<div id="paginationControls">
    <button id="prevPage">Previous</button>
    <span id="pageInfo"></span>
    <button id="nextPage">Next</button>
</div>

<p id="noDataMsg">No employees found. Please add some!</p>
            
        
        <!-- 🔧 AJAX Script -->
<script>
$(document).ready(function () {
    let currentPage = 0;
    const pageSize = 5;
    let lastSearch = {}; // store last search filters

    // Function to render table
    function renderTable(data) {
        let rows = "";
        if (!data.content || data.content.length === 0) {
            $("#employeeTableBody").html("");
            $("#noDataMsg").show();
        } else {
            $("#noDataMsg").hide();
            data.content.forEach(emp => {
                rows +=
                    "<tr>" +
                    "<td>" + emp.id + "</td>" +
                    "<td>" + emp.name + "</td>" +
                    "<td>" + emp.email + "</td>" +
                    "<td>" + emp.department + "</td>" +
                    "<td>" + emp.salary + "</td>" +
                    "<td>" + emp.designation + "</td>" +
                    "<td><button>Edit</button><button>Delete</button></td>" +
                    "</tr>";
            });
            $("#employeeTableBody").html(rows);

            $("#pageInfo").text("Page " + (data.number + 1) + " of " + data.totalPages);
            $("#prevPage").prop("disabled", data.number === 0);
            $("#nextPage").prop("disabled", data.number + 1 === data.totalPages);
        }
    }

    // Function to fetch employees (with or without filters)
    function loadEmployees(page = 0, filters = {}) {
        const url = filters.name || filters.email || filters.department || filters.designation
            ? "${pageContext.request.contextPath}/employees/search"
            : "${pageContext.request.contextPath}/employees/all";

        $.ajax({
            url: url,
            method: "GET",
            data: { ...filters, page: page, size: pageSize },
            success: function (data) {
                renderTable(data);
            },
            error: function () {
                alert("Error fetching employee data!");
            }
        });
    }

    // Initial load
    loadEmployees(currentPage);

    // Search button click
    $("#searchBtn").click(function () {
        const filters = {
            name: $("#name").val().trim(),
            email: $("#email").val().trim(),
            department: $("#department").val().trim(),
            designation: $("#designation").val().trim()
        };
        lastSearch = filters;
        currentPage = 0;
        loadEmployees(currentPage, filters);
    });

    // Pagination controls
    $("#prevPage").click(function () {
        if (currentPage > 0) {
            currentPage--;
            loadEmployees(currentPage, lastSearch);
        }
    });

    $("#nextPage").click(function () {
        currentPage++;
        loadEmployees(currentPage, lastSearch);
    });
});

</script>
    </body>
</html>
