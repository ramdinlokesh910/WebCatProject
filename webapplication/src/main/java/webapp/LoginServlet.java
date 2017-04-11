package webapp;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/*
 * Browser sends Http Request to Web Server
 * 
 * Code in Web Server => Input:HttpRequest, Output: HttpResponse
 * JEE with Servlets
 * 
 * Web Server responds with Http Response
 */

//Java Platform, Enterprise Edition (Java EE) JEE6

//Servlet is a Java programming language class 
//used to extend the capabilities of servers 
//that host applications accessed by means of 
//a request-response programming model.

//1. extends javax.servlet.http.HttpServlet
//2. @WebServlet(urlPatterns = "/login.do")
//3. doGet(HttpServletRequest request, HttpServletResponse response)
//4. How is the response created? 

@WebServlet(urlPatterns = "/login.do") //localhost:8080 --> is directed to login.do
public class LoginServlet extends HttpServlet {

	public String input_name;
	public String course_name;
	public String user_name;
	public String ID;
	public String User_ID;
	public String UserName;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		
		//PrintWriter out = response.getWriter();
		User_ID = request.getParameter("UserID");
		UserName = request.getParameter("userName");
		
		//System.out.println(request.getParameter("name"));//getParameter from the url
		input_name = request.getParameter("name");
		//Pass the Attribute name-->to JSP 
		request.setAttribute("userName", input_name);
		
		//Here we forward page to Login.jsp
		request.getRequestDispatcher("/WEB-INF/views/Login.jsp").forward(request, response);
		

		try {
			Db_connection();
			update_userName(User_ID,UserName);
			
		} catch (Exception e) {
			System.err.println("Error!!"+e);
		}
	
		
	}//End doGet Method
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		ID = request.getParameter("ID");
		Integer.parseInt(ID);
		//input_name = request.getParameter("name");
		course_name = request.getParameter("course");
		user_name = request.getParameter("user");
		
		
		//Pass the Attribute name-->to Welcome.jsp 
		request.setAttribute("name", user_name);
	
		//Here we forward page to Welcome.jsp
		request.getRequestDispatcher("/WEB-INF/views/Welcome.jsp").forward(request, response);
	
		try {
			Db_connection();
			update_coursesTable(ID,course_name);
			
		} catch (Exception e) {
			System.err.println("Error!!"+e);
		}
		
		
				
	}//End doPost method
	
	//Database Connection 
	public Connection c;
	public Statement s;
	
	public void  Db_connection()
	{
		String Name = null;
		try 
		{
			Class.forName("com.mysql.jdbc.Driver");
		} 
		catch (Exception e)
		{
			System.out.println("Please include path Where your Driver is located");
			e.printStackTrace();
		}
		System.out.println("Driver is loaded successfully");
		try
		{
			c = DriverManager.getConnection("jdbc:mysql://localhost:3306/webcat", "root", "root");
			System.out.println("Database Connected");
			s = c.createStatement();
		} 
		catch (SQLException e) 
		{
		   e.printStackTrace();
		   System.out.println("DB connection Failed OR Database Doesnot Exist");
		}
		
//		try {
//		
//			System.out.println("JDBC is OK");
//			s.executeUpdate("INSERT INTO student VALUES ('"+Name+"','rohit_1','rohit','M',20200525,20110913) ");
//			
//		} catch (SQLException e) {
//			
//			System.err.println("Error While update ");
//		}
		
		
	}//End Database_connection method 

	//Function update courses table
	public void update_coursesTable(String ID, String course ){
	
		this.course_name = course;
		this.ID = ID;
		try {
			System.out.println("JDBC is OK");
			s.executeUpdate("INSERT INTO courses VALUES ('"+ID+"','"+course_name+"')");
		} catch (SQLException e) {
			System.out.println("JDBC is OK");
		}
		
	}//End Function update_courseTable

	public void update_userName(String ID, String userName)
	{
		this.User_ID = ID;
		this.UserName = userName;
		try {
			System.out.println("JDBC is OK");
			s.executeUpdate("INSERT INTO users VALUES ('"+User_ID+"','"+UserName+"')");
		} catch (SQLException e) {
			System.out.println("JDBC is OK");
		}
		
		
	}
}//End Class