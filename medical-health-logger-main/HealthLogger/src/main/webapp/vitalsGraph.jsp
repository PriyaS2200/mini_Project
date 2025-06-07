<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.model.Vital" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Doctor Home Page - Vitals Graph</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    <style>
   
   
    
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
    .abnormal {
        background-color: #ffcccc;
        color: #ff0000;
    }
    .navbar {
        background-color: #f8f9fa;
        box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        position: fixed;
        top: 0;
        width: 100%;
        z-index: 1000;
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
            <div class="banner-buttons">
                <a href="PatientServlet?action=list" class="btn btn-secondary btn-sm">Manage Patients</a>
                <div class="dropdown d-inline-block">
                    <button class="btn btn-secondary btn-sm dropdown-toggle" type="button" id="exportDropdown" data-bs-toggle="dropdown" aria-expanded="false">
                        Export
                    </button>
                    <ul class="dropdown-menu" aria-labelledby="exportDropdown">
                        <li><a class="dropdown-item" href="VitalsServlet?action=export&format=pdf">PDF</a></li>
                        <li><a class="dropdown-item" href="VitalsServlet?action=export&format=excel">Excel</a></li>
                        <li><a class="dropdown-item" href="VitalsServlet?action=export&format=csv">CSV</a></li>
                    </ul>
                </div>
                <a href="addVitals.jsp" class="btn btn-secondary btn-sm">Record New Vital</a>
                <a href="VitalsServlet?action=alerts" class="btn btn-secondary btn-sm">Vital Alerts</a>
                <a href="VitalsServlet?action=graph" class="btn btn-secondary btn-sm">Graph</a>
                 <a href="LogoutServlet" class=" btn btn-dark btn-sm ms-2">Logout</a>
                
            </div>
           
        </div>
    </nav>
    <div class="container">
        <h2 class="text-center mb-4">Doctor Home Page - Vitals Graph</h2>
        <%
            String error = (String) request.getAttribute("error");
            if (error != null) {
        %>
            <div class="alert alert-danger text-center"><%= error %></div>
        <%
            }
        %>
        <canvas id="vitalsChart"></canvas>
    </div>
    <%
        List<Vital> vitals = (List<Vital>) request.getAttribute("vitals");
        StringBuilder labels = new StringBuilder("[");
        StringBuilder bpLowData = new StringBuilder("[");
        StringBuilder bpHighData = new StringBuilder("[");
        StringBuilder spo2Data = new StringBuilder("[");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if (vitals != null) {
            for (int i = 0; i < vitals.size(); i++) {
                Vital vital = vitals.get(i);
                labels.append("\"").append(sdf.format(vital.getRecordedOn())).append("\"");
                bpLowData.append(vital.getBpLow());
                bpHighData.append(vital.getBpHigh());
                spo2Data.append(vital.getSpo2());
                if (i < vitals.size() - 1) {
                    labels.append(",");
                    bpLowData.append(",");
                    bpHighData.append(",");
                    spo2Data.append(",");
                }
            }
        }
        labels.append("]");
        bpLowData.append("]");
        bpHighData.append("]");
        spo2Data.append("]");
    %>
    <script>
        const ctx = document.getElementById('vitalsChart').getContext('2d');
        new Chart(ctx, {
            type: 'line',
            data: {
                labels: <%= labels.toString() %>,
                datasets: [
                    {
                        label: 'BP Low',
                        data: <%= bpLowData.toString() %>,
                        borderColor: 'violet',
                        fill: false
                    },
                    {
                        label: 'BP High',
                        data: <%= bpHighData.toString() %>,
                        borderColor: 'green',
                        fill: false
                    },
                    {
                        label: 'SPO2',
                        data: <%= spo2Data.toString() %>,
                        borderColor: 'red',
                        fill: false
                    }
                ]
            },
            options: {
                responsive: true,
                scales: {
                    x: {
                        title: {
                            display: true,
                            text: 'Recorded On'
                        }
                    },
                    y: {
                        title: {
                            display: true,
                            text: 'Value'
                        },
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
 