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

import com.model.Vital;


@WebServlet("/VitalsServlet")
public class VitalsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String DB_URL = "jdbc:mysql://localhost:3306/healthlogger";
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "Password@12";
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
        if ("list".equals(action)) {
            listVitals(request, response);
        } else if ("delete".equals(action)) {
            deleteVital(request, response);
        } else if ("graph".equals(action)) {
            showGraph(request, response);
        } else if ("alerts".equals(action)) {
            showAlerts(request, response);
        } else if ("export".equals(action)) {
            exportVitals(request, response);
        }
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   String action = request.getParameter("action");
	        if ("add".equals(action)) {
	            addVitals(request, response);
	        }
	}
	
	private void listVitals(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vital> vitals = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = """
                    SELECT v.*, p.name AS patient_name, p.phone AS patient_phone
                    FROM vitals v
                    JOIN patients p ON v.patient_id = p.id
                    ORDER BY v.recorded_on DESC
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Vital vital = new Vital();
                        vital.setId(rs.getInt("id"));
                        vital.setPatientId(rs.getInt("patient_id"));
                        vital.setPatientName(rs.getString("patient_name"));
                        vital.setPatientPhone(rs.getString("patient_phone"));
                        vital.setBpLow(rs.getInt("bp_low"));
                        vital.setBpHigh(rs.getInt("bp_high"));
                        vital.setSpo2(rs.getInt("spo2"));
                        vital.setRecordedOn(rs.getTimestamp("recorded_on"));
                        vitals.add(vital);
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
        request.setAttribute("vitals", vitals);
        request.getRequestDispatcher("vitalsList.jsp").forward(request, response);
    }
 
    private void addVitals(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "INSERT INTO vitals (patient_id, bp_low, bp_high, spo2, recorded_on) VALUES (?, ?, ?, ?, NOW())";
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    stmt.setInt(1, Integer.parseInt(request.getParameter("patient_id")));
                    stmt.setInt(2, Integer.parseInt(request.getParameter("bp_low")));
                    stmt.setInt(3, Integer.parseInt(request.getParameter("bp_high")));
                    stmt.setInt(4, Integer.parseInt(request.getParameter("spo2")));
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
        response.sendRedirect("VitalsServlet?action=list");
    }
    
    private void deleteVital(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = "DELETE FROM vitals WHERE id = ?";
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
        response.sendRedirect("VitalsServlet?action=list");
    }
 
    private void showGraph(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vital> vitals = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = """
                    SELECT v.*, p.name AS patient_name, p.phone AS patient_phone
                    FROM vitals v
                    JOIN patients p ON v.patient_id = p.id
                    ORDER BY v.recorded_on DESC
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Vital vital = new Vital();
                        vital.setId(rs.getInt("id"));
                        vital.setPatientId(rs.getInt("patient_id"));
                        vital.setPatientName(rs.getString("patient_name"));
                        vital.setPatientPhone(rs.getString("patient_phone"));
                        vital.setBpLow(rs.getInt("bp_low"));
                        vital.setBpHigh(rs.getInt("bp_high"));
                        vital.setSpo2(rs.getInt("spo2"));
                        vital.setRecordedOn(rs.getTimestamp("recorded_on"));
                        vitals.add(vital);
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
        request.setAttribute("vitals", vitals);
        request.getRequestDispatcher("vitalsGraph.jsp").forward(request, response);
    }
 
    private void showAlerts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Vital> vitals = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = """
                    SELECT v.*, p.name AS patient_name, p.phone AS patient_phone
                    FROM vitals v
                    JOIN patients p ON v.patient_id = p.id
                    WHERE v.bp_low < 60 OR v.bp_high > 140 OR v.spo2 < 90
                    ORDER BY v.recorded_on DESC
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Vital vital = new Vital();
                        vital.setId(rs.getInt("id"));
                        vital.setPatientId(rs.getInt("patient_id"));
                        vital.setPatientName(rs.getString("patient_name"));
                        vital.setPatientPhone(rs.getString("patient_phone"));
                        vital.setBpLow(rs.getInt("bp_low"));
                        vital.setBpHigh(rs.getInt("bp_high"));
                        vital.setSpo2(rs.getInt("spo2"));
                        vital.setRecordedOn(rs.getTimestamp("recorded_on"));
                        vitals.add(vital);
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
        request.setAttribute("vitals", vitals);
        request.getRequestDispatcher("vitalAlerts.jsp").forward(request, response);
    }
 
    private void exportVitals(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String format = request.getParameter("format");
        List<Vital> vitals = new ArrayList<>();
        
        // Fetch vitals data
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String sql = """
                    SELECT v.*, p.name AS patient_name, p.phone AS patient_phone
                    FROM vitals v
                    JOIN patients p ON v.patient_id = p.id
                    ORDER BY v.recorded_on DESC
                """;
                try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Vital vital = new Vital();
                        vital.setId(rs.getInt("id"));
                        vital.setPatientId(rs.getInt("patient_id"));
                        vital.setPatientName(rs.getString("patient_name"));
                        vital.setPatientPhone(rs.getString("patient_phone"));
                        vital.setBpLow(rs.getInt("bp_low"));
                        vital.setBpHigh(rs.getInt("bp_high"));
                        vital.setSpo2(rs.getInt("spo2"));
                        vital.setRecordedOn(rs.getTimestamp("recorded_on"));
                        vitals.add(vital);
                    }
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("vitalsList.jsp").forward(request, response);
            return;
        }
 
        if ("csv".equals(format)) {
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"vitals_export.csv\"");
            try (java.io.PrintWriter out = response.getWriter()) {
                out.println("Sr.No,Name,Phone,BP Low,BP High,SPO2,Recorded On");
                for (int i = 0; i < vitals.size(); i++) {
                    Vital vital = vitals.get(i);
                    out.println(
                        (i + 1) + "," +
                        vital.getPatientName() + "," +
                        vital.getPatientPhone() + "," +
                        vital.getBpLow() + "," +
                        vital.getBpHigh() + "," +
                        vital.getSpo2() + "," +
                        vital.getRecordedOn()
                    );
                }
            } catch (Exception e) {
                e.printStackTrace();
                throw new ServletException("Error generating CSV", e);
            }
        } else {
            request.setAttribute("error", "Invalid export format");
            request.getRequestDispatcher("vitalsList.jsp").forward(request, response);
        }
    }
 

}
