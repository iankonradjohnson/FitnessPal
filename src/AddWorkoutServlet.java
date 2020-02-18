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

@WebServlet("/AddWorkoutServlet")
@MultipartConfig
public class AddWorkoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    String name = request.getParameter("name");
	    String skill_level = request.getParameter("skill_level");
	    String type = request.getParameter("type");
	    String [] equipment_ids = request.getParameterValues("equipment");
	    String [] muscle_ids = request.getParameterValues("muscles");
	    String instructions = request.getParameter("instructions");
	    String video = request.getParameter("video");
	    
	    
	    if(name.isEmpty() || skill_level.isEmpty() || type.isEmpty() || muscle_ids == null || instructions.isEmpty() || video.isEmpty()) {
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert(\"Please enter all required fields\");");
	    	out.println("location='add-workout.jsp';");
	    	out.println("</script>");
	    	return;
	    }
	   	    
	    if (!video.matches("^(https?\\:\\/\\/)?(www\\.)?(youtube\\.com|youtu\\.?be)\\/.+$")) {
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert('Please enter a proper youtube url');");
	    	out.println("location='add-workout.jsp';");
	    	out.println("</script>");
	    	return;
	    }
	    
	    HttpSession session = request.getSession();
	    String user = session.getAttribute("username").toString();
	    
	    if(isDuplicate(request, out)) {
	    	alert("Dupliacate entry. Item already exists in the database.", "add-workout.jsp", out);
	    	return;
	    }
	    
	    String equipment_str = "";
	    String muscles_str = "";
	    	    
	    if(equipment_ids != null)
	    	equipment_str = String.join(",", equipment_ids);
	    if(muscle_ids != null)
	    	muscles_str = String.join(",", muscle_ids);
	    
	    
	    InputStream inputStream= null;
	    
	    Part filePart = request.getPart("image");
	   	    
        if (filePart.getSize() > 0 && filePart.getSize() < 7108864 && filePart.getContentType().contains("image") ) {
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        } else if(filePart.getSize() > 7108864){
        	alert("Image too large.", "add-workout.jsp", out);
        	return;
        } else if (!filePart.getContentType().contains("image")) {
        	alert("File not an image.", "add-workout.jsp", out);
        	return;
		} else {	
        	alert("Please upload an image.", "add-workout.jsp", out);
	    	return;
        }
        	    
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	    String query = "INSERT INTO workout(name, skill_level, type, "
	    	+ "equipment_ids, muscle_ids, instructions, image_content, video, user) VALUES "
	    	+ "(?, ?, ?, ?, ?, ?, ?, ?, ?)";
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);
	    pstmt.setString(2, skill_level);
	    pstmt.setString(3, type);
	    pstmt.setString(4, equipment_str);
	    pstmt.setString(5, muscles_str);
	    pstmt.setString(6, instructions);
	    pstmt.setBlob(7, inputStream);
	    pstmt.setString(8, video);
	    pstmt.setString(9, user);
	    
	    System.out.println(pstmt);
	    
	    pstmt.executeUpdate( );
	    
	    connection.close();
	  }
	  catch(Exception e) {
		  e.printStackTrace();
		  
		  out.println("<script type=\"text/javascript\">");
		  out.println("alert('Something went wrong...');");
		  out.println("location='add-workout.jsp';");
		  out.println("</script>");
		  return;
	  }
	  
	  out.println("<script type=\"text/javascript\">");
	  out.println("alert('Workout Uploaded Successfully');");
	  out.println("location='browse-all-workouts.jsp';");
	  out.println("</script>");
	  
	  
	}
	
	private boolean isDuplicate(HttpServletRequest request, PrintWriter out) {
		String name = request.getParameter("name");
		
		String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    String query = "SELECT * FROM workout WHERE name = ?";

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
		  
		  alert("Something went wrong...", "add-workout.jsp", out);
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

