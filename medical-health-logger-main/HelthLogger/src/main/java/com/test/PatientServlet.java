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
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.Patient;


@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://localhost:3306/HealthLogger";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "Password@12";
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
        if ("list".equals(action)) {
            listPatients(request, response);
        } else if ("search".equals(action)) {
            searchPatients(request, response);
        } else if ("edit".equals(action)) {
            editPatient(request, response);
        } else if ("delete".equals(action)) {
            deletePatient(request, response);
        }
    }
	

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		  String action = request.getParameter("action");
	        if ("add".equals(action)) {
	            addPatient(request, response);
	        } else if ("update".equals(action)) {
	            updatePatient(request, response);
	        }
	}
	
	private void listPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Patient> patients = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM patients";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        patients.add(new Patient(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getInt("age"),
                            rs.getString("diagnosis"),
                            rs.getString("remark"),
                            rs.getString("gender")
                        ));
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("patientList.jsp").forward(request, response);
    }
 
    private void searchPatients(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Patient> patients = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM patients WHERE name LIKE ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, "%" + query + "%");
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        patients.add(new Patient(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getInt("age"),
                            rs.getString("diagnosis"),
                            rs.getString("remark"),
                            rs.getString("gender")
                        ));
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.setAttribute("patients", patients);
        request.getRequestDispatcher("searchPatient.jsp").forward(request, response);
    }
    
    private void addPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO patients (name, email, phone, age, diagnosis, remark, gender) VALUES (?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, request.getParameter("name"));
                    stmt.setString(2, request.getParameter("email"));
                    stmt.setString(3, request.getParameter("phone"));
                    stmt.setInt(4, Integer.parseInt(request.getParameter("age")));
                    stmt.setString(5, request.getParameter("diagnosis"));
                    stmt.setString(6, request.getParameter("remark"));
                    stmt.setString(7, request.getParameter("gender"));
                    stmt.executeUpdate();
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        response.sendRedirect("PatientServlet?action=list");
    }
 
    private void editPatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Patient patient = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "SELECT * FROM patients WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    ResultSet rs = stmt.executeQuery();
                    if (rs.next()) {
                        patient = new Patient(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getInt("age"),
                            rs.getString("diagnosis"),
                            rs.getString("remark"),
                            rs.getString("gender")
                        );
                    }
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        request.setAttribute("patient", patient);
        request.getRequestDispatcher("updatePatient.jsp").forward(request, response);
    }
    
    private void updatePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "UPDATE patients SET name = ?, email = ?, phone = ?, age = ?, diagnosis = ?, remark = ?, gender = ? WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setString(1, request.getParameter("name"));
                    stmt.setString(2, request.getParameter("email"));
                    stmt.setString(3, request.getParameter("phone"));
                    stmt.setInt(4, Integer.parseInt(request.getParameter("age")));
                    stmt.setString(5, request.getParameter("diagnosis"));
                    stmt.setString(6, request.getParameter("remark"));
                    stmt.setString(7, request.getParameter("gender"));
                    stmt.setInt(8, Integer.parseInt(request.getParameter("id")));
                    stmt.executeUpdate();
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        response.sendRedirect("PatientServlet?action=list");
    }
 
    private void deletePatient(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM patients WHERE id = ?";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, id);
                    stmt.executeUpdate();
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("error", "JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
        }
        response.sendRedirect("PatientServlet?action=list");
    }
 
 

}
