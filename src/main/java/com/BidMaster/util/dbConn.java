package com.BidMaster.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class dbConn {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/OnlineBiddingSystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "sql@2025";

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("MySQL JDBC Driver not found", e);
        }
    }
}