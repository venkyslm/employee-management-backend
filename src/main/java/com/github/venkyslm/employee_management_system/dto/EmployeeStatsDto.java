package com.github.venkyslm.employee_management_system.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeStatsDto {
    private long totalEmployees;
    private long activeEmployees;
    private long inactiveEmployees;
    private long departmentsCount;
}
