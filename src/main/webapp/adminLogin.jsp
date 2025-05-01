<%@ page contentType="text/html; charset=UTF-8" %>
<html>
<head>
    <title>Admin Login</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div class="col-md-4 offset-md-4">
        <h3 class="text-center">Admin Login</h3>
        <form action="adminLogin" method="post">
            <input type="text" class="form-control my-2" name="username" placeholder="Username" required>
            <input type="password" class="form-control my-2" name="password" placeholder="Password" required>
            <button class="btn btn-primary w-100" type="submit">Login</button>
        </form>
        <%
            if ("fail".equals(request.getAttribute("status"))) {
        %>
            <p class="text-danger mt-2 text-center">Invalid credentials!</p>
        <%
            }
        %>
    </div>
</div>
</body>
</html>