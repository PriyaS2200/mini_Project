<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
  
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Health Logger - Doctor Login</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;600&display=swap" rel="stylesheet">
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
        .login-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 350px;
        }
        h1 {
            font-size: 2rem;
            font-weight: 600;
            color: #007bff;
            margin-bottom: 20px;
        }
        .form-control {
            border-radius: 5px;
            margin-bottom: 15px;
            font-size: 1rem;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 8px rgba(0, 123, 255, 0.5);
        }
        .btn-login {
            background-color: #007bff;
            color: white;
            font-size: 1.2rem;
            padding: 10px;
            border: none;
            border-radius: 5px;
            transition: 0.3s;
            width: 100%;
        }
        .btn-login:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.3);
        }
        .error { color: red; margin-bottom: 15px; text-align: center; }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Health Logger</h1>
        <p class="text-muted">Doctor Login</p>
        <%

            String error = (String) request.getAttribute("error");
            if (error != null) {
           %>
            <div class="error"><%= error %></div>
          <%
            }
          %>
        <form action="LoginServlet" method="post">
            <input type="email" name="email" class="form-control" placeholder="Enter your email" required>
            <input type="password" name="password" class="form-control" placeholder="Enter your password" required>
            <small><a href="doctorregister.jsp">If don't have an account. click here</a></small><br><br>
            
          
            <button type="submit" class="btn btn-login">Login</button>
        </form>
    </div>
</body>
</html>
