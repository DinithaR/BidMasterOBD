<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Create Auction - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .auction-form {
            max-width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 16px;
            box-shadow: 0 8px 16px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <a class="navbar-brand fw-bold" href="home.jsp">BidMaster</a>
        <a class="btn btn-outline-light" href="auctionList.jsp">Back to Dashboard</a>
    </div>
</nav>

<div class="auction-form">
    <h3 class="mb-4 text-center fw-bold">Create New Auction</h3>

    <form action="AddAuctionServlet" method="post" enctype="multipart/form-data">
        <div class="mb-3">
            <label class="form-label">Title</label>
            <input type="text" name="title" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Description</label>
            <textarea name="description" class="form-control" required></textarea>
        </div>

        <div class="mb-3">
            <label class="form-label">Start Price ($)</label>
            <input type="number" name="start_price" step="0.01" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">End Time</label>
            <input type="datetime-local" name="end_time" class="form-control" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Auction Image</label>
            <input type="file" name="image" accept="image/*" class="form-control" required>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
            <button class="btn btn-success me-md-2" type="submit">Create Auction</button>
            <a href="auctionList.jsp" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

</body>
</html>