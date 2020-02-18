<%
boolean isLoggedIn = false;

if(session.getAttribute("username") != null){
	isLoggedIn = true;
}
%>

<%!
public void alert(String message, String location, JspWriter out) throws IOException {
	out.println("<script type=\"text/javascript\">");
	out.println("alert('" + message + "');");
	out.println("location='" + location + "';");
	out.println("</script>");
}

public String writeEquipmentHTML(String equipment_ids_str, JspWriter out) throws SQLException, IOException{
	String o = "<label>Equipment: </label>";
	
	if(equipment_ids_str == ""){
		return o + "none<br>";
	}
	
	String[] equipment_ids = equipment_ids_str.split(",");
	
	String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal";
	Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
    Statement statement = connection.createStatement();    
    String query = "SELECT * FROM equipment WHERE id = ?"; 
    PreparedStatement pstmt = connection.prepareStatement(query);
	
	try{
		for(String id : equipment_ids){
			pstmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			o += "<a href=\"equipment-info.jsp?id=" + id + "\">";
			o += rs.getString("name") + "</a>, ";
			o = o.substring(0, o.length()-2) + "<br>";
			
		}
	} catch(Exception e) {
		e.printStackTrace();
		alert("Something went wrong...", "index.jsp", out);
	}
	connection.close();
	
	return o;
}

public String writeMusclesHTML(String muscle_ids_str, JspWriter out) throws SQLException, IOException{
	String o = "<label>Muscles: </label>";
	
	if(muscle_ids_str == ""){
		return o + "none";
	}
	
	String[] muscle_ids = muscle_ids_str.split(",");
	
	String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal";
	Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
    Statement statement = connection.createStatement();    
    String query = "SELECT * FROM muscle WHERE id = ?"; 
    PreparedStatement pstmt = connection.prepareStatement(query);
	
	try{
		for(String id : muscle_ids){
			pstmt.setInt(1, Integer.parseInt(id));
			ResultSet rs = pstmt.executeQuery();
			rs.next();
			
			o += "<a href=\"muscle-info.jsp?id=" + id + "\">";
			o += rs.getString("name") + "</a>, ";
			
		}
		o = o.substring(0, o.length()-2) + "<br>";
	} catch(Exception e) {
		e.printStackTrace();
		alert("Something went wrong...", "index.jsp", out);
	}
	connection.close();
	
	return o;
}


%>


<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- <link href="/your-path-to-fontawesome/css/fontawesome.css" rel="stylesheet"> -->
<link rel="stylesheet" href="stylesheet.css">
</head>
<body>
<script src="https://kit.fontawesome.com/2588551113.js" crossorigin="anonymous"></script>
<div id="wrap">
<div class="sidenav">
  <a href="index.jsp"><i class="fa fa-fw fa-home"></i> Home</a>
  <button class="dropdown-btn"><i class="fas fa-heart"></i> Workouts<i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="cardio.jsp"><i class="fas fa-running"></i> Cardio</a>
    <a href="weight-lifting.jsp"><i class="fas fa-dumbbell"></i> Weight Lifting</a>
    <a href="browse-all-workouts.jsp"><i class="fas fa-search"></i> Browse All Workouts</a>
    <% if(isLoggedIn) out.print("<a href=\"add-workout.jsp\"><i class=\"fas fa-plus\"></i> Add Workout</a>"); %>
    <% if(isLoggedIn) out.print("<a href=\"edit-all-workouts.jsp\"><i class=\"fas fa-edit\"></i> Edit Your Workouts</a>"); %>
  </div>
  <button class="dropdown-btn"><i class="fas fa-dumbbell"></i> Equipment<i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="browse-all-equipment.jsp"><i class="fas fa-search"></i> Browse Equipment</a>
    <% if(isLoggedIn) out.print("<a href=\"add-equipment.jsp\"><i class=\"fas fa-plus\"></i> Add Equipment</a>"); %>
    <% if(isLoggedIn) out.print("<a href=\"edit-all-equipment.jsp\"><i class=\"fas fa-edit\"></i> Edit Your Equipment</a>"); %>
  </div>
  <button class="dropdown-btn"><i class="fas fa-swimmer"></i> Muscle Groups<i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="browse-all-muscle-groups.jsp"><i class="fas fa-search"></i> Browse Muscle Groups</a>
    <% if(isLoggedIn) out.print("<a href=\"add-muscle-group.jsp\"><i class=\"fas fa-plus\"></i> Add Muscle Group</a>"); %>
    <% if(isLoggedIn) out.print("<a href=\"edit-all-muscle-groups.jsp\"><i class=\"fas fa-edit\"></i> Edit Your Muscle Groups</a>"); %>
  </div>
  <button class="dropdown-btn"><i class="fas fa-dna"></i> Muscles<i class="fa fa-caret-down"></i>
  </button>
  <div class="dropdown-container">
    <a href="browse-all-muscles.jsp"><i class="fas fa-search"></i> Browse Muscles</a>
    <% if(isLoggedIn) out.print("<a href=\"add-muscle.jsp\"><i class=\"fas fa-plus\"></i> Add Muscle</a>"); %>
    <% if(isLoggedIn) out.print("<a href=\"edit-all-muscles.jsp\"><i class=\"fas fa-edit\"></i> Edit Your Muscles</a>"); %>
  </div>
  <% if(!isLoggedIn) out.print("<a href=\"login.jsp\"><i class=\"fa fa-user\"></i> Login</a>" +
  							   "<a href=\"register.jsp\"><i class=\"fa fa-user\"></i> Register</a>"); %>
  <% if(isLoggedIn) out.print("<a href=\"LogoutServlet\"> Logout</a>"); %>

</div>
<div class="header"><h1 class="logo"><span style="color:lightblue">Fitness</span>Pal</h1>
</div>

<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>


<% 
	String search_query = request.getParameter("search_query");
	String search_pattern = "%" + search_query + "%";
	System.out.println(search_query);
	
	String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal";
	Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");  
    String query = "SELECT * FROM workout WHERE name LIKE ? OR skill_level LIKE ? OR type LIKE ?" +
    		"OR instructions LIKE ?";
    PreparedStatement pstmt = connection.prepareStatement(query);
    pstmt.setString(1, search_pattern);
    pstmt.setString(2, search_pattern);
    pstmt.setString(3, search_pattern);
    pstmt.setString(4, search_pattern);
    
    System.out.println(pstmt);

    ResultSet rs = pstmt.executeQuery() ; 
%>
<div class="main">
	<form action="search-results.jsp">
	<div class="search-box">
	  <input class="search-txt" name="search_query" placeholder="Type to search">
	  <button class ="search-btn">
	  <i class="fas fa-search"></i>
	  </button>
	</div>
	</form>
  <hr>
  <h1><i class="fas fa-dumbbell"></i> Search Results for: <%= search_query %></h1>
  
<%

if(rs.next() == false){
	out.println("<p> Nothing found... </p>");
} else {

	do{	
	out.println("<div class=\"row\">  "  + 
			 "       <div class=\"column2\">  "  + 
			 "         <a href=\"workout-info.jsp?id=" + rs.getString("id") + "\">" +
			 "          <div class=\"container2\">  "  + 
			 "			 <img src=\"./ImageServlet?id=" + rs.getString("id") + "&table=workout\" alt=\"Bicep workout\" height=\"400\" align=\"middle\" style=\"display:block; margin:auto; max-width:100%; height:auto; max-height:400px;\">  "  + 
			 "             <div class=\"middle\">  "  + 
			 "               <div class=\"text\">" + rs.getString("name") + "</div>  "  + 
			 "             </div>  "  + 
			 "          </div>  "  + 
			 "         </a> " +
			 "       </div>  "  + 
			 "       <div class=\"column2\">  "  + 
			 "         <div class=\"description\">  "  + 
			 "           <p> " + rs.getString("name") + " </p>  "  + 
			 "           <hr>  "  + 
			 "           <p>Instructions: " + rs.getString("name") + "</p>  "  + 
			 "           <p>Skill Level: " + rs.getString("skill_level") + " </p>  "  + 
			 "           <p>Type: " + rs.getString("type") + "</p>  "  + 
             writeEquipmentHTML(rs.getString("equipment_ids"), out)+ "<br>" +
             writeMusclesHTML(rs.getString("muscle_ids"), out)+ 
			 "           <a href=\"workout-info.jsp?id=" + rs.getString("id") + "\">Click here to see workout.</a>"  + 
			 "             "  + 
			 "             <br>  "  + 
			 "             <br>  "  + 
			 "             <br>  "  + 
			 "         </div>  "  + 
			 "       </div>  "  + 
			 "     </div>  "  + 
			 "   <hr>  "  + 
			 "    "  );
	}while(rs.next());
}
%>
</div>	
<footer>
<div class="footer">
    <div class="footer-content">
      <div class="footer-section about">
        <h1 class="logo"><span style="color:lightblue">Fitness</span>Pal</h1>
        <p>FitnessPal is a fitness website conceived for the purpose improving ones health body
        by showing the best workouts to stay fit and strong.</p>
        <div class="contact">
          <span><i class="fas fa-envelope"></i> &nbsp; infor@fitnesspal.com</span>
          <span><i class="fas fa-phone"></i> &nbsp; 123-456-7890</span>
        </div>
        <div class="socials">
          <a href="#"><i class="fab fa-twitter"></i></a>
          <a href="#"><i class="fab fa-instagram"></i></a>
          <a href="#"><i class="fab fa-facebook"></i></a>
          <a href="https://www.youtube.com"><i class="fab fa-youtube"></i></a>
        </div>
      </div>
      <div class="footer-section links">
        <h2>Links</h2>
        <br>
        <ul>
         <li><a href="browse-all-equipment.jsp">Equipment</a></li>
        	<li><a href="browse-all-muscle-groups.jsp">Muscle Groups</a></li>
        	<li><a href="browse-all-muscles.jsp">Muscles</a></li>
        	<li><a href="browse-all-workouts.jsp">Workouts</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      &copy; FitnessPal.com | Designed by Ian Johnson & Bum Kwon
    </div>
  </div>
</footer>
</div>
<script>
/* Loop through all dropdown buttons to toggle between hiding and showing its dropdown content - This allows the user to have multiple dropdowns without any conflict */
var dropdown = document.getElementsByClassName("dropdown-btn");
var i;

for (i = 0; i < dropdown.length; i++) {
  dropdown[i].addEventListener("click", function() {
  this.classList.toggle("active");
  var dropdownContent = this.nextElementSibling;
  if (dropdownContent.style.display === "block") {
  dropdownContent.style.display = "none";
  } else {
  dropdownContent.style.display = "block";
  }
  });
}
</script>
</body>
</html>

