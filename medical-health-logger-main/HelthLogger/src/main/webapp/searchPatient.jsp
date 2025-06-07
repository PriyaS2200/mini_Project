<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Logger - Search Patient</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
       
        .container { max-width: 1200px; margin: auto; background-color: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1); margin-top: 40px; margin-bottom: 40px; }
        .search-form { margin-bottom: 20px; }
        .error { color: red; margin-bottom: 15px; }
        .navbar { background-color: #f8f9fa; }
        .logout { position: absolute; top: 10px; right: 10px; }
        .logout a { color: #dc3545; text-decoration: none; }
        .logout a:hover { text-decoration: underline; }
        
        body {
            
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #007bff, #00c6ff);
            font-family: 'Poppins', sans-serif;
        }
       
       
    </style>
</head>
<body>
    <%
        if (session.getAttribute("doctorEmail") == null) {
            response.sendRedirect("doctorlogin.jsp");
        }
    %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="manage.jsp">Health Logger</a>
            <div class="navbar-nav">
                <a class="nav-link" href="manage.jsp">Home</a>
                <a class="nav-link" href="addpatient.jsp">Add Patient</a>
                 <a href="LogoutServlet" class="btn btn-dark btn-sm ms-2">Logout</a>
            </div>
            
        </div>
    </nav>
    <div class="container">
        <h2 class="text-center mb-4">Search Patient</h2>
        <form action="PatientServlet" method="get" class="search-form">
            <input type="hidden" name="action" value="search">
            <div class="input-group">
                <input type="text" name="query" class="form-control" placeholder="Search by name..." required>
                <button type="submit" class="btn btn-primary">Search</button>
            </div>
        </form>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <%
            }
        %>
        <h2>Results (<%
            List<Patient> patients = (List<Patient>) request.getAttribute("patients");
            out.print(patients != null ? patients.size() : 0);
        %>)</h2>
        <table class="table table-striped table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Age</th>
                    <th>Diagnosis</th>
                    <th>Remark</th>
                    <th>Gender</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (patients != null) {
                        for (int i = 0; i < patients.size(); i++) {
                            Patient patient = patients.get(i);
                %>
                <tr>
                    <td><%= (i + 1) %></td>
                    <td><%= patient.getName() %></td>
                    <td><%= patient.getEmail() %></td>
                    <td><%= patient.getPhone() %></td>
                    <td><%= patient.getAge() %></td>
                    <td><%= patient.getDiagnosis() != null ? patient.getDiagnosis() : "N/A" %></td>
                    <td><%= patient.getRemark() != null ? patient.getRemark() : "N/A" %></td>
                    <td><%= patient.getGender() %></td>
                    <td>
                        <a href="PatientServlet?action=edit&id=<%= patient.getId() %>" class="btn btn-sm btn-primary">Edit</a>
                        <a href="PatientServlet?action=delete&id=<%= patient.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
                    </td>
                </tr>
                <%
                        }
                    }
                %>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>