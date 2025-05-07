package com.BidMaster.login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("username");
        String password = request.getParameter("password");

        HttpSession session = request.getSession();
        RequestDispatcher dispatcher = null;

        Connection conn = null;
        PreparedStatement pst = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
            pst = conn.prepareStatement(sql);
            pst.setString(1, email);
            pst.setString(2, password);

            rs = pst.executeQuery();

            if (rs.next()) {
                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("name", rs.getString("name"));
                session.setAttribute("email", rs.getString("email"));
                session.setAttribute("contact_no", rs.getString("contact_no"));
                session.setAttribute("role", rs.getString("role"));

                String role = rs.getString("role");
                if ("admin".equals(role)) {
                    dispatcher = request.getRequestDispatcher("adminUsers.jsp");
                } else if ("bidder".equals(role)) {
                    dispatcher = request.getRequestDispatcher("home.jsp");
                } else if ("seller".equals(role)) {
                	dispatcher = request.getRequestDispatcher("home.jsp");
                } else {
                    request.setAttribute("status", "unauthorized");
                    dispatcher = request.getRequestDispatcher("login.jsp");
                }

            } else {
                request.setAttribute("status", "fail");
                dispatcher = request.getRequestDispatcher("login.jsp");
            }

            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Login failed: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pst != null) pst.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}