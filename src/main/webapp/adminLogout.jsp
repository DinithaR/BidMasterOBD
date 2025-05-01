<%
    session.removeAttribute("admin");
    response.sendRedirect("adminLogin.jsp");
%>