<%@ page import="java.sql.*, java.util.*" %>
<%
    String id = request.getParameter("id");
    if (id == null) {
        response.sendRedirect("home.jsp");
        return;
    }

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

    PreparedStatement pst = conn.prepareStatement("SELECT * FROM auctions WHERE id = ?");
    pst.setString(1, id);
    ResultSet rs = pst.executeQuery();

    boolean found = rs.next();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BidMaster - Auction Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
    	body {
        	background-color: #f8f9fa;
    	}
    	.auction-card {
        	max-width: 800px;
        	margin: 60px auto;
        	background: white;
        	padding: 30px;
        	border-radius: 16px;
        	box-shadow: 0 10px 18px rgba(0, 0, 0, 0.08);
    	}
    	.auction-img {
        	width: 100%;
        	height: auto;
        	border-radius: 12px;
        	display: block;
        	margin: 0 auto 20px auto;
    	}
    	.auction-info {
        	margin-top: 25px;
    	}
	</style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container d-flex justify-content-between">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <a class="btn btn-light" href="home.jsp">Home</a>
    </div>
</nav>

<div class="auction-card">
    <% if (!found) { %>
        <h3 class="text-center text-danger">Auction not found.</h3>
    <% } else {
        String title = rs.getString("title");
        String image = rs.getString("image");
        String imagePath = (image != null && !image.trim().isEmpty())
            ? "uploads/" + image
            : "https://via.placeholder.com/700x300?text=" + title.replaceAll(" ", "+");
    %>
        <h2 class="mb-3 text-center"><%= title %></h2>
        <img src="<%= imagePath %>" class="auction-img mb-4" alt="Auction Image">

        <div class="auction-info">
            <p><strong>Description:</strong> <%= rs.getString("description") %></p>
            <p><strong>Starting Price:</strong> Rs.<%= rs.getBigDecimal("start_price") %></p>
            <p><strong>End Time:</strong> <%= rs.getTimestamp("end_time") %></p>
        </div>

        <div class="mt-4 text-center">
            <a href="placeBid.jsp?auctionId=<%= rs.getInt("id") %>" class="btn btn-success me-2">Place a Bid</a>
            <a href="home.jsp" class="btn btn-outline-secondary">Back to Home</a>
        </div>
    <% } %>
</div>

<%
    rs.close();
    pst.close();
    conn.close();
%>

</body>
</html>