<%-- 
    Document   : list
    Created on : 12-Oct-2025, 6:46:27 pm
    Author     : user
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="layout/taglibs.jsp" %>

<%-- Older Way of inserting pagetitle, css & js --%>
<%--
<%
    request.setAttribute("pageTitle", "Employee List");
    request.setAttribute("pageCSS",
        "<link rel='stylesheet' href='" + request.getContextPath() + "/resources/css/list.css' />");
    request.setAttribute("pageJS",
        "<script src='https://code.jquery.com/jquery-3.6.0.min.js'></script>");
%>
--%>

<%-- Modern Way of inserting pagetitle, css & js --%>
<c:set var="pageTitle" value="Employee List - Home" />
<c:set var="pageCSS" value="/resources/css/list.css" />
<c:set var="pageJS" value="https://code.jquery.com/jquery-3.6.0.min.js" />

<title>${pageTitle}</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}${pageCSS}">
<script src="${pageJS}"></script>

<jsp:include page="layout/header.jsp" />

<div class="container mt-4">

    <h1 class="mb-3 text-center">Employee Management App</h1>

    <div class="mb-2 d-flex gap-3">
        <input type="text" id="name" placeholder="Name" class="form-control mb-2">
        <input type="text" id="email" placeholder="Email" class="form-control mb-2">
        <input type="text" id="department" placeholder="Department" class="form-control mb-2">
        <input type="text" id="designation" placeholder="Designation" class="form-control mb-2">
    </div>
    
    <div class="d-flex align-items-center gap-2 mb-2">
        <button id="searchBtn" class="btn btn-primary flex-grow-1">Search</button>
        <a href="/addEmployee" class="btn btn-success">Add Employee</a>
    </div>

    <table  id="employeeTable" class="table table-bordered table-hover text-center">
        <thead class="table-info">
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

    <div id="paginationControls" class="d-flex justify-content-between mb-5">
        <button id="prevPage" class="btn btn-secondary">Prev</button>
        <span id="pageInfo"></span>
        <button id="nextPage" class="btn btn-secondary">Next</button>
    </div>

    <p id="noDataMsg" style="display:none;" class="text-danger mt-3">
        No employees found. Please add some!
    </p>
</div>
            
        
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

<jsp:include page="layout/footer.jsp" />
