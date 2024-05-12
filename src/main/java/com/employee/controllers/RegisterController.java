package com.employee.controllers;


import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.employee.entities.Employee;
import com.employee.services.EmployeeService;

@Controller
public class RegisterController {
	
	@Autowired
	private EmployeeService employeeService;

	@GetMapping("/")
	public String home() {
		return "redirect:/employee/register";
	}
	
	@GetMapping("/employee/register")
	public String register() {
		return "register";
	}
	
	@PostMapping("/employee/register")
	@ResponseBody
	public ResponseEntity<Object> doRegister(@ModelAttribute("employee")Employee employee
			,@RequestParam(name="photo",required=false)MultipartFile file) {
		
		Map<String,String> map = new HashMap<>();
		try {
			if(file==null || file.isEmpty()) {
				throw new Exception("Image is required");
			}
			this.employeeService.saveEmployee(employee, file);
			map.put("classes", "alert-success");
			map.put("message", "Successfully Registered");
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			map.put("classes", "alert-danger");
			map.put("message", e.getMessage());
		}
		return ResponseEntity.status(201).body(map);
	}
}
