<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Logger - Add Vitals</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #007bff, #00c6ff);
            font-family: 'Poppins', sans-serif;
        }
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            width: 400px;
        }
        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }
        .form-label {
            font-weight: 500;
            color: #343a40;
        }
        .form-control {
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 1rem;
            padding: 10px;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
        }
        .btn-submit {
            background-color: #007bff;
            color: white;
            font-size: 1.2rem;
            padding: 10px;
            border: none;
            border-radius: 5px;
            transition: 0.3s;
            width: 100%;
        }
        .btn-submit:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            display: none;
        }
        .logout-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            color: white;
        }
        a {
            color: #FFFFFF;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Add Patient's Vitals</h1>
        <form action="VitalsServlet" method="post">
            <input type="hidden" name="action" value="add">
            <div class="mb-3">
                <label class="form-label" for="patient_id">Select Patient</label>
                <select class="form-control" id="patient_id" name="patient_id" required>
                    <% 
                        List<Patient> patients = new ArrayList<>();
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            java.sql.Connection conn = java.sql.DriverManager.getConnection("jdbc:mysql://localhost:3306/healthlogger", "root", "Password@12");
                            java.sql.PreparedStatement stmt = conn.prepareStatement("SELECT * FROM patients");
                            java.sql.ResultSet rs = stmt.executeQuery();
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
                            rs.close();
                            stmt.close();
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                        for (Patient patient : patients) { 
                    %>
                        <option value="<%= patient.getId() %>"><%= patient.getName() %></option>
                    <% } %>
                </select>
            </div>
            <div class="mb-3">
                <label class="form-label" for="bp_low">BP Low</label>
                <input type="number" class="form-control" id="bp_low" name="bp_low" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="bp_high">BP High</label>
                <input type="number" class="form-control" id="bp_high" name="bp_high" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="spo2">SPO2</label>
                <input type="number" class="form-control" id="spo2" name="spo2" required>
            </div>
            <button type="submit" class="btn btn-submit">Submit</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
