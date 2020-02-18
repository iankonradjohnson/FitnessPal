import java.io.*;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import java.sql.*;

@WebServlet("/EditMuscleGroup")
@MultipartConfig
public class EditMuscleGroup extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    int id = Integer.parseInt(request.getParameter("id"));
	    
	    HttpSession session = request.getSession();
	    String user = session.getAttribute("username").toString();
	    
	    if(isDuplicate(request, out, id)) {
	    	alert("Dupliacate entry. Item already exists in the database.", "edit-muscle-group.jsp?id=" + id, out);
	    	return;
	    }
	    
	    if(name.isEmpty() || description.isEmpty() ) {
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert(\"Please enter all required fields\");");
	    	out.println("location='edit-muscle-group.jsp?id="+id+"';");
	    	out.println("</script>");
	    	return;
	    }

	    if(user == null){
	    	response.sendRedirect("login.jsp");
	    }

	    InputStream inputStream= null;
	    
	    Part filePart = request.getPart("image");   
	    
	    boolean hasImage = false;
	    String query;
	    
        if (filePart.getSize() > 0 && filePart.getSize() < 7108864 && filePart.getContentType().contains("image") ) {
        	inputStream = filePart.getInputStream();
            hasImage = true;
            query = "UPDATE muscle_group SET name = ?, description = ?, user = ?, image_content = ? WHERE id = ?";
        } else if(filePart.getSize() >= 7108864){
        	alert("Image too large.", "edit-muscle-group.jsp?id=" + id, out);
        	return;
        } else if(filePart.getSize() <= 0){	
        	query = "UPDATE muscle_group SET name = ?, description = ?, user = ? WHERE id = ?";
        } else if (!filePart.getContentType().contains("image")) {
        	alert("File not an image.", "edit-muscle-group.jsp?id=" + id, out);
        	return;
        } else {
        	alert("Something went wrong...", "edit-muscle-group.jsp?id=" + id, out);
        	return;
        }
	    
        System.out.println(filePart.getContentType());
        
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);
	    pstmt.setString(2, description);
	    pstmt.setString(3, user);
	    if(hasImage) {
	    	pstmt.setBlob(4, inputStream);
	    	pstmt.setInt(5, id);
	    } else {
	    	pstmt.setInt(4, id);
	    }
    
	    pstmt.executeUpdate( );
	    
	    connection.close();
	  }
	  catch(Exception e) {
		  out.println("<script type=\"text/javascript\">");
		  out.println("alert('Something went wrong...');");
		  out.println("location='edit-muscle-group.jsp?id="+Integer.toString(id)+"';");
		  out.println("</script>");
		  return;
	  }
	  
	  out.println("<script type=\"text/javascript\">");
	  out.println("alert('Muscle Group Updated Successfully');");
	  out.println("location='edit-all-muscle-groups.jsp';");
	  out.println("</script>");
	  
	  
	}
	private boolean isDuplicate(HttpServletRequest request, PrintWriter out, int id) {
		String name = request.getParameter("name");
		
		String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    String query = "SELECT * FROM muscle_group WHERE name = ? AND id != ?";

	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);
	    pstmt.setInt(2, id);

	    ResultSet rs = pstmt.executeQuery( );
	    
	    if(rs.next() == true) {
	    	connection.close();
	    	return true;
	    } 
	    connection.close();
	  }
	  catch(SQLException e) {
		  
		  alert("Something went wrong...", "edit-muscle-group.jsp?id=" + id, out);
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

