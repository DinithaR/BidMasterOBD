<%@ page session="true" %>

<!DOCTYPE html>
<html>
<head>
    <title>Add Category - BidMaster</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2>Add New Category</h2>
    <form action="AddCategoryServlet" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Category Name</label>
            <input type="text" name="name" id="name" class="form-control" required>
            <label for="description" class="form-label">Description</label>
            <input type="text" name="description" id="description" class="form-control">
        </div>
        <button type="submit" class="btn btn-success">Add Category</button>
        <a href="categoryList.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>