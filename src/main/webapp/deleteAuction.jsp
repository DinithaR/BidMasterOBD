<%@ page import="java.sql.*" %>
<%

    String auctionId = request.getParameter("id");

    if (auctionId != null && !auctionId.isEmpty()) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/OnlineBiddingSystem", "root", "sql@2025");

            PreparedStatement pst = conn.prepareStatement("DELETE FROM auctions WHERE id = ?");
            pst.setInt(1, Integer.parseInt(auctionId));

            int rows = pst.executeUpdate();
            conn.close();

            if (rows > 0) {
                response.sendRedirect("auctionList.jsp?delete=success");
            } else {
                response.sendRedirect("auctionList.jsp?delete=notfound");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("auctionList.jsp?delete=error");
        }
    } else {
        response.sendRedirect("auctionList.jsp?delete=invalid");
    }
%>