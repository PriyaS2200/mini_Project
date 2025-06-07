<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Home Page - Patient Details</title>
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
        .container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 1200px;
        }
         h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        .table th {
            background-color: #343a40;
            color: white;
        }
        .btn {
            border-radius: 5px;
        }
        .btn:hover {
            transform: scale(1.05);
            transition: 0.3s;
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
    <%
        if (session.getAttribute("doctorEmail") == null) {
            response.sendRedirect("doctorlogin.jsp");
        }
    %>
    <nav class="navbar navbar-expand-lg bg-light fixed-top p-3">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-primary" href="manage.jsp">Health Logger</a>
            <div class="d-flex">
                <a href="searchPatient.jsp" class="btn btn-secondary btn-sm ms-2">Search Patient</a>
                <a href="addpatient.jsp" class="btn btn-secondary btn-sm ms-2">Add Patient</a>
                <a href="VitalsServlet?action=list" class="btn btn-secondary btn-sm ms-2">Manage Vitals</a>
                <a href="LogoutServlet" class="btn btn-dark btn-sm ms-2">Logout</a>
             
            </div>
            
        </div>
    </nav>
    <div class="container">
        <h2>Doctor Home Page - Patient Details</h2>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <% } %>
        <h3>Patients (<%= (request.getAttribute("patients") != null) ? ((List<Patient>) request.getAttribute("patients")).size() : 0 %>)</h3>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name-Age</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Diagnosis</th>
                    <th>Remark</th>
                    <th>Gender</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% List<Patient> patients = (List<Patient>) request.getAttribute("patients"); %>
                <% if (patients != null) { %>
                    <% for (int i = 0; i < patients.size(); i++) { %>
                        <% Patient patient = patients.get(i); %>
                        <tr>
                            <td><%= (i + 1) %></td>
                            <td><%= patient.getName() %> - <%= patient.getAge() %></td>
                            <td><%= patient.getEmail() %></td>
                            <td><%= patient.getPhone() %></td>
                            <td><%= patient.getDiagnosis() != null ? patient.getDiagnosis() : "N/A" %></td>
                            <td><%= patient.getRemark() != null ? patient.getRemark() : "N/A" %></td>
                            <td><%= patient.getGender() %></td>
                            <td>
                                <a href="addVitals.jsp?patient_id=<%= patient.getId() %>&patient_name=<%= patient.getName() %>" class="btn btn-sm btn-secondary">Manage Vitals</a>
                                <a href="PatientServlet?action=edit&id=<%= patient.getId() %>" class="btn btn-sm btn-success">Update</a>
                                <a href="PatientServlet?action=delete&id=<%= patient.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                            </td>
                        </tr>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
