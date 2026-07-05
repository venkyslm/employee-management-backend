package com.github.venkyslm.employee_management_system.security.user;

import com.github.venkyslm.employee_management_system.security.dto.LoginRequest;
import com.github.venkyslm.employee_management_system.security.dto.LoginResponse;
import com.github.venkyslm.employee_management_system.security.dto.RegisterRequest;
import com.github.venkyslm.employee_management_system.security.jwt.JwtService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserService {

    private final UserRepository repository;
    private final PasswordEncoder passwordEncoder;
    private final JwtService jwtService;
    private final AuthenticationManager authenticationManager;

    public LoginResponse register(RegisterRequest request) {
        log.info("User Registration attempt for username: {}", request.getUsername());
        if (repository.findByUsername(request.getUsername()).isPresent()) {
            log.warn("Registration failed: Username already exists ({})", request.getUsername());
            throw new IllegalArgumentException("Username already exists");
        }
        var user = User.builder()
                .username(request.getUsername())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(request.getRole() != null ? request.getRole() : Role.EMPLOYEE)
                .build();
        repository.save(user);
        log.info("User registered successfully: {}", request.getUsername());
        var jwtToken = jwtService.generateToken(user);
        return LoginResponse.builder()
                .token(jwtToken)
                .build();
    }

    public LoginResponse login(LoginRequest request) {
        log.info("Login attempt for username: {}", request.getUsername());
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(
                            request.getUsername(),
                            request.getPassword()
                    )
            );
            var user = repository.findByUsername(request.getUsername())
                    .orElseThrow(() -> new IllegalArgumentException("Invalid username or password"));
            
            log.info("Login Success for username: {}", request.getUsername());
            var jwtToken = jwtService.generateToken(user);
            return LoginResponse.builder()
                    .token(jwtToken)
                    .build();
        } catch (Exception e) {
            log.warn("Login Failure for username: {}", request.getUsername());
            throw e;
        }
    }
}
