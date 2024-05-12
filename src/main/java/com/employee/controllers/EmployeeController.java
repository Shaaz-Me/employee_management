package com.employee.controllers;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.employee.entities.Employee;
import com.employee.services.EmployeeService;


@Controller
public class EmployeeController {

	@Autowired
	private EmployeeService employeeService;
	
	@GetMapping("/employee/get-all/{page}")
	public String getEmployee(@PathVariable("page") Integer page,Model model) {
		Page<Employee> employee = this.employeeService.getEmployee(page,3);
		model.addAttribute("totalPage", employee.getTotalPages());
		model.addAttribute("currentPage", page);
		model.addAttribute("totalEmployee", employee.getNumberOfElements());
		model.addAttribute("data", employee.getContent());
		model.addAttribute("url", "/employee/get-all");
		model.addAttribute("limit",3);
		return "employee";
	}
	
	
	@GetMapping("/employee/filter/{page}")
	public String getFilteredEmployee(@PathVariable("page")Integer page,
			@RequestParam(name="department",required=false)String department,
			@RequestParam(name="position",required=false)String position,
			@RequestParam(name="limit",required=false)Integer limit,Model model) {
		
		String newDepartment = (String)model.asMap().get("department");
		String newPosition = (String)model.asMap().get("position");
		Integer newLimit = (Integer)model.asMap().get("limit");
		
		if(newDepartment != null && !newDepartment.equals("")) {
			department = newDepartment;
		}
		if(newPosition != null && !newPosition.equals("")) {
			position = newPosition;
		}
		if(newLimit != null) {
			limit = newLimit;
		}
		
		Page<Employee> employee;
		try {
			if((department !=null && !department.equals(""))&&(position!=null && !position.equals(""))) {
				employee = this.employeeService.getEmployeeByDepartmentAndPosition(department,position,page, (limit==null)?3:limit);
				model.addAttribute("position", position);
				model.addAttribute("department", department);
			}
			else if(department != null && !department.equals("")) {
				employee = this.employeeService.getEmployeeByDepartment(department,page, (limit==null)?3:limit);				
				model.addAttribute("department", department);
			}
			else if(position != null && !position.equals("")) {
				employee = this.employeeService.getEmployeeByPosition(position,page, (limit==null)?3:limit);				
				model.addAttribute("position", position);
			}
			else {
				employee = this.employeeService.getEmployee(page, (limit==null)?3:limit);
			}
			model.addAttribute("totalPage", employee.getTotalPages());
			model.addAttribute("currentPage", page);
			model.addAttribute("totalEmployee", employee.getNumberOfElements());
			model.addAttribute("data", employee.getContent());
			model.addAttribute("url", "/employee/filter");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("totalPage", 0);
			model.addAttribute("currentPage", 0);
			model.addAttribute("totalEmployee", 0);
			model.addAttribute("data", List.of(new ArrayList<Employee>()));
			model.addAttribute("url", "/employee/filter");
			model.addAttribute("errorMessage", e.getMessage());
		}
		model.addAttribute("limit", (limit==null)?3:limit);
		
		return "employee";
	}
	
	@PostMapping("/employee/delete")
	public String deleteEmployee(@RequestParam("id")Integer id,
			@RequestParam("url")String url,
			@RequestParam("curPage")Integer curPage,
			@RequestParam("department")String department,
			@RequestParam("position")String position,
			@RequestParam("limit")Integer limit,
			RedirectAttributes redirectAttributes){
		
		
		this.employeeService.deleteEmployee(id);
		redirectAttributes.addFlashAttribute("url", url);
		redirectAttributes.addFlashAttribute("curPage", curPage);
		redirectAttributes.addFlashAttribute("department", department);
		redirectAttributes.addFlashAttribute("position", position);
		redirectAttributes.addFlashAttribute("limit", limit);
		
		return "redirect:/employee/filter/"+String.valueOf(curPage);
	}
	
	@PostMapping("employee/edit")
	public String editEmployeePage(@RequestParam("id")Integer id,Model model) {
		Employee employee = this.employeeService.getEmployeeById(id);
		model.addAttribute("id", employee.getId());
		model.addAttribute("firstName", employee.getFirstName());
		model.addAttribute("lastName", employee.getLastName());
		model.addAttribute("email", employee.getEmail());
		model.addAttribute("phone", employee.getPhone());
		model.addAttribute("department", employee.getDepartment());
		model.addAttribute("position", employee.getPosition());
		model.addAttribute("salary", employee.getSalary());
		model.addAttribute("photo", employee.getImage());
		return "edit";
	}
	
	@PostMapping("/employee/edit/details")
	public String doEdit(@ModelAttribute("employee")Employee employee,@RequestParam("photo")MultipartFile file,Model model) {
		
		try {
			if(file==null || file.isEmpty()) {
				throw new Exception("Photo is required");
			}
			System.out.println(employee);
			this.employeeService.updateEmploye(employee, file);
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			model.addAttribute("errorMessage", e.getMessage());
			model.addAttribute("id", employee.getId());
			model.addAttribute("firstName", employee.getFirstName());
			model.addAttribute("lastName", employee.getLastName());
			model.addAttribute("email", employee.getEmail());
			model.addAttribute("phone", employee.getPhone());
			model.addAttribute("department", employee.getDepartment());
			model.addAttribute("position", employee.getPosition());
			model.addAttribute("salary", employee.getSalary());
			model.addAttribute("photo", employee.getImage());
			return "edit";
		}
		
		return "redirect:/employee/get-all/0";
	}
	
}
