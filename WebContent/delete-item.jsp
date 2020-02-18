<%
boolean isLoggedIn = false;

if(session.getAttribute("username") != null){
	isLoggedIn = true;
} else {
	response.sendRedirect("login.jsp");
}
%>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>

<% 
	int id = Integer.parseInt(request.getParameter("id"));
	String table = request.getParameter("table");
	String dbURL = "jdbc:mysql://localhost/MyFitnessPal";
    Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
    String query = "DELETE FROM " + table + " WHERE id = ?";
    PreparedStatement pstmt = connection.prepareStatement(query);  
    pstmt.setInt(1, id);
    
    System.out.println(pstmt);
    
    pstmt.executeUpdate() ; 
    connection.close();
%>

<script>
alert("Item deleted successfully")
location='index.jsp'
</script>

