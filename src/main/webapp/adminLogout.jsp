<%
    session.removeAttribute("admin");
    response.sendRedirect("home.jsp");
%>