package com.github.venkyslm.employee_management_system.specification;

import com.github.venkyslm.employee_management_system.entity.Employee;
import org.springframework.data.jpa.domain.Specification;
import jakarta.persistence.criteria.Predicate;
import java.util.ArrayList;
import java.util.List;

public class EmployeeSpecification {

    public static Specification<Employee> getEmployeesSpec(String keyword, String department, String status) {
        return (root, query, criteriaBuilder) -> {
            List<Predicate> predicates = new ArrayList<>();

            if (keyword != null && !keyword.trim().isEmpty()) {
                String pattern = "%" + keyword.trim().toLowerCase() + "%";
                Predicate firstNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("firstName")), pattern);
                Predicate lastNamePredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("lastName")), pattern);
                Predicate emailPredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("email")), pattern);
                Predicate departmentPredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("department")), pattern);
                Predicate designationPredicate = criteriaBuilder.like(criteriaBuilder.lower(root.get("designation")), pattern);
                
                predicates.add(criteriaBuilder.or(firstNamePredicate, lastNamePredicate, emailPredicate, departmentPredicate, designationPredicate));
            }

            if (department != null && !department.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("department"), department.trim()));
            }

            if (status != null && !status.trim().isEmpty()) {
                predicates.add(criteriaBuilder.equal(root.get("status"), status.trim()));
            }

            return criteriaBuilder.and(predicates.toArray(new Predicate[0]));
        };
    }
}
