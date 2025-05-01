<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    String userName = (String) session.getAttribute("name");
    boolean isLoggedIn = (userName != null);
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
            String[] titles = { "iPhone 14", "Galaxy S23", "MacBook Air", "Apple Watch", "Sony Headphones",
                                "Gaming Laptop", "Canon Camera", "Bluetooth Speaker", "Smart TV", "PlayStation 5" };
            String[] prices = { "$500", "$450", "$900", "$250", "$120", "$1100", "$700", "$80", "$650", "$499" };
            String[] images = {
                "https://via.placeholder.com/300x150?text=iPhone+14",
                "https://via.placeholder.com/300x150?text=Galaxy+S23",
                "https://via.placeholder.com/300x150?text=MacBook+Air",
                "https://via.placeholder.com/300x150?text=Apple+Watch",
                "https://via.placeholder.com/300x150?text=Sony+Headphones",
                "https://via.placeholder.com/300x150?text=Gaming+Laptop",
                "https://via.placeholder.com/300x150?text=Canon+Camera",
                "https://via.placeholder.com/300x150?text=Bluetooth+Speaker",
                "https://via.placeholder.com/300x150?text=Smart+TV",
                "https://via.placeholder.com/300x150?text=PlayStation+5"
            };

            for (int i = 0; i < 10; i++) {
        %>
        <div class="col">
            <div class="card h-100">
                <img src="<%= images[i] %>" class="card-img-top" alt="<%= titles[i] %>">
                <div class="card-body d-flex flex-column">
                    <h5 class="product-title"><%= titles[i] %></h5>
                    <p class="product-price">Starting Price: <%= prices[i] %></p>
                    <a href="auction.jsp?id=<%= i + 1 %>" class="btn btn-primary mt-auto">View Auction</a>
                </div>
            </div>
        </div>
        <% } %>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white text-center py-4 mt-5">
    &copy; 2025 BidMaster • Built for smart bidders. Contact: support@bidmaster.com
</footer>

</body>
</html>