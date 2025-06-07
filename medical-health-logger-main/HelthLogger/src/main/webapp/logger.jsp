<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Health Logger</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Roboto:wght@400;500&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(to right, #007bff, #00c6ff);
            font-family: 'Roboto', sans-serif;
        }
        .container {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
        }
        h1 {
            font-size: 3rem;
            font-family: "Poppins", sans-serif; /* Sleek font */
            color: #007bff;
            font-weight: 600;
        }
        p {
            font-size: 1.2rem;
            color: #999; /* Disabled text effect */
            font-style: italic;
        }
        .btn-custom {
            font-size: 1.2rem;
            padding: 12px 24px;
            background-color: #007bff;
            color: white;
            border-radius: 5px;
            transition: 0.3s;
            border: none;
            font-weight: 500;
        }
        .btn-custom:hover {
            background-color: #0056b3;
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
        <p><small>Developed by Pallavi Agrawal</small></p>
        <button class="btn btn-custom"><a href="doctorlogin.jsp">Doctor Login</a></button>
    </div>
</body>
</html>
