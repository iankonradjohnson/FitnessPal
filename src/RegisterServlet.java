import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import java.sql.*;

@WebServlet("/RegisterServlet")
@MultipartConfig
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    String full_name = request.getParameter("full-name");
	    String email = request.getParameter("email");
	    String username = request.getParameter("username");
	    String password = request.getParameter("password");
	    String confirm_password = request.getParameter("confirm-password");
	    
	    if(full_name.isEmpty() || email.isEmpty() || username.isEmpty() || password.isEmpty() || confirm_password.isEmpty()) {
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert(\"Please enter all required fields\");");
	    	out.println("location='register.jsp';");
	    	out.println("</script>");
	    }
	    
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	    String query = "SELECT * FROM user WHERE username = ?";
		try {
		    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
		    PreparedStatement pstmt = connection.prepareStatement( query );
		    pstmt.setString(1, username);
	
		    ResultSet rs = pstmt.executeQuery( );
		    
		    if(rs.next()) {
		    	alert("User already exists", "register.jsp", out);
		    	connection.close();
		    	return;
		    }
		    connection.close();
	    
		}
		catch(SQLException e) {
			alert("Something went wrong", "login.jsp", out);
			return;
		}
			    
	    
	    
	    		    
	    if(!password.equals(confirm_password)){
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert(\"Please enter the same password for 'Confirm Password'\");");
	    	out.println("location='register.jsp';");
	    	out.println("</script>");
	    	return;
	    }
        	    
	    
	    
	    query = "INSERT INTO user(full_name, email, username, password) VALUES "
	    	+ "(?, ?, ?, ?)";
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, full_name);
	    pstmt.setString(2, email);
	    pstmt.setString(3, username);
	    pstmt.setString(4, password);
	    
	    pstmt.executeUpdate( );
	    
	    connection.close();
	  }
	  catch(SQLException e) {
		  out.println("<script type=\"text/javascript\">");
		  out.println("alert('Please enter all required fields');");
		  out.println("location='register.jsp';");
		  out.println("</script>");
		  return;
	  }
	  catch(Exception e) {
		  out.println("<script type=\"text/javascript\">");
		  out.println("alert('Something went wrong...');");
		  out.println("location='register.jsp';");
		  out.println("</script>");
	  }
	  
	  HttpSession session=request.getSession();  
      session.setAttribute("username",username);
	  
	  out.println("<script type=\"text/javascript\">");
	  out.println("alert('Register Successful');");
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

