<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html > <!-- Comments: This is HTML-5  -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Yahoo From JSP</title>
</head>
<body>

<h2>Web Cat Welcome Page!!</h2>
<br>

<%-- 
Hello  ${name}


<%
	System.out.print("parameter Got from url: "+request.getParameter("name"));
	Date date = new Date();
	
%>


<br>
<div> Todays Date is <%= date %></div>

--%>
			
		<form action="/login.do" method="post">
				<table ">
						<tbody>
							
							<!-- 
								<tr>
									<td>Enter ID:</td>
									<td><input type="text" name="ID" size="50"/></td>
								</tr>
								
								<tr>
									<td>Course Name:</td>
									<td><input type="text" name="course" size="50"/></td>
								</tr>		
										
								<tr>
									<td>User Name:</td>
									<td><input type="text"  name="user" size="50"/></td>
								</tr>
								<tr>
										<td><input type="submit" value="Login"></td>	
								</tr>
							 -->	
							 <tr>
									<td>Select User:</td>
									<td>
										<select name="userName"> 
											<option>Select User </option>
											<option>--A--</option>
											<option>--B--</option>
											<option>--C--</option>
											<option>--D--</option>
										</select>
									</td>	
								</tr><tr></tr>
								<tr>
									<td>Select Department:</td>
									<td>
										<select name="Department"> 
											<option>Select Department </option>
											<option>--Computer Science--</option>
											<option>--B--</option>
											<option>--C--</option>
											<option>--D--</option>
										</select>
									</td>	
								</tr><tr></tr>
								
								
								<tr>
									<td>Courses:</td>
									<td>
										<select name="courses"> 
											<option>Select Courses </option>
											<option>Computer Networks</option>
											<option>Intensive Programming</option>
										</select>
									</td>	
								</tr><tr></tr>
								
								<tr>
									<td>Assignment:</td>
									<td>
										<select name="courses"> 
											<option>Select Assignment </option>
											<option>Assi-1	 </option>
											<option>Assi-2	 </option>
											<option>Assi-3	 </option>
											<option>Assi-4	 </option>
											<option>Assi-5	 </option>
										</select>
									</td>	
								</tr>
								
											
						</tbody>
						
				</table>
		
		 <input type="reset" value="Clear" name="clear"/>
		 <input type="submit" value="Submit" name="Submit"/>
		
		
		
		</form>

</body>
</html>