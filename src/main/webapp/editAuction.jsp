<%@ page import="java.sql.*" %>
<%
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int auctionId = Integer.parseInt(request.getParameter("id"));
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");
    PreparedStatement pst = conn.prepareStatement("SELECT * FROM auctions WHERE id = ?");
    pst.setInt(1, auctionId);
    ResultSet rs = pst.executeQuery();
    rs.next();
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Auction - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Edit Auction</h3>
    <form action="UpdateAuctionServlet" method="post">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" value="<%= rs.getString("title") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required><%= rs.getString("description") %></textarea>
        </div>
        <div class="mb-3">
            <label>Start Price</label>
            <input type="number" name="start_price" step="0.01" value="<%= rs.getBigDecimal("start_price") %>" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>End Time</label>
            <input type="datetime-local" name="end_time" value="<%= rs.getTimestamp("end_time").toLocalDateTime().toString() %>" class="form-control" required>
        </div>
        <button class="btn btn-warning" type="submit">Update Auction</button>
        <a href="auctionList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
<%
    rs.close();
    pst.close();
    conn.close();
%>
</div>
</body>
</html>