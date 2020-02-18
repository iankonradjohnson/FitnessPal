

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	    String query = "SELECT * FROM user WHERE username = ? AND password = ?";
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, username);
	    pstmt.setString(2, password);

	    ResultSet rs = pstmt.executeQuery( );
	    
	    if(rs.next() == false) {
	    	alert("Username or password not found", "login.jsp", out);
	    	connection.close();
	    	return;
	    }
	    
	    rs.next();
	    connection.close();
    
	  }
	  catch(SQLException e) {
		  
		  alert("Please enter all required fields", "login.jsp", out);
		  return;
	  }
	  catch(Exception e) {
		  alert("Something went wrong...", "login.jsp", out);
		  return;
	  }
	  
	  HttpSession session=request.getSession();  
      session.setAttribute("username",username);
	  
	  out.println("<script type=\"text/javascript\">");
	  out.println("alert('Login Successful');");
	  out.println("location='index.jsp';");
	  out.println("</script>");
	  
	  
		
	}
	
	private void alert(String message, String location, PrintWriter out) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('" + message + "');");
		out.println("location='" + location + "';");
		out.println("</script>");
	}
	



}
