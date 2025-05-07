<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String bidIdStr = request.getParameter("bid_id");
    String currentAmountStr = request.getParameter("current_bid_amount");

    String errorMessage = (String) request.getAttribute("errorMessage");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Bid</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f8f9fa;
        }
        form {
            max-width: 400px;
            margin: 50px auto;
            background: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        input[type="number"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-top: 10px;
        }
        .error {
            color: red;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container d-flex justify-content-between align-items-center">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
    </div>
</nav>

<h2 class="text-center mt-4">Update Your Bid</h2>

<% if (errorMessage != null) { %>
    <div class="error text-center"><%= errorMessage %></div>
<% } %>

<form action="UpdateBidServlet" method="post">
    <input type="hidden" name="bid_id" value="<%= bidIdStr %>" />

    <label>Current Bid Amount:</label>
    <input type="text" value="<%= currentAmountStr != null ? currentAmountStr : "N/A" %>" disabled />

    <label>New Bid Amount:</label>
    <input type="number" name="new_bid_amount" step="0.01" required />

    <input type="submit" class="btn btn-primary mt-3" value="Update Bid" />
</form>
<a href="myBids.jsp" class="btn btn-secondary mt-3">Back</a>

</body>
</html>