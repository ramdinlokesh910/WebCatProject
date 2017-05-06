<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Department JSP Page</title>
</head>
<body>

<h2 >Department Welcome Page!!</h2>
<!-- Note: Here the images folder should be inside webapp and parallel to WEB-INF -->
 <img alt="Welcome" src="../images/wiu_logo.jpg"  height="150" width="100"/> 
<br><br>
		<form action="/dept_servlet" method="get">
						<table>
								<tbody>
										<tr>
											<td>Department Abbreviation:</td>
											<td><input type="text" name="Dept_ABR" size="50"/></td>
										</tr>
										
										<tr>
											<td>Department ID:</td>
											<td><input type="text" name="Dept_ID" size="50"/></td>
										</tr>		
												
										<tr>
											<td>Department Name:</td>
											<td><input type="text" name="Dept_Name" size="50"/></td>
										</tr>		
										
										<tr>
											<td>INstituion ID:</td>
											<td><input type="text" name="Inst_ID" size="50"/></td>
										</tr>		
										
										<tr>
												<td><input type="submit" value="Create_Dept"></td>	
										</tr>
										
								</tbody>
								
						</table>
				
				 <input type="reset" value="Clear" name="clear"/>
				 <input type="submit" value="Submit" name="Submit"/>
				
				
				
				</form>
		

</body>
</html>