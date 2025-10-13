/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.github.venkyslm.employee_management_system.repository;

import com.github.venkyslm.employee_management_system.entity.Employee;
import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 *
 * @author user
 */
public interface EmployeeRepository extends JpaRepository<Employee, Long>{
 
    List<Employee> findByNameContainingIgnoreCase(String name);
    List<Employee> findByEmailContainingIgnoreCase(String email);
    List<Employee> findByDepartmentContainingIgnoreCase(String department);
    List<Employee> findByDesignationContainingIgnoreCase(String designation);
}
