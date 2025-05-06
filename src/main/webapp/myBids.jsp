<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    Integer userIdInt = (Integer) session.getAttribute("userId");
    if (userIdInt == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = userIdInt;

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bids - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="mb-4">My Bids</h2>

    <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            String sql = "SELECT b.bid_id, a.title, b.bid_amount, b.bid_time FROM bid b " +
                         "JOIN auctions a ON b.auction_id = a.id " +
                         "JOIN user u ON u.id = b.user_id " +
                         "WHERE b.user_id = ? ORDER BY b.bid_time DESC";
            pst = conn.prepareStatement(sql);
            pst.setInt(1, userId);
            rs = pst.executeQuery();

            boolean hasBids = false;
    %>

    <table class="table table-bordered table-hover">
        <thead class="table-dark">
            <tr>
                <th>#</th>
                <th>Auction Title</th>
                <th>Bid Amount (LKR)</th>
                <th>Bid Time</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <%
                int count = 1;
                while (rs.next()) {
                    hasBids = true;
                    int bidId = rs.getInt("bid_id");
                    double bidAmount = rs.getDouble("bid_amount");
            %>
                <tr>
                    <td><%= count++ %></td>
                    <td><%= rs.getString("title") %></td>
                    <td><%= bidAmount %></td>
                    <td><%= rs.getTimestamp("bid_time") %></td>
                    <td>
    					<a href="updateBid.jsp?bid_id=<%= bidId %>&current_bid_amount=<%= bidAmount %>" class="btn btn-sm btn-primary">Edit</a>
    
    					<form action="DeleteBid" method="post" style="display:inline;" onsubmit="return confirm('Are you sure you want to delete this bid?');">
        					<input type="hidden" name="bid_id" value="<%= bidId %>">
        					<button type="submit" class="btn btn-sm btn-danger">Delete</button>
    					</form>
					</td>
                </tr>
            <%
                }
            %>
        </tbody>
    </table>

    <%
        if (!hasBids) {
    %>
        <div class="alert alert-info">You haven't placed any bids yet.</div>
    <%
        }
        } catch (Exception e) {
            out.println("<div class='alert alert-danger'>Error: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (pst != null) try { pst.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    %>

    <a href="home.jsp" class="btn btn-secondary mt-3">Back to Home</a>
</div>
</body>
</html>