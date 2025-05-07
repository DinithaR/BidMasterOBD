package com.BidMaster.category;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UpdateCategoryServlet")
public class UpdateCategoryServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "sql@2025";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");

        if (idStr == null || name == null || name.trim().isEmpty()) {
            response.sendRedirect("editCategory.jsp?id=" + idStr + "&error=Missing+name+or+ID");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);

            Class.forName("com.mysql.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                 PreparedStatement pst = conn.prepareStatement("UPDATE category SET name = ?, description = ? WHERE id = ?")) {

                pst.setString(1, name.trim());
                pst.setString(2, description != null ? description.trim() : null);
                pst.setInt(3, id);

                int rows = pst.executeUpdate();

                if (rows > 0) {
                    response.sendRedirect("categoryList.jsp?updated=true");
                } else {
                    response.sendRedirect("editCategory.jsp?id=" + id + "&error=Category+not+found");
                }
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("editCategory.jsp?error=Invalid+ID");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("editCategory.jsp?id=" + idStr + "&error=Server+Error");
        }
    }
}