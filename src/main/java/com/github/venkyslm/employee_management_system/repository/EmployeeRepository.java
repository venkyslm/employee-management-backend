/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.repository;

import com.github.venkyslm.employee_management_system.entity.Employee;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author user
 */
public interface EmployeeRepository extends JpaRepository<Employee, Long>{
 
    Page<Employee> findByNameContainingIgnoreCase(String name, Pageable pageable);
    Page<Employee> findByEmailContainingIgnoreCase(String email, Pageable pageable);
    Page<Employee> findByDepartmentContainingIgnoreCase(String department, Pageable pageable);
    Page<Employee> findByDesignationContainingIgnoreCase(String designation, Pageable pageable);
}
