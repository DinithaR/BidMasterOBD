<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String contact = (String) session.getAttribute("contact_no");

    if (name == null || email == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile - BidMaster</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .profile-card {
            max-width: 500px;
            margin: auto;
            margin-top: 60px;
            padding: 30px;
            border-radius: 20px;
            background-color: white;
            box-shadow: 0 8px 18px rgba(0, 0, 0, 0.1);
        }
        .profile-img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid #0d6efd;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <div class="d-flex">
            <a class="btn btn-light me-2" href="home.jsp">Home</a>
            <a class="btn btn-danger" href="logout.jsp">Logout</a>
        </div>
    </div>
</nav>

<!-- Profile Section -->
<div class="container">
    <div class="profile-card text-center">
        <img src="./images/profile_img.png" alt="Profile" class="profile-img">
        <h3 class="mb-3"><%= name %></h3>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Contact:</strong> <%= contact != null ? contact : "N/A" %></p>
        <hr>
        <a href="home.jsp" class="btn btn-primary mt-3">Back to Auctions</a>
    </div>
</div>

</body>
</html>