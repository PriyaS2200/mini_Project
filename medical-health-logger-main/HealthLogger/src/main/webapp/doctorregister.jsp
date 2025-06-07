<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Doctor Registration - Health Logger</title>
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
            background: #007bff;
            font-family: 'Poppins', sans-serif;
        }
        .form-container {
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.15);
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
            border-radius: 8px;
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
            padding: 12px;
            border: none;
            border-radius: 8px;
            transition: 0.3s;
            width: 100%;
            font-weight: 600;
        }
        .btn-submit:hover {
            background-color: #0056b3;
            transform: scale(1.05);
            box-shadow: 0px 5px 10px rgba(0, 0, 0, 0.3);
        }
        .error-message {
            color: red;
            font-size: 0.9rem;
            display: none;
        }
    </style>
    <script>
        function validateForm() {
            let email = document.getElementById("email").value;
            let password = document.getElementById("password").value;
            let confirmPassword = document.getElementById("confirm_password").value;
            let errorMessage = document.getElementById("error-message");

            // Check if fields are empty
            if (email === "" || password === "" || confirmPassword === "") {
                errorMessage.innerText = "All fields are required!";
                errorMessage.style.display = "block";
                return false;
            }

            // Validate email format
            let emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                errorMessage.innerText = "Invalid email format!";
                errorMessage.style.display = "block";
                return false;
            }

            // Check password length
            if (password.length < 8) {
                errorMessage.innerText = "Password must be at least 8 characters long!";
                errorMessage.style.display = "block";
                return false;
            }

            // Check if passwords match
            if (password !== confirmPassword) {
                errorMessage.innerText = "Passwords do not match!";
                errorMessage.style.display = "block";
                return false;
            }

            errorMessage.style.display = "none"; // Hide error message if validation passes
            return true;
        }
    </script>
</head>
<body>
    <div class="form-container">
        <h1>Doctor Registration</h1>
        <form action="RegisterServlet" method="post" onsubmit="return validateForm()">
            <label class="form-label">Email ID</label>
            <input type="email" name="email" id="email" class="form-control" placeholder="Enter your email" required>

            <label class="form-label">Password</label>
            <input type="password" name="password" id="password" class="form-control" placeholder="Enter password" required>

            <label class="form-label">Confirm Password</label>
            <input type="password" name="confirm_password" id="confirm_password" class="form-control" placeholder="Confirm password" required>

            <p id="error-message" class="error-message"></p>
            <small><a href ="doctorlogin.jsp">Already registered</a><br><br>
            

            <button type="submit" class="btn btn-submit">Register</button>
        </form>
    </div>
</body>
</html>
