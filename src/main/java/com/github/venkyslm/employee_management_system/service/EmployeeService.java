/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.service;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.repository.EmployeeRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

/**
 *
 * @author user
 */
@Service
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;
    
    public Page<Employee> getAllEmployees(int page, int size){
        Pageable pageable = PageRequest.of(page, size);
        return employeeRepository.findAll(pageable);
    }
    
    public Employee createEmployee(Employee employee){
        return employeeRepository.save(employee);
    }
    
    public Page<Employee> searchEmployees(String name,String email,
            String department, String designation, 
            int page, int size){
        
        Pageable pageable = PageRequest.of(page, size);
        
        if(name != null && !name.isEmpty()){
            return employeeRepository.findByNameContainingIgnoreCase(name, pageable);
        }else if(email != null && !email.isEmpty()){
            return employeeRepository.findByEmailContainingIgnoreCase(email, pageable);
        }else if(department != null && !department.isEmpty()){
            return employeeRepository.findByDepartmentContainingIgnoreCase(department, pageable);
        }else if(designation != null && !designation.isEmpty()){
            return employeeRepository.findByDesignationContainingIgnoreCase(designation, pageable);
        }else{
            return employeeRepository.findAll(pageable);
        }
    }
    
    
    
    
    
    
}
