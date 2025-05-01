package com.BidMaster.dao;

import com.BidMaster.model.User;
import java.sql.*;
import java.util.*;

public class UserDAO {
    private Connection conn;

    public UserDAO(Connection conn) {
        this.conn = conn;
    }

    public List<User> getAllUsers() throws SQLException {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM user";
        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery(sql);
        while (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setPassword(rs.getString("password"));
            u.setContact(rs.getString("contact_no"));
            list.add(u);
        }
        return list;
    }

    public void addUser(User user) throws SQLException {
        String sql = "INSERT INTO user(name, email, password, contact_no) VALUES (?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPassword());
        stmt.setString(4, user.getContact());
        stmt.executeUpdate();
    }

    public void updateUser(User user) throws SQLException {
        String sql = "UPDATE user SET name=?, email=?, password=?, contact_no=? WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, user.getName());
        stmt.setString(2, user.getEmail());
        stmt.setString(3, user.getPassword());
        stmt.setString(4, user.getContact());
        stmt.setInt(5, user.getId());
        stmt.executeUpdate();
    }

    public void deleteUser(int id) throws SQLException {
        String sql = "DELETE FROM user WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        stmt.executeUpdate();
    }

    public User getUserById(int id) throws SQLException {
        String sql = "SELECT * FROM user WHERE id=?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            User u = new User();
            u.setId(rs.getInt("id"));
            u.setName(rs.getString("name"));
            u.setEmail(rs.getString("email"));
            u.setPassword(rs.getString("password"));
            u.setContact(rs.getString("contact_no"));
            return u;
        }
        return null;
    }
}