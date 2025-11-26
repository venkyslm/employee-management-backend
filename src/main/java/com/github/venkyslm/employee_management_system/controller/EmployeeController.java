/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.controller;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

/**
 *
 * @author user
 */
@Controller
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    
    @GetMapping
    public String showEmployeeListHomePage(){
        return "list"; // This just opens list.jsp (without any data)
    }
    
    @GetMapping("/addEmployee")
    public String showForm(Model model){
        model.addAttribute("employee", new Employee());
        return "form";
    }
    
    @PostMapping("/addEmployee")
    public String addEmployee(@ModelAttribute("employee") Employee employee,Model model){
        employeeService.createEmployee(employee);
        return "redirect:/";
    }
    
    
    
    
    
}
