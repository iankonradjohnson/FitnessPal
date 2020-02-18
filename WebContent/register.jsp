<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register Page</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
<body class="login_body">
    <main>
        <div class="login_container">
            <div class="register_form">
                <h1  class="login_heading"><br>Register a New Account</h1>
                <form id="register_form" name="login_form" action="RegisterServlet" method="post">
                    <!-- <label class="label_class">Name</label><br> -->
                    <input type="text" id="full-name" name="full-name" placeholder="Full Name"><br>

                    <!-- <label class="label_class">Password</label> -->
                    <input type="text" id="email" name="email" placeholder="Email"><br>
                    <input type="text" id="username" name="username" placeholder="Username"><br>
                    <input type="password" id="password" name="password" placeholder="Password"><br>
                    <input type="password" id="confirm-password" name="confirm-password" placeholder="Confirm Password"><br>
                    <!-- <label class="label_class">&nbsp;</label> -->
                    <button type="submit" id="register">Sign Up</button>

                    <p class="login_text">Already have an account? <a href="login.jsp">Log in</a></p>
                    <p class="login_text">Not where you want to be? <a href="index.jsp">Go Home</a></p>
                    

                </form>
            </div>
        </div>
    </main>
</body>
</html>
