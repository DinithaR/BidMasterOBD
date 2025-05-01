package com.BidMaster.admin;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@SuppressWarnings("serial")
@WebServlet("/adminLogin")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        RequestDispatcher dispatcher = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement(
                "SELECT * FROM admin WHERE username=? AND password=?");

            pst.setString(1, username);
            pst.setString(2, password);

            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("admin", username);  // Mark admin logged in
                response.sendRedirect("adminUsers.jsp");
            } else {
                request.setAttribute("status", "fail");
                dispatcher = request.getRequestDispatcher("adminLogin.jsp");
                dispatcher.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login error: " + e.getMessage());
        }
    }
}