<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Manager</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
</head>
<body class="bg-secondary">
	<nav class="navbar navbar-expand-lg bg-dark navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">Md Shahzar</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mx-auto">
					<li class="nav-item mx-2"><a class="nav-link active" href="/employee/register">Register
							Employee</a></li>
					<li class="nav-item mx-2"><a class="nav-link" href="/employee/get-all/0">All
							Employee</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-5">
		<form class="card w-50 mx-auto p-5 rounded-5"
			id="employeeform" name = "employeeform"
			enctype="multipart/form-data">
			<h2 class="text-center mb-5 text-decoration-underline">Add
				Employee</h2>
			<div class="text-center alert" role="alert" id="notification" style="display: none;"></div>
			<div class="input-group mb-3">
				<span class="input-group-text">First name</span> <input type="text"
					class="form-control" placeholder="Enter your first Name"
					aria-label="First Name" name="firstName">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Last name</span> <input type="text"
					class="form-control" placeholder="Enter your last Name"
					aria-label="Last Name" name="lastName">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Salary</span> <input type="number"
					class="form-control" placeholder="Enter your salary(per annum)"
					aria-label="salary" name="salary" id="salary">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Department</span> <input type="text"
					class="form-control" placeholder="Your department"
					aria-label="department" name="department">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Position</span> <input type="text"
					class="form-control" placeholder="Your position"
					aria-label="position" name="position">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Email</span> <input type="email"
					class="form-control" placeholder="Enter your email"
					aria-label="email" name="email">
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Contact number</span> <input
					type="tel" class="form-control" placeholder="Enter your number"
					aria-label="phone" name="phone">
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text">Upload image</label> <input
					type="file" class="form-control" placeholder="Your picture"
					aria-label="photo" name="photo" id="photo">
			</div>
			<div class="text-center mb-3">
				<button id="employeesubmit" type="submit" class="btn btn-primary" >Register</button>
			</div>
		</form>
	</div>
	
	<script type="text/javascript">
		const form = document.querySelector("#employeeform");
		const btn = document.querySelector("#employeesubmit");
		
		btn.addEventListener('click',(e)=>{
			e.preventDefault();
			const salary = document.getElementById("salary");
			if(salary.value === ""){
				salary.value = 0;
			}
			const formData = new FormData(form);
			const values = [...formData.entries()];
			for(let i=0;i<values.length;i++){
				let value = values[i];
				if(value[0]== "photo"){
					console.log(value);
					if(value[1].size == 0){						
						const notification = document.getElementById("notification");
						notification.classList.add("alert-danger");
						notification.style.display = "unset";
						notification.innerHTML = "Image is required";
						form.reset();
						return;
					}
				}
				else if(value[0]== "salary") {
					if(value[1]=="0" || value[1]<1){
						const notification = document.getElementById("notification");
						notification.classList.add("alert-danger");
						notification.style.display = "unset";
						notification.innerHTML = "All fields are required";
						form.reset();
						return;						
					}
				}
				else{
					if(value[1]==null || value[1].length==""){
						const notification = document.getElementById("notification");
						notification.classList.add("alert-danger");
						notification.style.display = "unset";
						notification.innerHTML = "All fields are required";
						form.reset();
						return;
					}
				}
			}
		    fetch("/employee/register",{
		    	method: "post",
		    	enctype: "mulitpart/form-data",
		    	body: formData
		    }).then((res)=>{
		    	return res.json();
		    })
		    .then((res)=>{
		    	form.reset();
		    	const notification = document.getElementById("notification");
		    	notification.classList.add(res.classes);
		    	notification.style.display = "unset";
		    	notification.innerHTML = res.message;
		    });
		    
		    
		    
		})
	</script>

</body>
</html>