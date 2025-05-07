package com.BidMaster.bidding;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteBid")
public class DeleteBidServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sql@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        Integer userId = (session != null) ? (Integer) session.getAttribute("userId") : null;


        String bidIdStr = request.getParameter("bid_id");

        if (bidIdStr == null) {
            response.sendRedirect("myBids.jsp?error=Missing bid ID");
            return;
        }

        try {
            int bidId = Integer.parseInt(bidIdStr);

            Class.forName("com.mysql.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS)) {
                PreparedStatement pst = conn.prepareStatement(
                    "DELETE FROM bid WHERE bid_id = ? AND user_id = ?");
                pst.setInt(1, bidId);
                pst.setInt(2, userId);
                int result = pst.executeUpdate();

                if (result > 0) {
                    response.sendRedirect("myBids.jsp?deleted=true");
                } else {
                    response.sendRedirect("myBids.jsp?error=You are not authorized to delete this bid.");
                }
            }
        } catch (NumberFormatException e) {
            response.sendRedirect("myBids.jsp?error=Invalid bid ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("myBids.jsp?error=Server error");
        }
    }
}