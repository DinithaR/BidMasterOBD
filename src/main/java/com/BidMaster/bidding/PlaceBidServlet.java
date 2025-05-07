package com.BidMaster.bidding;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/PlaceBidServlet")
public class PlaceBidServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sql@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String auctionIdStr = request.getParameter("auction_id");
        String bidAmountStr = request.getParameter("bid_amount");

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if (auctionIdStr == null || bidAmountStr == null || userId == null || role == null) {
            redirectWithError(response, "placeBid.jsp?auctionId=" + auctionIdStr, "Invalid input or session expired.");
            return;
        }

        if (!"bidder".equalsIgnoreCase(role)) {
            redirectWithError(response, "placeBid.jsp?auctionId=" + auctionIdStr, "Only bidders can place bids.");
            return;
        }

        try {
            int auctionId = Integer.parseInt(auctionIdStr);
            double bidAmount = Double.parseDouble(bidAmountStr);

            Class.forName("com.mysql.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {

                // Check auction validity
                PreparedStatement auctionStmt = conn.prepareStatement(
                    "SELECT status, end_time, start_price FROM auctions WHERE id = ?"
                );
                auctionStmt.setInt(1, auctionId);
                ResultSet auctionRs = auctionStmt.executeQuery();

                if (!auctionRs.next()) {
                    redirectWithError(response, "placeBid.jsp?auctionId=" + auctionId, "Auction not found.");
                    return;
                }

                String status = auctionRs.getString("status");
                Timestamp endTime = auctionRs.getTimestamp("end_time");
                double startPrice = auctionRs.getDouble("start_price");

                if (!"active".equalsIgnoreCase(status)) {
                    redirectWithError(response, "placeBid.jsp?auctionId=" + auctionId, "This auction is not active.");
                    return;
                }

                if (endTime.before(new Timestamp(System.currentTimeMillis()))) {
                    redirectWithError(response, "placeBid.jsp?auctionId=" + auctionId, "This auction has expired.");
                    return;
                }

                // Get highest bid
                double currentMaxBid = startPrice;
                PreparedStatement maxBidStmt = conn.prepareStatement(
                    "SELECT MAX(bid_amount) AS max_bid FROM bid WHERE auction_id = ?"
                );
                maxBidStmt.setInt(1, auctionId);
                ResultSet bidRs = maxBidStmt.executeQuery();

                if (bidRs.next() && bidRs.getDouble("max_bid") > 0) {
                    currentMaxBid = bidRs.getDouble("max_bid");
                }

                if (bidAmount <= currentMaxBid) {
                    redirectWithError(response, "placeBid.jsp?auctionId=" + auctionId,
                            "Your bid must be higher than the current bid (LKR " + currentMaxBid + ").");
                    return;
                }

                // Place bid
                PreparedStatement bidStmt = conn.prepareStatement(
                    "INSERT INTO bid (auction_id, user_id, bid_amount, bid_time) VALUES (?, ?, ?, NOW())"
                );
                bidStmt.setInt(1, auctionId);
                bidStmt.setInt(2, userId);
                bidStmt.setDouble(3, bidAmount);

                int result = bidStmt.executeUpdate();

                if (result > 0) {
                    // Redirect to myBids.jsp on success
                    response.sendRedirect("myBids.jsp?success=true");
                } else {
                    redirectWithError(response, "placeBid.jsp?auctionId=" + auctionId, "Failed to place your bid.");
                }

            }
        } catch (NumberFormatException e) {
            redirectWithError(response, "placeBid.jsp?auctionId=" + auctionIdStr, "Invalid number format.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectWithError(response, "placeBid.jsp?auctionId=" + auctionIdStr, "Error: " + e.getMessage());
        }
    }

    private void redirectWithError(HttpServletResponse response, String targetPage, String message)
            throws IOException {
        response.sendRedirect(targetPage + "&error=" + java.net.URLEncoder.encode(message, "UTF-8"));
    }
}