<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" isELIgnored="false"%>
<%@ page import="java.util.List, com.employee.entities.Employee" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Employee Management</title>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
<style type="text/css">
	.my_profile_pic{
		width:80px;
		height:80px;
	}
</style>
</head>
<body class="bg-secondary">
<%
	List<Employee> emp = (List<Employee>)request.getAttribute("data");
	int n = (int)request.getAttribute("totalEmployee");
	int currentPage = (int)request.getAttribute("currentPage");
	int totalPage = (int)request.getAttribute("totalPage");
	String url = (String)request.getAttribute("url");
	String position = (String)request.getAttribute("position");
	String department = (String)request.getAttribute("department");
	String errorMessage = (String)request.getAttribute("errorMessage");
	int limit = (int)request.getAttribute("limit");
	if(position==null){
		position = "";
	}
	if(department==null){
		department = "";
	}
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
					<li class="nav-item mx-2"><a class="nav-link"
						href="/employee/register">Register Employee</a></li>
					<li class="nav-item mx-2"><a class="nav-link active"
						href="/employee/get-all/0">All Employee</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container card mt-5 p-5">
		<%if(errorMessage !=null && !errorMessage.equals("")) {%>
			 <div class="mb-2 text-center alert alert-danger" role="alert" id="notification"><%=errorMessage %></div>
			<%} %>
		<h2 class="text-center text-decoration-underline">Employee
			Details</h2>
			
		<form action="/employee/filter/0" class="row g-3 mb-4">
			<div class="input-group col">
				<span class="input-group-text">Department</span>
				<input type="text" class="form-control" placeholder="Search by department"
					aria-label="department" name="department" value="<%=department%>">
			</div>
			<div class="input-group col">
				<span class="input-group-text">Position</span>
				<input type="text" class="form-control" placeholder="Search by position"
					aria-label="position" name="position" value="<%=position%>">
			</div>
			<div class="input-group col">
				<span class="input-group-text">Pagination limit</span>
				<input type="number" class="form-control" placeholder="Search by pagination limit"
					aria-label="limit" name="limit" value=<%=limit %>>
			</div>
			<div class="text-center">
				<button class="btn btn-primary" type="submit">Search</button>
			</div>
		</form>
		<hr>
		<table class="table text-center mb-5 align-middle">
			<thead>
				<tr>
					<th scope="col">First Name</th>
					<th scope="col">Last Name</th>
					<th scope="col">Email</th>
					<th scope="col">Contact</th>
					<th scope="col">Department</th>
					<th scope="col">Position</th>
					<th scope="col">Salary</th>
					<th scope="col">Image</th>
					<th scope="col">Action</th>
				</tr>
			</thead>
			<tbody>
				<%for(int i=0;i<n;i++) { %>
					<%
						Employee item = emp.get(i);
						int id = item.getId();
					%>
					<tr>
						<td><%=item.getFirstName() %></td>
						<td><%=item.getLastName() %></td>
						<td><%=item.getEmail() %></td>
						<td><%=item.getPhone() %></td>
						<td><%=item.getDepartment() %></td>
						<td><%=item.getPosition() %></td>
						<td><%=item.getSalary() %></td>
						<td><img class="my_profile_pic" src="<%=request.getContextPath()%>/img/<%=item.getImage()%>" ></td>
						<td>
							<form style="display: inline;" action="/employee/edit" method="post">
								<input type="number" style="display: none;" name="id" value=<%=id %>>
								<button type="submit" class="btn btn-primary">Edit</button>
							</form>
							<form style="display: inline;" action="/employee/delete" method="post">
								<input type="number" style="display: none;" name="id" value="<%=id %>">
								<input type="number" style="display: none;" name="limit" value="<%=limit %>">
								<input type="number" style="display: none;" name="curPage" value="<%=currentPage %>">
								<input type="text" style="display: none;" name="position" value="<%=position %>">
								<input type="text" style="display: none;" name="department" value="<%=department %>">
								<input type="text" style="display: none;" name="url" value="<%=url %>">
								<button type="submit" class="btn btn-primary">Delete</button>
							</form>
								
						</td>
					</tr>
				<%} %>
				<%if(n==0) {%>
					<tr>
						<td class="mt-3" colspan="9"><h4>No Data</h4></td>
					</tr>
				<%} %>
			</tbody>
		</table>
		<%if(n!=0) {%>		
			<span>Page</span>
		<%} %>
		<nav aria-label="Page navigation example">
			<ul class="pagination mb-0">
				<%if(currentPage!=0) {%>
					<li class="page-item"><a class="page-link" href="${url}/<%=currentPage-1 %>?department=<%=department  %>&position=<%=position  %>&limit=<%=limit %>">Previous</a></li>
				<%} %>
				<%for(int i=0;i<totalPage;i++) {%>
					<%if(i==currentPage) {%>
						<li class="page-item active"><a class="page-link" href="${url}/<%=i %>?department=<%=department  %>&position=<%=position  %>&limit=<%=limit %>"><%= i+1 %></a></li>
					<%} 
					else {%>
						<li class="page-item"><a class="page-link" href="${url}/<%=i %>?department=<%=department  %>&position=<%=position  %>&limit=<%=limit %>"><%= i+1 %></a></li>						
					<%} %>
					
				<%} %>
				<%if(currentPage+1<totalPage) {%>				
					<li class="page-item"><a class="page-link" href="${url}/<%=currentPage+1%>?department=<%=department  %>&position=<%=position  %>&limit=<%=limit %>">Next</a></li>
				<%} %>
			</ul>
		</nav>
	</div>
</body>
</html>