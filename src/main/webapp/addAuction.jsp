<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <title>Create Auction - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h3>Create New Auction</h3>
    <form action="AddAuctionServlet" method="post">
        <div class="mb-3">
            <label>Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>Description</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>
        <div class="mb-3">
            <label>Start Price</label>
            <input type="number" name="start_price" step="0.01" class="form-control" required>
        </div>
        <div class="mb-3">
            <label>End Time</label>
            <input type="datetime-local" name="end_time" class="form-control" required>
        </div>
        <button class="btn btn-success" type="submit">Create Auction</button>
        <a href="auctionList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>