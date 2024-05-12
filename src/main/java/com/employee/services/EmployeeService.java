package com.employee.services;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.employee.entities.Employee;
import com.employee.repo.EmployeeRepository;

@Service
public class EmployeeService {
	
	@Autowired
	private EmployeeRepository employeeRepo;

	public Employee saveEmployee(Employee employee,MultipartFile file) throws Exception {
		if(file!=null && !file.isEmpty()) {
			File saveFile = new ClassPathResource("static/img").getFile();
			Path path = Paths.get(saveFile.getAbsolutePath()+File.separator+file.getOriginalFilename());
			Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
			employee.setImage(file.getOriginalFilename());
			return this.employeeRepo.save(employee);
		}
		return employee;
	}
	
	public Employee updateEmploye(Employee employee,MultipartFile file) throws Exception {
		File saveFile = new ClassPathResource("static/img").getFile();
		Path path = Paths.get(saveFile.getAbsolutePath()+File.separator+file.getOriginalFilename());
		Files.copy(file.getInputStream(), path, StandardCopyOption.REPLACE_EXISTING);
		employee.setImage(file.getOriginalFilename());
		return this.employeeRepo.save(employee);
	}
	
	public Page<Employee> getEmployee(int page,int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		Page<Employee> allEmployee = this.employeeRepo.findAll(pageable);
		return allEmployee;
	}
	
	
	public Page<Employee> getEmployeeByPosition(String position,int page,int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		Page<Employee> allEmployee = this.employeeRepo.findByPosition(position, pageable);
		return allEmployee;
	}
	
	
	public Page<Employee> getEmployeeByDepartment(String department,int page,int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		Page<Employee> allEmployee = this.employeeRepo.findByDepartment(department, pageable);
		return allEmployee;
	}
	
	
	public Page<Employee> getEmployeeByDepartmentAndPosition(String department,String position,int page,int limit) {
		Pageable pageable = PageRequest.of(page, limit);
		Page<Employee> allEmployee = this.employeeRepo.findByDepartmentAndPosition(department, position, pageable);
		return allEmployee;
	}
	
	public void deleteEmployee(int id) {
		this.employeeRepo.deleteById(id);
	}
	
	public Employee getEmployeeById(int id) {
		return this.employeeRepo.getReferenceById(id);
	}
	
}
