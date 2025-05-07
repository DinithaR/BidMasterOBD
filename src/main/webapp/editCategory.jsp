<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%

    int id = Integer.parseInt(request.getParameter("id"));
    String name = "";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

        PreparedStatement pst = conn.prepareStatement("SELECT * FROM category WHERE id = ?");
        pst.setInt(1, id);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
        }

        rs.close();
        pst.close();
        conn.close();
    } catch (Exception e) {
        out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Category - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Edit Category</h2>
    <form action="UpdateCategoryServlet" method="post">
        <input type="hidden" name="id" value="<%= id %>">
        <div class="mb-3">
            <label for="name" class="form-label">Category Name</label>
            <input type="text" name="name" id="name" class="form-control" value="<%= name %>" required>
            <label for="description" class="form-label">Description</label>
            <input type="text" name="description" id="description" class="form-control">
        </div>
        <button type="submit" class="btn btn-primary">Update</button>
        <a href="categoryList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>