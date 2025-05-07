package com.BidMaster.listings;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/DeleteAuctionServlet")
public class DeleteAuctionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String auctionId = request.getParameter("id");

        if (auctionId == null || auctionId.isEmpty()) {
            response.sendRedirect("auctionList.jsp?error=invalid_id");
            return;
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement("DELETE FROM auctions WHERE id = ?");
            pst.setInt(1, Integer.parseInt(auctionId));
            int rows = pst.executeUpdate();

            conn.close();
            if (rows > 0) {
                response.sendRedirect("auctionList.jsp?delete=success");
            } else {
                response.sendRedirect("auctionList.jsp?delete=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("auctionList.jsp?delete=error");
        }
    }
}