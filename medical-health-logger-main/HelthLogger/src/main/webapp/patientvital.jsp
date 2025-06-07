<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Health Logger - Record Vitals</title>
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
            transition: 0.3s;
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
    </style>
</head>
<body>
    <div class="form-container">
        <h1>Health Logger</h1>
        <p class="text-muted text-center"><small>Add Patient's vitals Information</small></p>
        <form action="VitalsServlet" method="post">
            <label class="form-label">Select Patient</label>
            <select name="patient_id" class="form-control" required>
                <option value="" disabled selected>Select patient</option>
                <option value="1">John Doe</option>
                <option value="2">Jane Smith</option>
                <option value="3">Michael Lee</option>
            </select>

            <label class="form-label">BP Low</label>
            <input type="number" name="bp_low" class="form-control" placeholder="Enter BP low" required>

            <label class="form-label">BP High</label>
            <input type="number" name="bp_high" class="form-control" placeholder="Enter BP high" required>

            <label class="form-label">SPO2</label>
            <input type="number" name="spo2" class="form-control" placeholder="Enter SPO2 level" required>

            <button type="submit" class="btn btn-submit">Submit</button>
        </form>
    </div>
</body>
</html>
