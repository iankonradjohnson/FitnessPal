<%
boolean isLoggedIn = false;

if(session.getAttribute("username") != null){
	isLoggedIn = true;
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
  <h1><i class="fas fa-dumbbell"></i> WeightLifting</h1>
  <div class="row" id="match">
    <div class="column2">
      <div class="container2">
        <img src="dumbellPress.jpg" alt="dumbell press workout" style="width:100%">
          <div class="middle">
            <div class="text">Dumbbell Bench Press</div>
          </div>
      </div>
    </div>
    <div class="column2">
      <div class="description">
        <p>Chest</p>
        <hr>
        <p>The chest is one of the most popular muscles worked out on.
          The chest is composed of some of the largest muscles in your body.
          The chest muscle is called Pectoralis major, and there are 2 parts of the chest you can isolate during your chest workout: Pectoralis major and the Pectoralis minor.</p>
          <br>
          <br>
          <br>
              <br>
              <br>
              <br>
      </div>
    </div>
  </div>
<hr>

	<div class="row">
	  <div class="column2">
	    <div class="description">
	      <p>Legs</p>
	      <hr>
	      <p>Having a strong lower body is crucial to your fitness, whether you are looking to
	      improving your daily fitness, sports performance, or gym work. The most common leg excercies are for quads, calves, and hamstrings.</p>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	    </div>
	  </div>
	<div class="column2">
	  <div class="container2">
	    <img src="squat.jpg" alt="legworkout" style="width:100%">
	      <div class="middle">
	        <div class="text">Barbell Squat</div>
	      </div>
	  </div>
	</div>
	</div>


<hr>
  <div class="row">
    <div class="column2">
      <div class="container2">
        <img src="back.jpg" alt="backworkout" style="width:100%">
          <div class="middle">
            <div class="text">Back</div>
          </div>
      </div>
    </div>
    <div class="column2">
      <div class="description">
        <p>Back</p>
        <hr>
        <p>If you have back pain or aching, you can know how miserable it can be. Every move you make engages you back in one way or another
        So Strengthening your back muscles can prevent these type of injuries and also allows your entire body to work smoothly and build a good foundation for other workouts.</p>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
      </div>
    </div>
  </div>
<hr>
	<div class="row">
	  <div class="column2">
	    <div class="description">
	      <p>Arms</p>
	      <hr>
	      <p>Arm workouts are critical to get bigger arms. The most common muscle groups are biceps, triceps, and forearms. In order to look BIG, you gotta train BIG. </p>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	    </div>
	  </div>
	<div class="column2">
	  <div class="container2">
	    <img src="arms.jpg" alt="armworkout" style="width:100%">
	      <div class="middle">
	        <div class="text">Bicep Curl</div>
	      </div>
	  </div>
	</div>
	</div>
<hr>
  <div class="row">
    <div class="column2">
      <div class="container2">
        <img src="shoulders.jpg" alt="shoulderworkout" style="width:100%">
          <div class="middle">
            <div class="text">Shoulders</div>
          </div>
      </div>
    </div>
    <div class="column2">
      <div class="description">
        <p>Shoulders</p>
        <hr>
        <p>Shoulder workouts are a great way to broaden your stance and help with balance. 
        Shoulder workouts range from compound lifts to more isolated motions. The purpose 
        of the compund lifts is to strengthen the general muscle group, whereas isolation 
        workouts exercise muscles more specifically. </p>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
      </div>
    </div>
  </div>
<hr>
	<div class="row">
	  <div class="column2">
	    <div class="description">
	      <p>Abs</p>
	      <hr>
	      <p>Ab workouts workout the abdominal muscles. It is important that you use abs in all excercises, but to 
	      primarily target the abdominal muscles in an isolated fashion, it is crucial to do ab workouts. Not only
	      will working abs transform your other lifts, but it will give you a sense of pride when you look at your
	      beautiful washboard abs. </p>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	    </div>
	  </div>
	<div class="column2">
	  <div class="container2">
	    <img src="arms.jpg" alt="abworkout" style="width:100%">
	      <div class="middle">
	        <div class="text">Crunch</div>
	      </div>
	  </div>
	</div>
	</div>
<hr>
  <div class="row">
    <div class="column2">
      <div class="container2">
        <img src="shoulders.jpg" alt="shoulderworkout" style="width:100%; height:100%">
          <div class="middle">
            <div class="text">Squats</div>
          </div>
      </div>
    </div>
    <div class="column2">
      <div class="description">
        <p>Buttocks</p>
        <hr>
        <p>Buttocks workouts will work out your glutes, and will strengthen 
        the muscles that connect your lower and upper bodies. They will also make 
        you look dumb thicc if you work them out properly. </p>
          <br>
          <br>
          <br>
          <br>
          <br>
          <br>
      </div>
    </div>
  </div>
<hr>
	<div class="row">
	  <div class="column2">
	    <div class="description">
	      <p>Hips</p>
	      <hr>
	      <p>Hip workouts are great for working out your hips. </p>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	      <br>
	    </div>
	  </div>
	<div class="column2">
	  <div class="container2">
	    <img src="arms.jpg" alt="abworkout" style="width:100%">
	      <div class="middle">
	        <div class="text">Lunges</div>
	      </div>
	  </div>
	</div>
	</div>
<hr>


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
          <a href="browse-all-equipment.jsp"><li>Equipment</li></a>
          <a href="browse-all-muscle-groups.jsp"><li>Muscle Groups</li></a>
          <a href="browse-all-muscles.jsp"><li>Muscles</li></a>
          <a href="browse-all-workouts.jsp"><li>Workouts</li></a>
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
