<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Health Logger - Manage</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
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
            text-align: center;
            width: 400px;
        }
        h1 {
            font-size: 2.5rem;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2rem;
            color: #555;
            margin-bottom: 20px;
            font-weight: 500;
        }
        .btn-manage-patient {
            font-size: 1.2rem;
            padding: 12px 24px;
            background-color: #007bff; /* Primary Blue */
            color: white;
            border: none;
            border-radius: 5px;
            transition: 0.3s;
            margin-bottom: 10px;
            width: 100%;
        }
        .btn-manage-patient:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
        }
        .btn-manage-vitals {
            font-size: 1.2rem;
            padding: 12px 24px;
            background-color: #6c757d; /* Gray */
            color: white;
            border: none;
            border-radius: 5px;
            transition: 0.3s;
            width: 100%;
        }
        .btn-manage-vitals:hover {
            background-color: #545b62;
            transform: scale(1.05);
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
        }
        a{
          color:#FFFFFF;
          text-decoration:none;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Health Logger</h1>
       <p class="text-muted">Manage</p>
        <button class="btn btn-manage-patient"><a href="PatientServlet?action=list">Manage Patient</a></button>
        <button class="btn btn-manage-vitals"><a href="VitalsServlet?action=list">Manage Vitals</button>
    </div>
</body>
</html>
