package com.test;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String url = "jdbc:mysql://localhost:3306/HealthLogger";
		String user = "root";
		String pass = "Password@12";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con = DriverManager.getConnection(url,user,pass);
			PreparedStatement ps = con.prepareStatement("select * from Doctor where email=? and password=?");
			ps.setString(1, email);
			ps.setString(2, password);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next()) {
				
				HttpSession session = request.getSession();
				session.setAttribute("doctorEmail", email);
				
				response.sendRedirect("manage.jsp");
			}else {
				request.setAttribute("error", "Invalid email or password");
                request.getRequestDispatcher("doctorlogin.jsp").forward(request, response);

			}
			
			con.close();
			
		} catch (ClassNotFoundException | SQLException e) {
			
			e.printStackTrace();
			request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("doctorlogin.jsp").forward(request, response);

			
		}
		
	}

}
