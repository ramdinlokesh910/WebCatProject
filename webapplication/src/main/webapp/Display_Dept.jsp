<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!-- Import Libraries -->

<!-- Note: Here the images folder should be inside webapp and parallel to WEB-INF -->
 <img alt="Welcome" src="../images/wiu_logo.jpg"  height="150" width="100"/> 
<br><br>


<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<!-- Here we are setting the Database Connection -->
<%
String id = request.getParameter("userId");
String driverName = "com.mysql.jdbc.Driver";
//String connectionUrl = "jdbc:mysql://localhost:3306/";

String connectionUrl = "jdbc:mysql://54.244.208.190:3306/";

String dbName = "Webcat";
String userId = "root";
String password = "root";

try {
Class.forName(driverName);
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = null;
Statement statement = null;
ResultSet resultSet = null;
%>

<!-- Here we are declaring a table -->		
<h2 align="center"><font><strong>Retrieve data from database in jsp</strong></font></h2>
<table align="center" cellpadding="5" cellspacing="5" border="1">
		<tr>
		
		</tr>
		<tr bgcolor="#A52A2A">
		<td><b>Dept_abbrevation</b></td>
		<td><b>OID</b></td>
		<td><b>C_name</b></td>
		<td><b>C_InstituionID</b></td>
		
		</tr>
		
		<!-- Here we are calling Data From database -->		
		<%
		try{ 
		connection = DriverManager.getConnection(connectionUrl+dbName, userId, password);
		statement=connection.createStatement();
		String sql ="SELECT * FROM TDEPARTMENT";
		
		resultSet = statement.executeQuery(sql);
		while(resultSet.next()){
		%>
		<tr bgcolor="#DEB887">
		
		<td><%=resultSet.getString("CABBREVIATION") %></td>
		<td><%=resultSet.getString("OID") %></td>
		<td><%=resultSet.getString("CNAME") %></td>
		<td><%=resultSet.getString("CINSTITUTIONID") %></td>
		
		</tr>
		
		<% 
		}
		
		} catch (Exception e) {
		e.printStackTrace();
		}
		%>
</table>

