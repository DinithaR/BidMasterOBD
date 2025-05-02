package com.BidMaster.listings;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.*;

@WebServlet("/AddAuctionServlet")
public class AddAuctionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startPrice = request.getParameter("start_price");
        String endTime = request.getParameter("end_time");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "INSERT INTO auctions (seller_id, title, description, start_price, end_time) VALUES (?, ?, ?, ?, ?)");

            pst.setInt(1, 1); // Default seller ID (admin), you can use session in future
            pst.setString(2, title);
            pst.setString(3, description);
            pst.setBigDecimal(4, new BigDecimal(startPrice));
            pst.setTimestamp(5, Timestamp.valueOf(endTime.replace("T", " ") + ":00"));

            pst.executeUpdate();

            pst.close();
            conn.close();

            response.sendRedirect("auctionList.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("addAuction.jsp?error=true");
        }
    }
}