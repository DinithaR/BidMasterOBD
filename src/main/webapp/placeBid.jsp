<%@ page import="java.sql.*" %>
<%
    String auctionId = request.getParameter("auctionId");
    if (auctionId == null || auctionId.isEmpty()) {
        response.sendRedirect("home.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pst = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

        pst = conn.prepareStatement("SELECT * FROM auctions WHERE id = ?");
        pst.setString(1, auctionId);
        rs = pst.executeQuery();

        if (!rs.next()) {
            response.sendRedirect("home.jsp");
            return;
        }

        String auctionTitle = rs.getString("title");
        String bidderName = (String) session.getAttribute("name");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Place Bid - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="mb-4">Place Your Bid for: <span class="text-primary"><%= auctionTitle %></span></h2>

    <!-- Alert Messages -->
    <% if ("true".equals(request.getParameter("error"))) { %>
        <div class="alert alert-danger">❌ Failed to place bid. Please try again.</div>
    <% } else if ("true".equals(request.getParameter("success"))) { %>
        <div class="alert alert-success">
            ✅ Your bid was placed successfully!
            <br>
            <a href="myBids.jsp" class="btn btn-sm btn-success mt-2">Go to My Bids</a>
        </div>
    <% } %>

    <!-- Bid Form -->
    <form action="PlaceBidServlet" method="post" class="mt-4">
        <input type="hidden" name="auction_id" value="<%= auctionId %>">

        <div class="mb-3">
            <label for="bidAmount" class="form-label">Bid Amount (LKR)</label>
            <input type="number" step="0.01" name="bid_amount" id="bidAmount" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Your Name</label>
            <input type="text" class="form-control" value="<%= bidderName %>" readonly>
        </div>

        <div class="d-flex gap-2">
            <button type="submit" class="btn btn-primary">Submit Bid</button>
            <a href="auction.jsp?id=<%= auctionId %>" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>
</body>
</html>

<%
    } catch (Exception e) {
        out.println("<div class='container mt-5'><div class='alert alert-danger'>An error occurred: " + e.getMessage() + "</div></div>");
    } finally {
        if (rs != null) try { rs.close(); } catch (Exception ignored) {}
        if (pst != null) try { pst.close(); } catch (Exception ignored) {}
        if (conn != null) try { conn.close(); } catch (Exception ignored) {}
    }
%>