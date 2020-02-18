import java.io.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.sql.*;

@WebServlet("/AddEquipmentServlet")
@MultipartConfig
public class AddEquipmentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    String type = request.getParameter("type");
	    
	    HttpSession session = request.getSession();
	    String user = session.getAttribute("username").toString();
	    
	    if(isDuplicate(request, out)) {
	    	alert("Duplocate Entry. Item already exists in the database.", "add-equipment.jsp", out);
	    	return;
	    }
	    
	    if(name.isEmpty() || description.isEmpty() || type.isEmpty()) {
	    	alert("Please enter all required fields", "add-equipment.jsp", out);
	    	return;
	    }
	    
	    InputStream inputStream= null;
	    
	    Part filePart = request.getPart("image");
        if (filePart.getSize() > 0 && filePart.getSize() < 7108864 && filePart.getContentType().contains("image") ) {
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        } else if(filePart.getSize() > 7108864){
        	alert("Image too large.", "add-equipment.jsp", out);
        	return;
        } else if (!filePart.getContentType().contains("image")) {
        	alert("File not an image.", "add-equipment.jsp", out);
        	return;
		} else {	
        	alert("Please upload an image.", "add-equipment.jsp", out);
	    	return;
        }
        	    
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	    String query = "INSERT INTO equipment(name, description, workout_type, "
	    	+ "image_content, user) VALUES "
	    	+ "(?, ?, ?, ?, ?)";
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);
	    pstmt.setString(2, description);
	    pstmt.setString(3, type);
	    pstmt.setBlob(4, inputStream);
	    pstmt.setString(5, user);
	    
	    pstmt.executeUpdate( );
	    
	    connection.close();
	  }
	  catch(Exception e) {
		  alert("Something went wrong...", "add-equipment.jsp", out);
		  return;
	  }
	  
	  alert("Equipment Uploaded Successfully", "browse-all-equipment.jsp", out);
	}
	
	private boolean isDuplicate(HttpServletRequest request, PrintWriter out) {
		String name = request.getParameter("name");
		
		String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    String query = "SELECT * FROM equipment WHERE name = ?";

	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);

	    ResultSet rs = pstmt.executeQuery( );
	    
	    if(rs.next() == true) {
	    	connection.close();
	    	return true;
	    } 
	    connection.close();
	  }
	  catch(SQLException e) {
		  
		  alert("Something went wrong...", "add-equipment.jsp", out);
	  }
	  
	  return false;
		
	}
	
	private void alert(String message, String location, PrintWriter out) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('" + message + "');");
		out.println("location='" + location + "';");
		out.println("</script>");
	}
	
}

