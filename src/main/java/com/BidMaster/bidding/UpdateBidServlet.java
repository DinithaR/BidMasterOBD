package com.BidMaster.bidding;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/UpdateBidServlet")
public class UpdateBidServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sql@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bidIdStr = request.getParameter("bid_id");
        String newAmountStr = request.getParameter("new_bid_amount");

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (bidIdStr == null || newAmountStr == null || userId == null || role == null) {
            forwardWithError(request, response, "Invalid input or session expired.");
            return;
        }

        if (!"bidder".equalsIgnoreCase(role)) {
            forwardWithError(request, response, "Only users with bidder role can update bids.");
            return;
        }

        try {
            int bidId = Integer.parseInt(bidIdStr);
            double newAmount = Double.parseDouble(newAmountStr);

            Class.forName("com.mysql.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Retrieve the original bid
                try (PreparedStatement bidStmt = conn.prepareStatement(
                        "SELECT b.auction_id, b.user_id, a.status, a.end_time, a.start_price " +
                                "FROM bid b JOIN auctions a ON b.auction_id = a.id WHERE b.bid_id = ?"
                )) {
                    bidStmt.setInt(1, bidId);
                    try (ResultSet rs = bidStmt.executeQuery()) {

                        if (!rs.next()) {
                            forwardWithError(request, response, "Bid not found.");
                            return;
                        }

                        int auctionId = rs.getInt("auction_id");
                        int bidOwnerId = rs.getInt("user_id");
                        String status = rs.getString("status");
                        Timestamp endTime = rs.getTimestamp("end_time");
                        double startPrice = rs.getDouble("start_price");

                        if (bidOwnerId != userId) {
                            forwardWithError(request, response, "You can only update your own bids.");
                            return;
                        }

                        if (!"active".equalsIgnoreCase(status)) {
                            forwardWithError(request, response, "The auction is no longer active.");
                            return;
                        }

                        if (endTime.before(new Timestamp(System.currentTimeMillis()))) {
                            forwardWithError(request, response, "The auction has already ended.");
                            return;
                        }

                        // Get current highest bid (excluding this bid)
                        double currentMaxBid = startPrice;
                        try (PreparedStatement maxBidStmt = conn.prepareStatement(
                                "SELECT MAX(bid_amount) AS max_bid FROM bid WHERE auction_id = ? AND bid_id != ?"
                        )) {
                            maxBidStmt.setInt(1, auctionId);
                            maxBidStmt.setInt(2, bidId);
                            try (ResultSet bidRs = maxBidStmt.executeQuery()) {
                                if (bidRs.next() && bidRs.getDouble("max_bid") > 0) {
                                    currentMaxBid = bidRs.getDouble("max_bid");
                                }
                            }
                        }

                        if (newAmount <= currentMaxBid) {
                            forwardWithError(request, response, "Your new bid must be higher than the current bid (" + currentMaxBid + ").");
                            return;
                        }

                        // Perform the update
                        try (PreparedStatement updateStmt = conn.prepareStatement(
                                "UPDATE bid SET bid_amount = ?, bid_time = NOW() WHERE bid_id = ?"
                        )) {
                            updateStmt.setDouble(1, newAmount);
                            updateStmt.setInt(2, bidId);

                            int rowsUpdated = updateStmt.executeUpdate();

                            if (rowsUpdated > 0) {
                                response.sendRedirect("myBids.jsp?success=updated");
                            } else {
                                forwardWithError(request, response, "Failed to update bid.");
                            }
                        }
                    }
                }
            }

        } catch (NumberFormatException e) {
            forwardWithError(request, response, "Invalid number format for bid ID or bid amount.");
        } catch (Exception e) {
            e.printStackTrace();
            forwardWithError(request, response, "Error: " + e.getMessage());
        }
    }

    private void forwardWithError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", message);
        request.getRequestDispatcher("updateBid.jsp").forward(request, response);
    }
}