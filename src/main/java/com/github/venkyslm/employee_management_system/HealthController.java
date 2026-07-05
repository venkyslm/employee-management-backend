package com.github.venkyslm.employee_management_system;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    @GetMapping("/health")
    public String healthPing(){
        return "Pinging the App to keep in live.";
    }
}
