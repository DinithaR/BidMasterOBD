<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - BidMaster</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }
        .login-card {
            max-width: 400px;
            margin: 80px auto;
            padding: 30px;
            border-radius: 16px;
            background-color: white;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
        .btn-modern {
            font-weight: 600;
            padding: 10px 24px;
            border-radius: 10px;
            transition: all 0.2s ease-in-out;
        }
        .btn-modern:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .btn-dark-modern {
            background-color: #343a40;
            border: none;
            color: #fff;
        }
        .btn-dark-modern:hover {
            background-color: #23272b;
            color: #fff
        }
        .btn-primary-modern {
            background-color: #0d6efd;
            border: none;
            color: #fff;
        }
        .btn-primary-modern:hover {
            background-color: #0b5ed7;
        }
        .link-muted {
            color: #6c757d;
        }
        .link-muted:hover {
            color: #0d6efd;
        }
    </style>
</head>
<body>

<!-- Navbar with Admin Login in top-right -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <a class="btn btn-modern btn-dark-modern" href="adminLogin.jsp">Admin Login</a>
    </div>
</nav>

<!-- Login Card -->
<div class="login-card">
    <h3 class="text-center mb-4">Welcome Back</h3>
    <form action="login" method="post">
        <input type="text" class="form-control my-3" name="username" placeholder="Email" required>
        <input type="password" class="form-control my-3" name="password" placeholder="Password" required>
        <button class="btn btn-modern btn-primary-modern w-100 mt-2" type="submit">Login</button>
    </form>

    <p class="text-center mt-3">
        <span class="text-muted">Don’t have an account?</span>
        <a class="link-muted fw-bold" href="register.jsp">Create one</a>
    </p>
</div>

</body>
</html>