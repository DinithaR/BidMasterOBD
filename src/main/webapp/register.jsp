<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>

<div class="container mt-5">
    <div class="col-md-4 offset-md-4">
        <h2 class="text-center">Create Account</h2>

        <form action="register" method="post">
            <input type="text" class="form-control my-2" name="name" placeholder="Full Name" required>
            <input type="email" class="form-control my-2" name="email" placeholder="Email" required>
            <input type="text" class="form-control my-2" name="contact" placeholder="Contact Number" required>
            <input type="password" class="form-control my-2" name="password" placeholder="Password" required>
            <button class="btn btn-success w-100" type="submit">Register</button>
        </form>

        <p class="text-center text-danger mt-2">
            <% if ("fail".equals(request.getAttribute("status"))) { %>
                Registration failed. Try a different email.
            <% } else if ("success".equals(request.getAttribute("status"))) { %>
                <span class="text-success">Registered successfully. You may <a href="login.jsp">login</a>.</span>
            <% } %>
        </p>

        <p class="text-center mt-2"><a href="login.jsp">Already have an account?</a></p>
    </div>
</div>

</body>
</html>