<%@ page import="java.sql.*, java.util.*" %>
<%
    String bidderId = (String) session.getAttribute("user_id");
    String bidderName = (String) session.getAttribute("name");
    boolean isLoggedIn = (bidderId != null);
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bids - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .cart-card {
            border-radius: 12px;
            background: white;
            box-shadow: 0 8px 16px rgba(0,0,0,0.08);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <% if (isLoggedIn) { %>
            <span class="text-white ms-auto">Welcome, <%= bidderName %></span>
        <% } else { %>
            <span class="text-white ms-auto">Guest</span>
        <% } %>
    </div>
</nav>

<div class="container mt-5">
    <h3 class="text-center mb-4 fw-bold">My Active Bids</h3>

    <div class="table-responsive cart-card p-4">
        <% if (isLoggedIn) { 
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "SELECT b.id, b.bid_amount, b.bid_time, a.title, a.end_time FROM bid b JOIN auctions a ON b.auction_id = a.id WHERE b.bidder_id = ?");
            pst.setString(1, bidderId);
            ResultSet rs = pst.executeQuery();

            boolean hasBids = false;
        %>
        <table class="table table-hover align-middle mb-0">
            <thead class="table-dark">
                <tr>
                    <th>Auction Item</th>
                    <th>Bid Amount</th>
                    <th>Bid Time</th>
                    <th>Ends At</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                while (rs.next()) {
                    hasBids = true;
            %>
                <tr>
                    <td><%= rs.getString("title") %></td>
                    <td>$<%= rs.getBigDecimal("bid_amount") %></td>
                    <td><%= rs.getTimestamp("bid_time") %></td>
                    <td><%= rs.getTimestamp("end_time") %></td>
                    <td>
                        <a href="editBid.jsp?id=<%= rs.getInt("id") %>" class="btn btn-warning btn-sm">Edit</a>
                        <a href="deleteBid.jsp?id=<%= rs.getInt("id") %>" class="btn btn-danger btn-sm" onclick="return confirm('Cancel this bid?')">Delete</a>
                    </td>
                </tr>
            <%
                }
                if (!hasBids) {
            %>
                <tr>
                    <td colspan="5" class="text-center text-muted py-4">You have no active bids yet.</td>
                </tr>
            <%
                }
                rs.close();
                pst.close();
                conn.close();
            %>
            </tbody>
        </table>
        <% } %>
    </div>
</div>

</body>
</html>