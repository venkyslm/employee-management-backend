# Issue 001: Spring Boot Failed to Connect to Supabase PostgreSQL

## Date

27-Jun-2026

## Phase

Phase 1 - Database Setup

## Error

Application startup failed with:

'url' must start with "jdbc"

BeanCreationException:
Failed to instantiate HikariDataSource

## Root Cause

The Supabase PostgreSQL connection string was directly copied into:

spring.datasource.url

Incorrect configuration:

spring.datasource.url=postgresql://postgres:PASSWORD@db.xxx.supabase.co:5432/postgres

Spring Boot expects a JDBC URL, not a PostgreSQL connection string.

## Solution

Converted the connection string into a JDBC URL.

Correct configuration:

spring.datasource.url=jdbc:postgresql://db.xxx.supabase.co:5432/postgres
spring.datasource.username=postgres
spring.datasource.password=********

## Verification

Application started successfully.

Observed:

HikariPool-1 - Start completed.

Initialized JPA EntityManagerFactory

Tomcat started on port 8080

## Learning

Learned the difference between:

* PostgreSQL connection strings
* JDBC URLs used by Spring Boot

Verified database connectivity before implementing entities, repositories, services, and controllers.

# Issue 002: React Frontend Unable to Access Spring Boot API (CORS Error)
## Date

27-Jun-2026

## Phase

React Integration with Spring Boot Backend

## Error

React application failed to fetch data from Spring Boot APIs.

Browser Console Error:

Access to XMLHttpRequest at 'http://localhost:8080/employees/all'
from origin 'http://localhost:5173'
has been blocked by CORS policy.

## Root Cause

React frontend and Spring Boot backend were running on different origins:

React:
http://localhost:5173

Spring Boot:
http://localhost:8080

Browsers block cross-origin requests unless the backend explicitly allows them.

## Solution

Created a global CORS configuration in Spring Boot.

```java
@Configuration
public class CorsConfig {

    @Bean
    public WebMvcConfigurer corsConfigurer() {

        return new WebMvcConfigurer() {

            @Override
            public void addCorsMappings(CorsRegistry registry) {

                registry.addMapping("/**")
                        .allowedOrigins("http://localhost:5173")
                        .allowedMethods("*");
            }
        };
    }
}
```

## Verification

After restarting Spring Boot:

* React successfully called backend APIs.
* Employee data was fetched successfully.
* Browser console showed no CORS errors.

## Learning

Modern frontend and backend applications usually run on separate servers and ports during development.

Cross-Origin Resource Sharing (CORS) must be configured correctly to allow communication between:

* React Frontend
* Spring Boot Backend

## Prevention

Whenever a new frontend application is introduced:

1. Verify frontend URL.
2. Configure allowed origins in Spring Boot.
3. Test API access using browser developer tools.
4. Confirm requests succeed before implementing UI features.
