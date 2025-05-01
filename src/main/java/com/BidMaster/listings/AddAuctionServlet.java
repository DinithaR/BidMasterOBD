package com.BidMaster.listings;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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
            pst.setInt(1, 1); // Use 1 or set seller_id dynamically if needed
            pst.setString(2, title);
            pst.setString(3, description);
            pst.setBigDecimal(4, new java.math.BigDecimal(startPrice));
            pst.setString(5, endTime);

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