package com.BidMaster.listings;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateAuctionServlet")
public class UpdateAuctionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startPrice = request.getParameter("start_price");
        String endTime = request.getParameter("end_time");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "UPDATE auctions SET title=?, description=?, start_price=?, end_time=? WHERE id=?");
            pst.setString(1, title);
            pst.setString(2, description);
            pst.setBigDecimal(3, new java.math.BigDecimal(startPrice));
            pst.setString(4, endTime);
            pst.setInt(5, id);

            pst.executeUpdate();
            pst.close();
            conn.close();

            response.sendRedirect("auctionList.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editAuction.jsp?id=" + id + "&error=true");
        }
    }
}