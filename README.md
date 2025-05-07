# 🧾 BidMaster – Online Bidding System

**BidMaster** is a full-stack Java web application designed to manage online auctions. It provides a role-based system for administrators, sellers, and bidders to perform CRUD operations on users, auctions, bids, and categories.

## 🚀 Features

- **User Management**
  - Admin CRUD for managing users
- **Auction Management**
  - Sellers can create, update, and delete auctions with images
- **Bid Management**
  - Bidders can place and manage bids on live auctions
- **Category Management**
  - Admin can create, edit, and assign categories to auctions
- **Role-Based Dashboard**
  - Different dashboards for Admin, Seller, and Bidder
- **Responsive UI**
  - Built with Bootstrap for a modern and clean look

## 🛠 Technologies Used

- Java, JSP, Servlets
- JDBC for database connectivity
- MySQL for backend storage
- HTML5, CSS3, Bootstrap 5
- Apache Tomcat (tested on Tomcat 10+)

## 📁 Project Structure

OnlineBiddingSystem/
├── src/
│   ├── com.BidMaster.admin
│   ├── com.BidMaster.auction
│   ├── com.BidMaster.bid
│   ├── com.BidMaster.category
│   └── com.BidMaster.login
├── WebContent/
│   ├── JSP pages (home.jsp, login.jsp, dashboard.jsp, addAuction.jsp, etc.)
│   ├── CSS / Images
│   └── WEB-INF/web.xml

## ⚙️ Setup Instructions

1. Clone this repository  
   ```bash
   git clone https://github.com/your-username/BidMaster.git

	2.	Import into your preferred IDE (Eclipse/IntelliJ) as a dynamic web project.
	3.	Set up the MySQL database:
	•	Create a database named: OnlineBiddingSystem
	•	Run the SQL script provided in /sql/OnlineBiddingSystem.sql
	4.	Update DB credentials in each servlet:

private static final String DB_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
private static final String DB_USER = "root";
private static final String DB_PASS = "your_password";


	5.	Deploy on Apache Tomcat and run the application.

⸻

Built with ❤️ using Java, JSP, and MySQL

---

Let me know if you’d like the actual SQL file or screenshots added into this structure as well.
