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
        <button id="searchBtn" class="btn flex-grow-1 fw-bold" style="background-color:#083b8c;color:#fff;">Search</button>
<!--        <a href="/addEmployee" class="btn btn-success fw-bold">Add Employee</a>-->
        <button class="btn btn-success fw-bold" data-bs-toggle="modal" data-bs-target="#myModal">Add Employee</button>
    </div>
    
    <!-- Loading Spinner Section -->
    <div id="loadingSpinner" style="height: 100px; text-align:center; padding-top:25px;">
        <div class="spinner-border text-secondary" role="status"></div>
        <div class="mt-2 text-secondary fw-bold">Loading...</div>
    </div>

    <div class="table-responsive" id="dataContainer" style="display:none;">
    <table  id="employeeTable" class="table table-bordered table-hover text-center">
        <thead class="table-info">
        <tr>
            <th>Id</th>
            <th>Name</th>
            <th>Email</th>
            <th>Department</th>
            <th>Salary</th>
            <th>Designation</th>
            <th>Options</th>
        </tr>
        </thead>
        <tbody id="employeeTableBody"></tbody>
    </table>
    </div>

    <div id="paginationControls" class="d-flex justify-content-between mb-5">
        <button id="prevPage" class="btn btn-secondary">Prev</button>
        <span id="pageInfo"></span>
        <button id="nextPage" class="btn btn-secondary">Next</button>
    </div>

    <p id="noDataMsg" style="display:none;" class="text-danger mt-3">
        No employees found. Please add some!
    </p>
    
    
    <!-- Modal (Add Employee) -->
        <div class="modal fade" id="myModal" tabindex="-1" aria-labelledby="addEmployeeModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title" id="addEmployeeModalLabel">Add New Employee</h5>
                <button class="btn-close btn-close-white" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>

            <!-- Modal Body -->
            <div class="modal-body">
                <form action="/addEmployee" method="POST">
                    <div class="mb-3">
                        <label class="form-label">Name:</label>
                        <input class="form-control" type="text" name="name" />
                    </div>                  

                    <div class="mb-3">
                        <label class="form-label">Email:</label>
                        <input class="form-control" type="email" name="email" />
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Department:</label>
                        <input class="form-control" type="text" name="department" />
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Salary:</label>
                        <input class="form-control" type="number" name="salary" />
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Designation:</label>
                        <input class="form-control" type="text" name="designation" />
                    </div>

                    <button type="submit" class="btn btn-primary">Add Employee</button>
                </form>
            </div>
        </div>
    </div>
</div><!--modal ends here-->
</div> <!--main container ends here-->
            
        
<!-- 🔧 AJAX Script -->
<script>
$(document).ready(function () {
    let currentPage = 0; // Tracks current page number
    const pageSize = 5; // Number of employees per page
    let lastSearch = {}; // store last search filters

    // Function to render table
    function renderTable(data) {
        let rows = "";
        if (!data.content || data.content.length === 0) {
            $("#employeeTableBody").html("");
            $("#noDataMsg").show();
            $("#dataContainer").hide();
            return;  
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
                    "<td>" +
                    "<button class='btn btn-sm btn-primary' data-bs-toggle='tooltip' data-bs-placement='left' title='Edit Employee'>Edit</button>&nbsp;&nbsp;" +
                    "<button class='btn btn-sm btn-danger' data-bs-toggle='tooltip' data-bs-placement='right' title='Delete Employee'>Delete</button>" +
                    "</td>" +
                    "</tr>";
            });
            $("#employeeTableBody").html(rows);
            
            // Reinitialize Bootstrap tooltips after dynamic content is added
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle=\"tooltip\"]'));
            tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
            });

            $("#pageInfo").text("Page " + (data.number + 1) + " of " + data.totalPages);
            $("#prevPage").prop("disabled", data.number === 0);
            $("#nextPage").prop("disabled", data.number + 1 === data.totalPages);
        }
    }

    let spinnerStartTime = 0;
    const MIN_SPINNER_TIME = 500; // spinner running time

    // Function to fetch employees (with or without filters)
    function loadEmployees(page = 0, filters = {}) {
        
        // Record spinner start time
        spinnerStartTime = Date.now();
        
        // Show spinner whenever loading starts
        $("#loadingSpinner").show();
        $("#dataContainer").hide();
        
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
            error: function (e) {
                alert("Error fetching employee data!");
            },
            complete: function () {
                const elapsed = Date.now() - spinnerStartTime;
                const delay = Math.max(0, MIN_SPINNER_TIME - elapsed);
                
                setTimeout(() => {
                $("#loadingSpinner").hide();
                $("#dataContainer").show();
                }, delay);
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
