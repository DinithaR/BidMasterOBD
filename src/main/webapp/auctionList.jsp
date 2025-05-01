<%@ page import="java.sql.*" %>
<%
    // Admin session check
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("SELECT * FROM auctions ORDER BY end_time DESC");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - Manage Auctions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; }
        .btn-sm { padding: 6px 12px; font-size: 0.85rem; }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-dark bg-primary px-4">
    <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
    <div class="ms-auto d-flex align-items-center">
        <span class="text-white me-3">Admin: <%= adminUser %></span>
        <a href="adminLogout.jsp" class="btn btn-outline-light">Logout</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="fw-bold">Auction Management</h2>
        <a href="addAuction.jsp" class="btn btn-success">+ Create Auction</a>
    </div>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Start Price</th>
                <th>Ends</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("title") %></td>
                <td>$<%= rs.getBigDecimal("start_price") %></td>
                <td><%= rs.getTimestamp("end_time") %></td>
                <td><%= rs.getString("status") %></td>
                <td>
                    <a href="editAuction.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                    <a href="deleteAuction.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this auction?')">Delete</a>
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

</body>
</html>