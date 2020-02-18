<%
boolean isLoggedIn = false;

if(session.getAttribute("username") != null){
	isLoggedIn = true;
} else {
	response.sendRedirect("login.jsp");
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
		return o + "none<br><br>";
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
		return o + "none<br>";
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
	int id = Integer.parseInt(request.getParameter("id"));
String dbURL = "jdbc:mysql://localhost:3306/MyFitnessPal";
Connection connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
    String query = "SELECT * FROM workout WHERE id = ?";
    PreparedStatement pstmt = connection.prepareStatement(query);   
    pstmt.setInt(1, id);
    ResultSet rs = pstmt.executeQuery() ; 
    rs.next();
    //int muscle_group_id = rs.getInt("muscle_group_id");
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
	<h1><i class="fas fa-dumbbell"></i> Edit Workout</h1>
	<p> To edit a workout, please fill out the following fields:</p>
  
  	<form id="edit-workout" action="EditWorkout?id=<%= id %>" method="post" enctype="multipart/form-data">
  		<section class="first">
          	<fieldset class="first_fieldset">
              	<legend>Workout</legend>
              	<label> Workout Name: </label><br>
              	<input type="text" style="width:100%" name = "name" size="25" value="<%= rs.getString("name") %>"><br>
              	<label> Skill Level: </label>
              	<label> Type: </label>
              	<select name="skill_level" style="width:100%">
              		<% 
              		if(rs.getString("skill_level").equals("Beginner")){
              			out.println("<option value=\"Beginner\" selected>Beginner</option>");
              			out.println("<option value=\"Intermediate\">Intermediate</option>");
              			out.println("<option value=\"Advanced\">Advanced</option>");

              		} else if(rs.getString("skill_level").equals("Intermediate")){
              			out.println("<option value=\"Beginner\">Beginner</option>");
              			out.println("<option value=\"Intermediate\" selected>Intermediate</option>");
              			out.println("<option value=\"Advanced\">Advanced</option>");
              		} else {
              			out.println("<option value=\"Beginner\">Beginner</option>");
              			out.println("<option value=\"Intermediate\">Intermediate</option>");
              			out.println("<option value=\"Advanced\" selected>Advanced</option>");
              		}
              		%>
                </select><br>
              	<br>
              	<label> Type: </label>
              	<select name="type" style="width:100%">
              		<% 
              		if(rs.getString("type").equals("Weight Training")){
              			out.println("<option value=\"Weight Training\" selected>Weight Training</option>");
              			out.println("<option value=\"Cardio\">Cardio</option>");

              		} else {
              			out.println("<option value=\"Weight Training\">Weight Training</option>");
              			out.println("<option value=\"Cardio\" selected>Cardio</option>");
              		}
              		%>
                </select><br>
                
                <br><label> Equipment: (Choose any of the following)</label><br>
                
                <%@ page import="java.sql.*" %>
				<%@ page import="java.io.*" %>
                <% 
			    connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
			    query = "SELECT * FROM equipment";
			    PreparedStatement pstmt2 = connection.prepareStatement(query);   
			    
			    ResultSet rs2 = pstmt2.executeQuery();
			    String equipment = "";
			    boolean match = false;
			    while(rs2.next()){
			    	match = false;
			    	equipment = rs.getString("equipment_ids");
			    	String[] equipment_list = equipment.split(",");
			    	
			    	for(String item : equipment_list){ if(item.equals(rs2.getString("id"))) match = true;}
			    	
			    	if(match)
		    			out.println("<input type=\"checkbox\" name=\"equipment\" value=\"" + rs2.getString("id") + "\" checked> " + rs2.getString("name") + "<br>");
			    	else
		    			out.println("<input type=\"checkbox\" name=\"equipment\" value=\"" + rs2.getString("id") + "\"> " + rs2.getString("name") + "<br>");
			    }
				%>
  				
                <br><label> Muscles Worked: (Choose any of the following)</label><br>
                <% 
                connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
			    query = "SELECT * FROM muscle_group";
			    pstmt2 = connection.prepareStatement(query);   
			    
			    rs2 = pstmt2.executeQuery();
			    //connection.close();
			    
			    while(rs2.next()){
			    	String muscle_group_id = rs2.getString("id");
			    	out.println("<br><label> " + rs2.getString("name")+ " </label><br>");
			    	connection = DriverManager.getConnection(dbURL, "root", "BACHlover1234");
				    query = "SELECT * FROM muscle WHERE muscle_group_id = ?";
				    PreparedStatement pstmt3 = connection.prepareStatement(query); 
				    pstmt3.setString(1, muscle_group_id);
				    
				    ResultSet rs3 = pstmt3.executeQuery();
				    String muscles = "";
				    
				    while(rs3.next()){
				    	match = false;
				    	muscles = rs.getString("muscle_ids");
				    	String[] muscle_list = muscles.split(",");
				    	
				    	for(String item : muscle_list){ if(item.equals(rs3.getString("id"))) match = true;}
				    	
				    	if(match)
			    			out.println("<input type=\"checkbox\" name=\"muscles\" value=\"" + rs3.getString("id") + "\" checked> " + rs3.getString("name") + "<br>");
				    	else
			    			out.println("<input type=\"checkbox\" name=\"muscles\" value=\"" + rs3.getString("id") + "\"> " + rs3.getString("name") + "<br>");
				    }
			    } 

                %>
            
                <br><label> Workout Image: </label><br>
                <input type="file" name="image"><br>
                
                <br><label> Workout Video (YouTube Video): </label><br>
                <input type="text" name="video" style="width:100%" pattern="^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$" value=<%= rs.getString("video") %>><br>
                
  				<label> Instructions: </label>
  				<textarea name="instructions" ><%= rs.getString("instructions") %></textarea><br> 
  				
  			</fieldset>
  			</section>
      	 <button type="submit" style="width:100%">Submit</button>
  	 </form>            
  
  
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
          <a href="https://twitter.com"><i class="fab fa-twitter"></i></a>
          <a href="https://www.instagram.com"><i class="fab fa-instagram"></i></a>
          <a href="https://www.facebook.com"><i class="fab fa-facebook"></i></a>
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
function calc(){
  var n1, n2;
  n1 = document.getElementsById("n1").value;
  n2 = document.getElementById("n2").value;
  var workout = document.getElementById("opr").value;
  if(workout == '0'){
    var calories = 5;
      var x = n1*n2;
      document.getElementById("results").innerHTML = x;
  }
}


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
