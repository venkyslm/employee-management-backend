/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.service;

import com.github.venkyslm.employee_management_system.entity.Employee;
import com.github.venkyslm.employee_management_system.repository.EmployeeRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import com.github.venkyslm.employee_management_system.specification.EmployeeSpecification;
import lombok.extern.slf4j.Slf4j;

/**
 *
 * @author user
 */
@Service
@Slf4j
public class EmployeeService {
    @Autowired
    private EmployeeRepository employeeRepository;
    
    public Page<Employee> getAllEmployees(String keyword, String department, String status, int page, int size, String sort){
        log.info("Retrieving employees with keyword: {}, department: {}, status: {}, page: {}, size: {}, sort: {}", keyword, department, status, page, size, sort);
        Sort sortObj = Sort.unsorted();
        if (sort != null && !sort.trim().isEmpty()) {
            String[] sortParams = sort.split(",");
            String property = sortParams[0];
            Sort.Direction direction = Sort.Direction.ASC;
            if (sortParams.length > 1 && sortParams[1].equalsIgnoreCase("desc")) {
                direction = Sort.Direction.DESC;
            }
            sortObj = Sort.by(direction, property);
        }

        Pageable pageable = PageRequest.of(page, size, sortObj);
        Specification<Employee> spec = EmployeeSpecification.getEmployeesSpec(keyword, department, status);
        return employeeRepository.findAll(spec, pageable);
    }

    public Employee getEmployeeById(Long id) {
        log.info("Retrieving employee by id: {}", id);
        return employeeRepository.findById(id)
                .orElseThrow(() -> new com.github.venkyslm.employee_management_system.exception.EmployeeNotFoundException("Employee not found with id: " + id));
    }

    public Employee createEmployee(Employee employee) {
        log.info("Creating employee: {}", employee.getEmployeeCode());
        return employeeRepository.save(employee);
    }


    public void deleteEmployee(Long id) {
        log.info("Deleting employee with id: {}", id);
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() ->
                        new com.github.venkyslm.employee_management_system.exception.EmployeeNotFoundException("Employee not found with id: " + id));

        employeeRepository.delete(employee);
    }

    public Employee updateEmployee(Long id, Employee updatedEmployee) {
        log.info("Updating employee with id: {}", id);
        Employee employee = employeeRepository.findById(id)
                .orElseThrow(() ->
                        new com.github.venkyslm.employee_management_system.exception.EmployeeNotFoundException("Employee not found with id: " + id));

        employee.setEmployeeCode(updatedEmployee.getEmployeeCode());
        employee.setFirstName(updatedEmployee.getFirstName());
        employee.setLastName(updatedEmployee.getLastName());
        employee.setEmail(updatedEmployee.getEmail());
        employee.setPhone(updatedEmployee.getPhone());
        employee.setDepartment(updatedEmployee.getDepartment());
        employee.setDesignation(updatedEmployee.getDesignation());
        employee.setSalary(updatedEmployee.getSalary());
        employee.setJoiningDate(updatedEmployee.getJoiningDate());
        employee.setStatus(updatedEmployee.getStatus());
        employee.setUpdatedAt(updatedEmployee.getUpdatedAt());

        return employeeRepository.save(employee);
    }
    

    
    
    
    
    
    
}
