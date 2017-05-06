"src/main/webapp/WEB-INF/views/Welcome.jsp"<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<%
	String user = request.getParameter("userName");
	String dept = request.getParameter("Department");
	String course = request.getParameter("courses");

%>

<body>
<img alt="Welcome" src="../images/wiu_logo.jpg"  height="150" width="100"/>
<table>
	<tr>
		<td>
			Welcome <%= user %>
		</td>
	</tr>	

</table>


</body>
</html>