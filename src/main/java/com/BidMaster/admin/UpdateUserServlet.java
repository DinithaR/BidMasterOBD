package com.BidMaster.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@SuppressWarnings("serial")
@WebServlet("/UpdateUserServlet")
public class UpdateUserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	if (session.getAttribute("admin") == null) {
    	    response.sendRedirect("adminLogin.jsp");
    	    return;
    	}

        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contact = request.getParameter("contact");

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "UPDATE user SET name=?, email=?, password=?, contact_no=? WHERE id=?");
            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);
            pst.setString(4, contact);
            pst.setInt(5, id);
            pst.executeUpdate();

            response.sendRedirect("adminUsers.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error updating user: " + e.getMessage());
        }
    }
}