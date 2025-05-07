<%@ page import="java.sql.*" %>
<%@ page session="true" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        int bidId = Integer.parseInt(request.getParameter("bid_id"));

        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

        PreparedStatement pst = conn.prepareStatement(
            "DELETE FROM bid WHERE bid_id = ? AND user_id = ?");
        pst.setInt(1, bidId);
        pst.setInt(2, userId);
        pst.executeUpdate();

        pst.close();
        conn.close();
    } catch (Exception e) {
        // optional logging
    }

    response.sendRedirect("myBids.jsp");
%>