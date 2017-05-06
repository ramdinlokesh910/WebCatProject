package webapp;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class dept_servlet
 */
@WebServlet("/dept_servlet")
public class dept_servlet extends HttpServlet {
	
	public static String Dept_abbrevation;
	public static int Dept_ID;
	public static String Dept_Name;
	public static int Instution_ID;
	private static final long serialVersionUID = 1L;
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().println("Hello amazon cloud");
		Dept_abbrevation  = request.getParameter("Dept_ABR");
		
		//---
		String Department_ID = request.getParameter("Dept_ID");
		Dept_ID = Integer.parseInt(Department_ID);
		
		Dept_Name = request.getParameter("Dept_Name");
		
		//--
		String INst_id = request.getParameter("Inst_ID");
		Instution_ID = Integer.parseInt(INst_id);
		//System.out.println("Department Abbrevation:"+Dept_abbrevation);
		
		try {
			Db_connection();
			update_DeptTable(Dept_abbrevation,Dept_ID,Dept_Name,Instution_ID);
			
		} catch (Exception e) {
			System.err.println("Error Updating..!!"+e);
		}
		
		//Pass the Attribute name-->to JSP 
		request.setAttribute("Dept_abbrevation", Dept_abbrevation);
		request.setAttribute("Dept_ID", Dept_ID);
		request.setAttribute("Dept_Name", Dept_Name);
		request.setAttribute("Instution_ID", Instution_ID);
		
		//Here we forward page to Display_Dept.jsp
		request.getRequestDispatcher("/Display_Dept.jsp").forward(request, response);
				
		
	//This is response back to the server/ the page
	response.getWriter().append("Served at: "+Dept_abbrevation+"||"+Dept_ID+"||"+Dept_Name+"||"+Instution_ID).append(request.getContextPath());
	
	}//End doGet

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}//End Function doPost

	//Database Connection 
	public static Connection c;
	public static Statement s;
	
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
	
	//Function update department table
		public void update_DeptTable(String Depat_Abbrevtion, int OID, String cname, int c_instID ){
		
			
			this.Dept_abbrevation = Depat_Abbrevtion;
			this.Dept_ID = OID;
			this.Dept_Name = cname;
			this.Instution_ID = c_instID;
			
	try {
	System.out.println("JDBC is OK");
	s.executeUpdate("INSERT INTO DEPARTMENT VALUES ('"+Dept_abbrevation+"',"+Dept_ID+",'"+Dept_Name+"',"+Instution_ID+")");
	} catch (SQLException e) {
		System.out.println("JDBC is OK");
	}
			
		}//End Function update_courseTable
	
}//End Class
