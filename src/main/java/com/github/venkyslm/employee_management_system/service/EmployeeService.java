/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.service;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.repository.EmployeeRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author user
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;
    
    public List<Employee> getAllEmployees(){
        return employeeRepository.findAll();
    }
    
    public Employee createEmployee(Employee employee){
        return employeeRepository.save(employee);
    }
    
    public List<Employee> searchEmployees(String name,String email,
            String department, String designation){
        if(name != null && !name.isEmpty()){
            return employeeRepository.findByNameContainingIgnoreCase(name);
        }else if(email != null && !email.isEmpty()){
            return employeeRepository.findByEmailContainingIgnoreCase(email);
        }else if(department != null && !department.isEmpty()){
            return employeeRepository.findByDepartmentContainingIgnoreCase(department);
        }else if(designation != null && !designation.isEmpty()){
            return employeeRepository.findByDesignationContainingIgnoreCase(designation);
        }else{
            return employeeRepository.findAll();
        }
    }
    
    
    
    
    
    
}
