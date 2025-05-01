package com.BidMaster.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@SuppressWarnings("serial")
@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	if (session.getAttribute("admin") == null) {
    	    response.sendRedirect("adminLogin.jsp");
    	    return;
    	}

        int id = Integer.parseInt(request.getParameter("id"));

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement("DELETE FROM user WHERE id = ?");
            pst.setInt(1, id);
            pst.executeUpdate();

            response.sendRedirect("adminUsers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting user: " + e.getMessage());
        }
    }
}