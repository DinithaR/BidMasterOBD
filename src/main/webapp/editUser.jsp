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
    <title>Edit User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Edit User</h2>
    <form action="UpdateUserServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <input class="form-control my-2" name="name" value="<%= rs.getString("name") %>" required>
        <input class="form-control my-2" name="email" value="<%= rs.getString("email") %>" required>
        <input class="form-control my-2" name="password" value="<%= rs.getString("password") %>" required>
        <input class="form-control my-2" name="contact" value="<%= rs.getString("contact_no") %>" required>
        <button class="btn btn-primary" type="submit">Update</button>
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