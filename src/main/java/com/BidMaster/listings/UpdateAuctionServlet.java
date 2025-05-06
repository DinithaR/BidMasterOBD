package com.BidMaster.listings;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;
import java.sql.*;

@WebServlet("/UpdateAuctionServlet")
@MultipartConfig
public class UpdateAuctionServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String id = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String startPrice = request.getParameter("start_price");
        String endTime = request.getParameter("end_time");
        String existingImage = request.getParameter("existing_image");

        Part imagePart = request.getPart("image");
        String imageFileName = null;

        // Handle file upload if a new file is chosen
        if (imagePart != null && imagePart.getSize() > 0) {
            imageFileName = System.currentTimeMillis() + "_" + imagePart.getSubmittedFileName();
            String uploadPath = getServletContext().getRealPath("") + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            try (InputStream input = imagePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(uploadPath + File.separator + imageFileName)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = input.read(buffer)) != -1) {
                    output.write(buffer, 0, bytesRead);
                }
            }
        } else {
            imageFileName = existingImage; // keep current image
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "UPDATE auctions SET title = ?, description = ?, start_price = ?, end_time = ?, image = ? WHERE id = ?");

            pst.setString(1, title);
            pst.setString(2, description);
            pst.setBigDecimal(3, new BigDecimal(startPrice));
            pst.setTimestamp(4, Timestamp.valueOf(endTime.replace("T", " ") + ":00"));
            pst.setString(5, imageFileName);
            pst.setInt(6, Integer.parseInt(id));

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