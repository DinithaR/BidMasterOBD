package com.BidMaster.category;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteCategoryServlet")
public class DeleteCategoryServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sql@2025";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");

        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect("categoryList.jsp?error=Missing+Category+ID");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Class.forName("com.mysql.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pst = conn.prepareStatement("DELETE FROM category WHERE id = ?")) {

                pst.setInt(1, id);
                int rows = pst.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("categoryList.jsp?deleted=true");
                } else {
                    response.sendRedirect("categoryList.jsp?error=Category+not+found");
                }

            }

        } catch (NumberFormatException e) {
            response.sendRedirect("categoryList.jsp?error=Invalid+Category+ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("categoryList.jsp?error=Server+Error");
        }
    }
}