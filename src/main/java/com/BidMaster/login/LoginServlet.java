package com.BidMaster.login;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.sun.jdi.connect.spi.Connection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("username");
		String password = request.getParameter("password");

		HttpSession session = request.getSession();
		RequestDispatcher dispatcher = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			java.sql.Connection conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

			PreparedStatement pst = conn.prepareStatement(
					"SELECT * FROM user WHERE email = ? AND password = ?");

			pst.setString(1, email);
			pst.setString(2, password);

			ResultSet rs = pst.executeQuery();

			if (rs.next()) {
				session.setAttribute("id", rs.getInt("id"));
				session.setAttribute("name", rs.getString("name"));
				session.setAttribute("email", rs.getString("email"));
				session.setAttribute("contact_no", rs.getString("contact_no"));

				dispatcher = request.getRequestDispatcher("home.jsp");
			} else {
				request.setAttribute("status", "fail");
				dispatcher = request.getRequestDispatcher("login.jsp");
			}
			dispatcher.forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().println("Login failed: " + e.getMessage());
		}
	}
		
	}

