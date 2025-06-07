<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Patient" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Health Logger - Update Patient</title>
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
    </style>
</head>
<body>
    <%
        if (session.getAttribute("doctorEmail") == null) {
            response.sendRedirect("doctorlogin.jsp");
        }
        Patient patient = (Patient) request.getAttribute("patient");
    %>
    <div class="form-container">
        <h1>Update Patient Information</h1>
        <form action="PatientServlet" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= patient.getId() %>">
            <div class="mb-3">
                <label class="form-label" for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= patient.getName() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" value="<%= patient.getEmail() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="phone">Phone</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= patient.getPhone() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="age">Age</label>
                <input type="number" class="form-control" id="age" name="age" value="<%= patient.getAge() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="diagnosis">Diagnosis</label>
                <input type="text" class="form-control" id="diagnosis" name="diagnosis" value="<%= patient.getDiagnosis() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="remark">Remark</label>
                <input type="text" class="form-control" id="remark" name="remark" value="<%= patient.getRemark() %>" required>
            </div>
            <div class="mb-3">
                <label class="form-label" for="gender">Gender</label>
                <select class="form-control" id="gender" name="gender" required>
                    <option value="male" <%= "male".equals(patient.getGender()) ? "selected" : "" %>>Male</option>
                    <option value="female" <%= "female".equals(patient.getGender()) ? "selected" : "" %>>Female</option>
                </select>
            </div>
            <button type="submit" class="btn-submit">Update</button>
        </form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
