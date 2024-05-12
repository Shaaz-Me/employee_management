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
<%
	int id = (int)request.getAttribute("id");
	String firstName = (String)request.getAttribute("firstName");
	String lastName = (String)request.getAttribute("lastName");
	String email = (String)request.getAttribute("email");
	String phone = (String)request.getAttribute("phone");
	String department = (String)request.getAttribute("department");
	String position = (String)request.getAttribute("position");
	String errorMessage = (String)request.getAttribute("errorMessage");
	Long salary = null;
	if(position !=null){
		salary= (Long)request.getAttribute("salary");
	}
	String photo = (String)request.getAttribute("photo");
%>


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
					<li class="nav-item mx-2"><a class="nav-link" href="/employee/register">Register
							Employee</a></li>
					<li class="nav-item mx-2"><a class="nav-link" href="/employee/get-all/0">All
							Employee</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-5">
		<form action="/employee/edit/details" method="post" class="card w-50 mx-auto p-5 rounded-5"
			name = "employeeform"
			enctype="multipart/form-data">
			<h2 class="text-center mb-5 text-decoration-underline">Edit
				Employee</h2>
			<%if(errorMessage !=null && !errorMessage.equals("")) {%>
			 <div class="text-center alert alert-danger" role="alert" id="notification"><%=errorMessage %></div>
			<%} %>
			<div style="display: none;">
				<input value=<%=id %> name="id" >
			</div>
			<div class="text-center alert" role="alert" id="notification" style="display: none;"></div>
			<div class="input-group mb-3">
				<span class="input-group-text">First name</span> <input type="text"
					class="form-control" placeholder="Enter your first Name"
					aria-label="First Name" value="<%=firstName %>" name="firstName"  required>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Last name</span> <input type="text"
					class="form-control" placeholder="Enter your last Name"
					aria-label="Last Name" value="<%=lastName %>" name="lastName"  required>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Salary</span>
				<%if(salary!=null) {%>
				<input type="number"
					class="form-control" placeholder="Enter your salary(per annum)"
					aria-label="salary" value="<%=salary %>" name="salary" id="salary"  required>
				
				<%}
				else {%>
				<input type="number"
					class="form-control" placeholder="Enter your salary(per annum)"
					aria-label="salary" name="salary" id="salary" required>
				
				<%} %>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Department</span> <input type="text"
					class="form-control" placeholder="Your department"
					aria-label="department" value="<%=department %>" name="department"  required>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Position</span> <input type="text"
					class="form-control" placeholder="Your position"
					aria-label="position" value="<%=position %>" name="position"  required>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Email</span> <input type="email"
					class="form-control" placeholder="Enter your email"
					aria-label="email" value="<%=email %>" name="email"  required>
			</div>
			<div class="input-group mb-3">
				<span class="input-group-text">Contact number</span> <input
					type="tel" class="form-control" placeholder="Enter your number"
					aria-label="phone" value="<%=phone %>" name="phone"  required>
			</div>
			<div class="input-group mb-3">
				<label class="input-group-text">Upload image</label> <input
					type="file" class="form-control" placeholder="Your picture"
					aria-label="photo" name="photo" value="<%=request.getContextPath() %>/img/<%=photo %>" id="photo" required>
			</div>
			<div class="text-center mb-3">
				<button type="submit" class="btn btn-primary" >Submit</button>
			</div>
		</form>
	</div>
	
</body>
</html>