<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<html>
<head>
    <title>Category List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
    </div>
</nav>

<div class="container mt-4">
    <h2>Categories</h2>
    <a href="addCategory.jsp" class="btn btn-success mb-3">Add New Category</a>
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Name</th><th>Description</th><th>Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");
                stmt = conn.createStatement();
                rs = stmt.executeQuery("SELECT * FROM category");

                while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("description") %></td>
                <td>
                    <a href="editCategory.jsp?id=<%= rs.getInt("id") %>" class="btn btn-primary btn-sm">Edit</a>
                    <a href="DeleteCategoryServlet?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm"
                       onclick="return confirm('Are you sure?');">Delete</a>
                </td>
            </tr>
        <%
                }
            } catch (Exception e) {
                out.print("Error: " + e.getMessage());
            } finally {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            }
        %>
        </tbody>
    </table>
    <a href="adminUsers.jsp" class="btn btn-outline-secondary">Back to Admin Dashboard</a>
</div>
</body>
</html>