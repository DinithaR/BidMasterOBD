<%@ page import="java.sql.*, java.util.*" %>
<%@ page session="true" %>
<%
    int userId = (session.getAttribute("userId") != null) ? (Integer) session.getAttribute("userId") : -1;
    if (userId == -1) {
        response.sendRedirect("login.jsp");
        return;
    }

    String msg = "";
    int bidId = -1;
    String auctionTitle = "";
    double currentAmount = 0;

    try {
        bidId = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect("myBids.jsp");
        return;
    }

    // Handle form submission
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        try {
            double newAmount = Double.parseDouble(request.getParameter("bidAmount"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            String updateQuery = "UPDATE bids SET amount = ? WHERE id = ? AND bidder_id = ?";
            PreparedStatement updateStmt = conn.prepareStatement(updateQuery);
            updateStmt.setDouble(1, newAmount);
            updateStmt.setInt(2, bidId);
            updateStmt.setInt(3, userId);

            int updated = updateStmt.executeUpdate();
            updateStmt.close();
            conn.close();

            if (updated > 0) {
                response.sendRedirect("myBids.jsp");
                return;
            } else {
                msg = "Failed to update. You may not own this bid.";
            }
        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        }
    }

    // Load current bid data
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

        String selectQuery = "SELECT b.amount, a.title FROM bids b INNER JOIN auctions a ON b.auction_id = a.id WHERE b.id = ? AND b.bidder_id = ?";
        PreparedStatement pst = conn.prepareStatement(selectQuery);
        pst.setInt(1, bidId);
        pst.setInt(2, userId);
        ResultSet rs = pst.executeQuery();

        if (rs.next()) {
            currentAmount = rs.getDouble("amount");
            auctionTitle = rs.getString("title");
        } else {
            rs.close();
            pst.close();
            conn.close();
            response.sendRedirect("myBids.jsp");
            return;
        }

        rs.close();
        pst.close();
        conn.close();
    } catch (Exception e) {
        msg = "Error: " + e.getMessage();
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Bid</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">
    <h2>Edit Bid for: <%= auctionTitle %></h2>

    <% if (!msg.isEmpty()) { %>
        <div class="alert alert-danger"><%= msg %></div>
    <% } %>

    <form method="post">
        <div class="mb-3">
            <label for="bidAmount" class="form-label">New Bid Amount (LKR)</label>
            <input type="number" step="0.01" name="bidAmount" id="bidAmount" class="form-control" value="<%= currentAmount %>" required>
        </div>
        <button type="submit" class="btn btn-primary">Update Bid</button>
        <a href="myBids.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</body>
</html>