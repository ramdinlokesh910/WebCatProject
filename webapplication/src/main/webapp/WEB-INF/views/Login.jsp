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
<img alt="Welcome" src="../images/wiu_logo.jpg"  height="150" width="100"/>
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
				<table>
						<tbody>
							 <tr>
									<td>Select User:</td>
									<td>
										<select name="userName"> 
											<option value="">Select User </option>
											<option value="userA">--A--</option>
											<option value="userB">--B--</option>
											<option value="userC">--C--</option>
											<option value="userD">--D--</option>
										</select>
									</td>	
								</tr><tr></tr>
								<tr>
									<td>Select Department:</td>
									<td>
										<select name="Department"> 
											<option value="">Select Department </option>
											<option value="cs">--Computer Science--</option>
											<option value="chem">--Chemistry--</option>
											<option value="FA">--Fine-Arts--</option>
											<option value="LEN">--Law-Enforcement--</option>
										</select>
									</td>	
								</tr><tr></tr>
								
								<tr>
									<td>Courses:</td>
									<td>
										<select name="courses"> 
											<option value="">Select Courses </option>
											<option value="CN">Computer Networks</option>
											<option value="IP">Intensive Programming</option>
										</select>
									</td>	
								</tr><tr></tr>
								
								<tr>
									<td>Assignment:</td>
									<td>
										<select name="assignment"> 
											<option value="">Select Assignment </option>
											<option value="ass1">Assi-1	 </option>
											<option value="ass2">Assi-2	 </option>
											<option value="ass3">Assi-3	 </option>
											<option value="ass4">Assi-4	 </option>
											<option value="ass5">Assi-5	 </option>
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