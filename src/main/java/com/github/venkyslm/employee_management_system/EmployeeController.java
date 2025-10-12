/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 *
 * @author user
 */
@Controller
public class EmployeeController {
    @GetMapping
    public String samplePage(Model model ){
        model.addAttribute("message", "This is from controller.");
        return "sample";
    }
    
}
