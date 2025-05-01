<%@ page import="java.sql.*" %>
<%
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }

    int auctionId = Integer.parseInt(request.getParameter("id"));
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");
    PreparedStatement pst = conn.prepareStatement("DELETE FROM auctions WHERE id = ?");
    pst.setInt(1, auctionId);
    int rows = pst.executeUpdate();
    pst.close();
    conn.close();

    response.sendRedirect("auctionList.jsp");
%>