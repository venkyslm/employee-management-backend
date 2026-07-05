package com.github.venkyslm.employee_management_system.controller;

import com.github.venkyslm.employee_management_system.dto.EmployeeStatsDto;
import com.github.venkyslm.employee_management_system.service.EmployeeStatsService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/employees")
@RequiredArgsConstructor
@Slf4j
public class EmployeeStatsController {

    private final EmployeeStatsService employeeStatsService;

    @GetMapping("/stats")
    public ResponseEntity<EmployeeStatsDto> getEmployeeStats() {
        log.info("REST request to get Employee statistics");
        EmployeeStatsDto stats = employeeStatsService.getEmployeeStatistics();
        return ResponseEntity.ok(stats);
    }
}
