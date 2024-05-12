package com.employee.repo;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;

import com.employee.entities.Employee;


public interface EmployeeRepository extends JpaRepository<Employee, Integer> {

	public Page<Employee> findAll(Pageable pageable);
	
	
	public Page<Employee> findByPosition(@Param("position")String position,Pageable pageable);
	
	
	public Page<Employee> findByDepartment(@Param("department")String department,Pageable pageable);
	
	
	public Page<Employee> findByDepartmentAndPosition(@Param("department")String department,@Param("position")String position,Pageable pageable);
}
