/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.controller;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import io.swagger.v3.oas.annotations.tags.Tag;

/**
 *
 * @author user
 */
@RestController
@RequestMapping("/api/employees")
@Tag(name = "Employee API", description = "Endpoints for managing employees")
public class EmployeeRestController {
    @Autowired
    private EmployeeService employeeService;

    @GetMapping
    @Operation(summary = "Get all employees", description = "Retrieves a paginated list of employees with optional filtering and sorting")
    @ApiResponse(responseCode = "200", description = "Successfully retrieved employees")
    public Page<Employee> getAllEmployees(
            @RequestParam(required = false) String keyword,
            @RequestParam(required = false) String department,
            @RequestParam(required = false) String status,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "5") int size,
            @RequestParam(required = false) String sort
    ){
        return employeeService.getAllEmployees(keyword, department, status, page, size, sort);
    }

    @GetMapping("/{id}")
    @Operation(summary = "Get employee by ID", description = "Retrieves an employee by their ID")
    @ApiResponse(responseCode = "200", description = "Successfully retrieved employee")
    public ResponseEntity<Employee> getEmployeeById(@PathVariable Long id) {
        return ResponseEntity.ok(employeeService.getEmployeeById(id));
    }

    @PostMapping
    @Operation(summary = "Create an employee", description = "Creates a new employee")
    @ApiResponse(responseCode = "200", description = "Successfully created employee")
    public Employee createEmployee(@jakarta.validation.Valid @RequestBody Employee employee){
        return employeeService.createEmployee(employee);
    }

    @DeleteMapping("/{id}")
    @Operation(summary = "Delete an employee", description = "Deletes an employee by their ID")
    @ApiResponse(responseCode = "200", description = "Successfully deleted employee")
    public ResponseEntity<String> deleteEmployee(@PathVariable Long id) {

        employeeService.deleteEmployee(id);

        return ResponseEntity.ok("Employee deleted successfully");
    }

    @PutMapping("/{id}")
    @Operation(summary = "Update an employee", description = "Updates an existing employee")
    @ApiResponse(responseCode = "200", description = "Successfully updated employee")
    public ResponseEntity<Employee> updateEmployee(
            @PathVariable Long id,
            @jakarta.validation.Valid @RequestBody Employee employee) {

        Employee updatedEmployee =
                employeeService.updateEmployee(id, employee);

        return ResponseEntity.ok(updatedEmployee);
    }



}
