<%@ page import="java.sql.*" %>
<%

    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("auctionList.jsp");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

    PreparedStatement pst = conn.prepareStatement("SELECT * FROM auctions WHERE id = ?");
    pst.setString(1, id);
    ResultSet rs = pst.executeQuery();

    if (!rs.next()) {
        response.sendRedirect("auctionList.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Auction</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Edit Auction</h3>
    <form action="UpdateAuctionServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" class="form-control" value="<%= rs.getString("title") %>" required>
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required><%= rs.getString("description") %></textarea>
        </div>
        <div class="mb-3">
            <label>Start Price</label>
            <input type="number" name="start_price" step="0.01" class="form-control" value="<%= rs.getBigDecimal("start_price") %>" required>
        </div>
        <div class="mb-3">
            <label>End Time</label>
            <input type="datetime-local" name="end_time" class="form-control" value="<%= rs.getTimestamp("end_time").toLocalDateTime().toString().replace("T", "T") %>" required>
        </div>
        <button class="btn btn-primary" type="submit">Update Auction</button>
        <a href="auctionList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
<%
    rs.close();
    pst.close();
    conn.close();
%>