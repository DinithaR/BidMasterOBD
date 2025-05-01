<%
    String adminUser = (String) session.getAttribute("admin");
    if (adminUser == null) {
        response.sendRedirect("adminLogin.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add User</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <h2>Add New User</h2>
    <form action="AddUserServlet" method="post">
        <input class="form-control my-2" name="name" placeholder="Name" required>
        <input class="form-control my-2" name="email" placeholder="Email" type="email" required>
        <input class="form-control my-2" name="password" placeholder="Password" type="password" required>
        <input class="form-control my-2" name="contact" placeholder="Contact Number" required>
        <button class="btn btn-success" type="submit">Add</button>
        <a href="adminUsers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>