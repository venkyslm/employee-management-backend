/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.controller;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.service.EmployeeService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 *
 * @author user
 */
@RestController
public class EmployeeRestController {
    @Autowired
    private EmployeeService employeeService;
    
    @GetMapping("/searchEmployees")
    public List<Employee> searchEmployees(
            @RequestParam(required = false) String name,
            @RequestParam(required = false) String email,
            @RequestParam(required = false) String department,
            @RequestParam(required = false) String designation
    ){
        return employeeService.searchEmployees(name, email, department, designation);
    }
    
}
