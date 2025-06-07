<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Patient - Health Logger</title>
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
        a { color: #FFFFFF; text-decoration: none; }
    </style>
    <script>
        function validateForm() {
            let name = document.getElementById("name").value.trim();
            let email = document.getElementById("email").value.trim();
            let phone = document.getElementById("phone").value.trim();
            let age = document.getElementById("age").value.trim();
            let diagnosis = document.getElementById("diagnosis").value.trim();
            let remark = document.getElementById("remark").value.trim();
            let male = document.getElementById("male").checked;
            let female = document.getElementById("female").checked;
            let errorMessage = document.getElementById("error-message");

            // Validate required fields
            if (name === "" || email === "" || phone === "" || age === "" || diagnosis === "") {
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

            // Validate phone format (only digits, length between 10-15)
            let phonePattern = /^\d{10,15}$/;
            if (!phonePattern.test(phone)) {
                errorMessage.innerText = "Invalid phone number!";
                errorMessage.style.display = "block";
                return false;
            }

            // Validate age (must be a number greater than 0)
            if (isNaN(age) || age <= 0) {
                errorMessage.innerText = "Age must be a number greater than 0!";
                errorMessage.style.display = "block";
                return false;
            }

            // Validate gender selection
            if (!male && !female) {
                errorMessage.innerText = "Please select a gender!";
                errorMessage.style.display = "block";
                return false;
            }

            errorMessage.style.display = "none"; // Hide error message if validation passes
            return true;
        }
    </script>
</head>
<body>
<%
        if (session.getAttribute("doctorEmail") == null) {
            response.sendRedirect("doctorlogin.jsp");
        }
    %>
    
    <button class="btn btn-dark logout-btn"><a href="LogoutServlet">Logout</a></button>
    <div class="form-container">
        <h1>Add Patient</h1>
        <p class="text-muted text-center"><small>Add/Update Patient Details</small></p>
        <form action="PatientServlet" method="post" onsubmit="return validateForm()">
        
         <input type="hidden" name="action"  value="add">
            
            <input type="text" name="name" id="name" class="form-control" placeholder="Enter patient name" required>

           
            <input type="email" name="email" id="email" class="form-control" placeholder="Enter patient email" required>

           <input type="text" name="phone" id="phone" class="form-control" placeholder="Enter phone number" required>


            <input type="number" name="age" id="age" class="form-control" placeholder="Enter age" required>

            


            <input type="text" name="diagnosis" id="diagnosis" class="form-control" placeholder="Diagnosis details" required>

            
            <textarea name="remark" id="remark" class="form-control" rows="3" placeholder="Enter remarks (optional)"></textarea>


            <p id="error-message" class="error-message"></p>

            <label class="form-label">Gender</label>
            <div class="d-flex justify-content-start mb-3">
                <input type="radio" name="gender" value="Male" id="male">
                <label for="male" class="form-label mx-2">Male</label>
                <input type="radio" name="gender" value="Female" id="female">
                <label for="female" class="form-label mx-2">Female</label>
                
            </div>
            <button type="submit" class="btn btn-submit">Submit</button>
            <nav class="navbar">
        <div class="logout">
           
        </div>
    </nav>
        </form>
    </div>
</body>
</html>
