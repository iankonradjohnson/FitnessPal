<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
    <link rel="stylesheet" type="text/css" href="stylesheet.css">
</head>
<body class="login_body">
    <main>
        <div class="login_container">
            <h1>Fitness App</h1>
            <div class="login_form">
                <h1  class="login_heading"><br>Login to Your <br>Account</h1>
                <form id="login_form" name="login_form" action="LoginServlet" method="get">
                    <!-- <label class="label_class">Username</label> -->
                    <input type="text" id="username" name="username" placeholder="Username"><br>

                    <!-- <label class="label_class">Password</label> -->
                    <input type="password" id="password" name="password" placeholder="Pasword"><br>

                    <!-- <label class="label_class">&nbsp;</label> -->
                    <button type="submit" id="register">Login</button>

                    <p class="login_text">Don't have an account? <a href="register.jsp">Sign up</a></p>
                	<p class="login_text">Not where you want to be? <a href="index.jsp">Go Home</a></p>
                </form>
            </div>
        </div>
    </main>
</body>
</html>
