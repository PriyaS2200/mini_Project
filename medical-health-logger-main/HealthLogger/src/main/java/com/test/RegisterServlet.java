package com.test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;


@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            // Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/HealthLogger", "root", "Password@12");
            

            // Insert Doctor Data
            PreparedStatement ps = con.prepareStatement("INSERT INTO Doctor (email, password) VALUES (?, ?)");
            ps.setString(1, email);
            ps.setString(2, password);
            
            int row = ps.executeUpdate();
            if (row > 0) {
                response.sendRedirect("doctorlogin.jsp"); // Redirect to Login Page after successful registration
            } else {
                response.sendRedirect("register.jsp?error=Registration failed!");
            }
            
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("register.jsp?error=Something went wrong!");
        }

	}

}
