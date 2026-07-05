package com.github.venkyslm.employee_management_system.service;

import com.github.venkyslm.employee_management_system.dto.EmployeeStatsDto;
import com.github.venkyslm.employee_management_system.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
@Slf4j
public class EmployeeStatsServiceImpl implements EmployeeStatsService {

    private final EmployeeRepository employeeRepository;

    @Override
    @Transactional(readOnly = true)
    public EmployeeStatsDto getEmployeeStatistics() {
        log.info("Fetching employee statistics from the database");
        
        long totalEmployees = employeeRepository.count();
        long activeEmployees = employeeRepository.countByStatus("ACTIVE");
        long inactiveEmployees = employeeRepository.countByStatus("INACTIVE");
        long departmentsCount = employeeRepository.countDistinctDepartments();

        log.debug("Statistics fetched: Total={}, Active={}, Inactive={}, Departments={}",
                totalEmployees, activeEmployees, inactiveEmployees, departmentsCount);

        return new EmployeeStatsDto(totalEmployees, activeEmployees, inactiveEmployees, departmentsCount);
    }
}
