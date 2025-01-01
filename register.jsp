<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
</head>
<body class="meow">
    <header class="header">
        <nav class="navbar">
            <a href="index.jsp">
                <img src="logo.png" alt="CA Logo" class="logo">
            </a>
            
            <ul class="nav-links">
                <li><a href="designation.jsp">Designation</a></li>
                <li><a href="activity.jsp">Activity</a></li>
                <li><a href="workshop.jsp">Workshops</a></li>
                <li><a href="memories.jsp">Memories</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div class="form-wrapper">
            <h1>CA Registration form for FY</h1>
            <%
                String name = request.getParameter("name");
                String rollno = request.getParameter("rollno");
                String stream = request.getParameter("stream");
                String email = request.getParameter("email");

                String nameError = "";
                String rollnoError = "";
                String emailError = "";

                boolean valid = true;
                if (name == null || !name.matches("^[A-Za-z\\s]+$")) {
                    nameError = "Name should only contain letters and spaces";
                    valid = false;
                    name = "";
                }

                if (rollno == null || !rollno.matches("^[0-9]+$")) {
                    rollnoError = "Roll No should contain only numbers";
                    valid = false;
                    rollno = "";
                }

                if (email == null || !email.endsWith("@student.mes.ac.in")) {
                    emailError = "Email must end with '@student.mes.ac.in'";
                    valid = false;
                    email = "";
                }

                if (valid) {
                    String jdbcUrl = "jdbc:mysql://localhost/registration";
                    String dbUser = "root";
                    String dbPassword = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                        String insertQuery = "INSERT INTO registration (name, rollno, stream, email) VALUES (?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                            preparedStatement.setString(1, name);
                            preparedStatement.setString(2, rollno);
                            preparedStatement.setString(3, stream);
                            preparedStatement.setString(4, email);

                            int rowsAffected = preparedStatement.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p style='color: green;'>The details you entered are recorded. We'll contact you soon.</p>");
                                out.println("<p style='color: green;'>Go to <a href='designation.jsp'> designation </a> to continue</p>");
                            } else {
                                out.println("<p style='color: red;'>Error storing data in the database.</p>");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p style='color: red;'>Database connection error: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <form action="register.jsp" method="post">
                <div class="form-group">
                    <label for="name">Name:</label>
                    <input type="text" id="name" name="name" value="<%= name %>" placeholder="Enter your name" required>
                    <span class="error"><%= nameError %></span>
                </div>

                <div class="form-group">
                    <label for="rollno">Roll No:</label>
                    <input type="text" id="rollno" name="rollno" value="<%= rollno %>" placeholder="Enter your Roll No" required>
                    <span class="error"><%= rollnoError %></span>
                </div>

                <div class="form-group">
                    <label for="email">MES Email id:</label>
                    <input type="email" id="email" name="email" value="<%= email %>" placeholder="Enter your MES Email id" required>
                    <span class="error"><%= emailError %></span>
                </div>

                <div class="form-group">
                    <label>Stream:</label>
                    <label class="radio-label" for="bsc-cs"><input type="radio" id="bsc-cs" name="stream" value="Bsc CS" <%= "Bsc CS".equals(stream) ? "checked" : "" %> required> Bsc CS</label>
                    <label class="radio-label" for="bsc-it"><input type="radio" id="bsc-it" name="stream" value="Bsc IT" <%= "Bsc IT".equals(stream) ? "checked" : "" %>> Bsc IT</label>
                    <label class="radio-label" for="bca"><input type="radio" id="bca" name="stream" value="BCA" <%= "BCA".equals(stream) ? "checked" : "" %>> BCA</label>
                </div>

                <input type="submit" class="button" value="Submit">
            </form>
        </div>
    </div>
</body>
</html>