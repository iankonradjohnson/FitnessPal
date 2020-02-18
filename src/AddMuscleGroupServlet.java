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

@WebServlet("/AddMuscleGroupServlet")
@MultipartConfig
public class AddMuscleGroupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
	    String name = request.getParameter("name");
	    String description = request.getParameter("description");
	    
	    HttpSession session = request.getSession();
	    String user = session.getAttribute("username").toString();
	    
	    if(name.isEmpty() || description.isEmpty() ) {
	    	out.println("<script type=\"text/javascript\">");
	    	out.println("alert(\"Please enter all required fields\");");
	    	out.println("location='add-muscle-group.jsp';");
	    	out.println("</script>");
	    	return;
	    }

	    InputStream inputStream= null;
	    
	    Part filePart = request.getPart("image");
        if (filePart.getSize() > 0 && filePart.getSize() < 7108864 && filePart.getContentType().contains("image") ) {
            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        } else if(filePart.getSize() > 7108864){
        	alert("Image too large.", "add-muscle-group.jsp", out);
        	return;
        } else if (!filePart.getContentType().contains("image")) {
        	alert("File not an image.", "add-muscle-group.jsp", out);
        	return;
		} else {	
        	alert("Please upload an image.", "add-muscle-group.jsp", out);
	    	return;
        }
        	    
	    String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal?allowMultiQueries=true";
	    
	    String query = "INSERT INTO muscle_group(name, description, image_content, user) VALUES "
	    	+ "(?, ?, ?, ?)";
	  try {
	    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
	    PreparedStatement pstmt = connection.prepareStatement( query );
	    pstmt.setString(1, name);
	    pstmt.setString(2, description);
	    pstmt.setBlob(3, inputStream);
	    pstmt.setString(4, user);
	    
	    pstmt.executeUpdate( );
	    
	    connection.close();
	  }
	  catch(Exception e) {
		  e.printStackTrace();
		  out.println("<script type=\"text/javascript\">");
		  out.println("alert('Something went wrong...');");
		  out.println("location='add-muscle-group.jsp';");
		  out.println("</script>");
		  return;
	  }
	  
	  out.println("<script type=\"text/javascript\">");
	  out.println("alert('Muscle Group Uploaded Successfully');");
	  out.println("location='browse-all-muscle-groups.jsp';");
	  out.println("</script>");
	  
	  
	}

	
	private void alert(String message, String location, PrintWriter out) {
		out.println("<script type=\"text/javascript\">");
		out.println("alert('" + message + "');");
		out.println("location='" + location + "';");
		out.println("</script>");
	}

	
}

