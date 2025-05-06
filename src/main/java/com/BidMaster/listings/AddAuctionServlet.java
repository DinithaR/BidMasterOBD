package com.BidMaster.listings;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.sql.*;

@WebServlet("/AddAuctionServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
                 maxFileSize = 1024 * 1024 * 10,        // 10MB
                 maxRequestSize = 1024 * 1024 * 50)     // 50MB
public class AddAuctionServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startPrice = request.getParameter("start_price");
        String endTime = request.getParameter("end_time");

        // Get image file
        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

        // Create /uploads folder inside webapp if not exists
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        // Save the image to /uploads
        filePart.write(uploadPath + File.separator + fileName);

        try {
            Class.forName("com.mysql.jdbc.Driver"); // updated driver class
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "INSERT INTO auctions (seller_id, title, description, start_price, end_time, image) VALUES (?, ?, ?, ?, ?, ?)");

            pst.setInt(1, 1); // Default seller_id; replace with session-based seller later
            pst.setString(2, title);
            pst.setString(3, description);
            pst.setBigDecimal(4, new BigDecimal(startPrice));
            pst.setTimestamp(5, Timestamp.valueOf(endTime.replace("T", " ") + ":00"));
            pst.setString(6, fileName); // Save filename in DB

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