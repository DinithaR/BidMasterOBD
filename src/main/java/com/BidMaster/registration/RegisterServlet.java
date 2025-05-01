package com.BidMaster.registration;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String contact = request.getParameter("contact");

		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

			PreparedStatement pst = conn.prepareStatement(
				"INSERT INTO user(name, email, password, contact_no) VALUES (?, ?, ?, ?)");

			pst.setString(1, name);
			pst.setString(2, email);
			pst.setString(3, password);
			pst.setString(4, contact);

			int row = pst.executeUpdate();
			if (row > 0) {
				request.setAttribute("status", "success");
			} else {
				request.setAttribute("status", "fail");
			}
			dispatcher = request.getRequestDispatcher("register.jsp");
			dispatcher.forward(request, response);

		} catch (SQLIntegrityConstraintViolationException e) {
			request.setAttribute("status", "fail");
			dispatcher = request.getRequestDispatcher("register.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Registration failed: " + e.getMessage());
		}
	}
}