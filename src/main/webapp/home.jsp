<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*" %>
<%
    String userName = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    boolean isLoggedIn = (userName != null);

    Class.forName("com.mysql.jdbc.Driver");
    Connection conn = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");
    Statement stmt = conn.createStatement();
    String query = "SELECT a.id, a.title, a.start_price, a.image, MAX(b.bid_amount) AS highest_bid " +
                   "FROM auctions a " +
                   "LEFT JOIN bid b ON a.id = b.auction_id " +
                   "WHERE a.status = 'active' " +
                   "GROUP BY a.id " +
                   "ORDER BY a.end_time ASC";
    ResultSet rs = stmt.executeQuery(query);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>BidMaster - Home</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            transition: transform 0.2s ease, box-shadow 0.2s ease;
            height: 100%;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }
        .card-img-top {
            height: 150px;
            object-fit: cover;
        }
        .product-title {
            font-size: 1rem;
            font-weight: 600;
        }
        .product-price {
            font-size: 0.95rem;
            color: #555;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <div class="d-flex align-items-center">
            <% if (isLoggedIn) { %>
                <span class="text-white me-3">Welcome, <%= userName %></span>
                <a class="btn btn-outline-light me-2" href="myBids.jsp">My Bids</a>
                <% if ("admin".equals(role) || "seller".equals(role)) { %>
                    <a class="btn btn-warning me-2" href="auctionList.jsp">Listings Dashboard</a>
                <% } %>
                <a class="btn btn-light me-2" href="profile.jsp">Profile</a>
                <a class="btn btn-danger" href="Logout">Logout</a>
            <% } else { %>
                <a class="btn btn-light me-2" href="login.jsp">Login</a>
                <a class="btn btn-warning" href="register.jsp">Register</a>
            <% } %>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="text-center py-5 bg-white">
    <div class="container">
        <h1 class="display-5 fw-semibold">Welcome to BidMaster</h1>
        <p class="lead text-muted">Bid on top products and grab exclusive deals every day!</p>
    </div>
</section>

<!-- Auction Listings -->
<div class="container mt-4">
    <h2 class="mb-4 text-center">🔥 Live Auctions</h2>
    <div class="row row-cols-1 row-cols-md-5 g-4">
        <%
            while (rs.next()) {
                int auctionId = rs.getInt("id");
                String title = rs.getString("title");
                String price = rs.getBigDecimal("start_price").toString();
                String image = rs.getString("image");
                String imagePath = (image != null && !image.isEmpty()) 
                                   ? "uploads/" + image 
                                   : "https://via.placeholder.com/300x150?text=" + title.replaceAll(" ", "+");
                String highestBid = rs.getString("highest_bid");
        %>
        <div class="col">
            <div class="card h-100">
                <img src="<%= imagePath %>" class="card-img-top" alt="<%= title %>">
                <div class="card-body d-flex flex-column">
                    <h5 class="product-title"><%= title %></h5>
                    <p class="product-price">Starting Price: Rs.<%= price %></p>
                    <% if (highestBid != null) { %>
                        <p class="text-success">Highest Bid: Rs.<%= highestBid %></p>
                    <% } else { %>
                        <p class="text-muted">No bids yet</p>
                    <% } %>
                    <a href="auction.jsp?id=<%= auctionId %>" class="btn btn-primary mt-auto">View Auction</a>
                </div>
            </div>
        </div>
        <% } 
           rs.close();
           stmt.close();
           conn.close();
        %>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    &copy; 2025 BidMaster • Built for smart bidders. Contact: support@bidmaster.com
</footer>

</body>
</html>