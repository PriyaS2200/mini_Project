<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Vital" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Home Page - Vitals Details</title>
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
            margin-top: 80px;
        }
        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: black;
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
        .navbar {
    background-color: #f8f9fa;
    box-shadow: 0 4px 6px rgba(0,0,0,0.1);
    position: fixed;
    top: 0;
    width: 100%;
    z-index: 1000;
}

.navbar .container-fluid {
    justify-content: end; /* Move navbar to the right */
}

.banner-buttons a {
    margin-left: 10px;
}

.navbar .logout {
    margin-left: auto;
}

.navbar .navbar-brand {
    font-weight: bold;
    color: #007bff;
}

.navbar-nav .nav-link {
    color: #343a40;
    font-weight: 500;
}

 
    </style>
</head>
<body>
<%
        if (session.getAttribute("doctorEmail") == null) {
            response.sendRedirect("doctorlogin.jsp");
        }
    %>
    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
    <div class="container-fluid justify-content-end">
        <a class="navbar-brand me-auto" href="manage.jsp">Health Logger</a>
        <div class="banner-buttons">
            <a href="PatientServlet?action=list" class="btn btn-secondary btn-sm ms-3">Manage Patients</a>
            <div class="dropdown d-inline-block">
                <button class="btn btn-secondary btn-sm dropdown-toggle ms-3" type="button" id="exportDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                    Export
                </button>
                <ul class="dropdown-menu" aria-labelledby="exportDropdown">
                    <li><a class="dropdown-item" href="VitalsServlet?action=export&format=pdf">PDF</a></li>
                    <li><a class="dropdown-item" href="VitalsServlet?action=export&format=excel">Excel</a></li>
                    <li><a class="dropdown-item" href="VitalsServlet?action=export&format=csv">CSV</a></li>
                </ul>
            </div>
            <a href="addVitals.jsp" class="btn btn-secondary btn-sm ms-3">Record New Vital</a>
            <a href="VitalsServlet?action=alerts" class="btn btn-secondary btn-sm ms-3">Vital Alerts</a>
            <a href="VitalsServlet?action=graph" class="btn btn-secondary btn-sm ms-3">Graph</a>
        </div>
        <div class="logout">
            <a href="LogoutServlet" class="btn btn-dark btn-sm ms-3">Logout</a>
        </div>
    </div>
</nav>
    
    <div class="container">
        <h1>Doctor Home Page - Vitals Details</h1>
        <% String error = (String) request.getAttribute("error"); %>
        <% if (error != null) { %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <% } %>
        <h3>Vitals (<%= (request.getAttribute("vitals") != null) ? ((List<Vital>) request.getAttribute("vitals")).size() : 0 %>)</h3>
        <table class="table table-striped table-bordered">
            <thead>
                <tr>
                    <th>Sr.No</th>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>BP Low</th>
                    <th>BP High</th>
                    <th>SPO2</th>
                    <th>Recorded On</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% List<Vital> vitals = (List<Vital>) request.getAttribute("vitals"); %>
                <% if (vitals != null) { %>
                    <% for (int i = 0; i < vitals.size(); i++) { %>
                        <% Vital vital = vitals.get(i); %>
                        <tr>
                            <td><%= (i + 1) %></td>
                            <td><%= vital.getPatientName() %></td>
                            <td><%= vital.getPatientPhone() %></td>
                            <td><%= vital.getBpLow() %></td>
                            <td><%= vital.getBpHigh() %></td>
                            <td><%= vital.getSpo2() %></td>
                            <td><%= vital.getRecordedOn() %></td>
                            <td>
                                <a href="VitalsServlet?action=delete&id=<%= vital.getId() %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</a>
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
