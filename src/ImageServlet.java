

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * SOURCE: https://www.youtube.com/watch?v=adFB8BU1ExQ
 */
@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	resp.setContentType("text/html;charset=UTF-8");
	byte[] img = null;
	ServletOutputStream o = null;
	
	String table = req.getParameter("table");
	
	String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal";
	String query = "SELECT image_content FROM " + table + " WHERE id = ?";
			
	int id = Integer.parseInt(req.getParameter("id"));

	try {
		Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
		PreparedStatement pstmt = connection.prepareStatement(query);
		pstmt.setInt(1, id);
		
		System.out.println(pstmt);
		
		ResultSet rs = pstmt.executeQuery();
		if(rs.next()) {
			img = rs.getBytes("image_content");
		}
		
		o = resp.getOutputStream();
		o.write(img);
		
		
		connection.close();
	} catch(Exception e) {
		
		PrintWriter out = resp.getWriter();
		out.print("Oops, something went wrong...");
	}
}
	
	
}

