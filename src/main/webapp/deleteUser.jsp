<%
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

    PreparedStatement pst = conn.prepareStatement("SELECT * FROM user WHERE id=?");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Delete User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Confirm Deletion</h2>
    <p>Are you sure you want to delete <strong><%= rs.getString("name") %></strong>?</p>
    <form action="DeleteUserServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <button class="btn btn-danger" type="submit">Delete</button>
        <a href="adminUsers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
<%
    rs.close();
    pst.close();
    conn.close();
%>
</div>
</body>
</html>