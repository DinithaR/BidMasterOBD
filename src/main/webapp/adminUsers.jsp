<%@ page import="java.sql.*, java.util.*" %>
<%
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<%
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Manage Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .dashboard-card {
            background: white;
            border-radius: 16px;
            padding: 30px;
            box-shadow: 0 6px 16px rgba(0, 0, 0, 0.1);
        }
        .table th {
            background-color: #0d6efd !important;
            color: white;
        }
    </style>
</head>
<body>

<!-- Admin Header -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <span class="navbar-brand fw-bold">BidMaster Admin Panel</span>
        <div class="d-flex">
            <span class="text-white me-3">Logged in as: <strong><%= adminUser %></strong></span>
            <a class="btn btn-light me-2" href="home.jsp">Home</a>
            <a href="adminLogout.jsp" class="btn btn-outline-light">Logout</a>
        </div>
    </div>
</nav>

<!-- Main Dashboard -->
<div class="container mt-5">
    <div class="dashboard-card">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold text-primary">User Management</h3>
            <a href="addUser.jsp" class="btn btn-success">+ Add New User</a>
        </div>

        <table class="table table-hover table-bordered align-middle">
            <thead>
                <tr class="text-center">
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Contact</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
            %>
                <tr>
                    <td class="text-center"><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("contact_no") %></td>
                    <td class="text-center">
                        <a href="editUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="deleteUser.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm">Delete</a>
                    </td>
                </tr>
            <%
                }
                rs.close();
                stmt.close();
                conn.close();
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>