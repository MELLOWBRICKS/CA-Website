<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Activity Data</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css"> <!-- Your custom styles -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
</head>
<body class="meow">
    <header class="header">
        <nav class="navbar">
            <a href="Web.jsp">
                <img src="logo.png" alt="CA Logo" class="logo">
            </a>
            
            <ul class="nav-links">
                <li><a href="register.jsp">Register</a></li>
                <li><a href="activity.jsp">Activity</a></li>
                <li><a href="workshop.jsp">Workshops</a></li>
                <li><a href="memories.jsp">Memories</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div class="form-wrapper">
            <h1>Activity Registration Form</h1>
            <%-- JSP Validation and Form Submission Logic --%>
            <%
                String rollno = request.getParameter("rollno");
                String activity = request.getParameter("activity");
                String description = request.getParameter("description");
                String hours = request.getParameter("hours");

                String rollnoError = "";
                String activityError = "";
                String hoursError = "";

                boolean valid = true;

                if (rollno == null || !rollno.matches("^[0-9]+$")) {
                    rollnoError = "Roll No should contain only numbers";
                    valid = false;
                    rollno = "";
                }

                if (activity == null || activity.trim().isEmpty()) {
                    activityError = "Activity name is required";
                    valid = false;
                    activity = "";
                }

                if (hours == null || !hours.matches("^[0-9]+$")) {
                    hoursError = "Hours should contain only numbers";
                    valid = false;
                    hours = "";
                }

                if (valid) {
                    String jdbcUrl = "jdbc:mysql://localhost/registration";
                    String dbUser = "root";
                    String dbPassword = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                        String checkRegistrationQuery = "SELECT * FROM registration WHERE rollno=?";
                        try (PreparedStatement checkRegistrationStatement = connection.prepareStatement(checkRegistrationQuery)) {
                            checkRegistrationStatement.setString(1, rollno);
                            ResultSet registrationResultSet = checkRegistrationStatement.executeQuery();

                            if (registrationResultSet.next()) {
                                String insertActivityQuery = "INSERT INTO activity (rollno, activity, description, hours) VALUES (?, ?, ?, ?)";
                                try (PreparedStatement activityStatement = connection.prepareStatement(insertActivityQuery)) {
                                    activityStatement.setString(1, rollno);
                                    activityStatement.setString(2, activity);
                                    activityStatement.setString(3, description);
                                    activityStatement.setInt(4, Integer.parseInt(hours));
                                    int activityRowsAffected = activityStatement.executeUpdate();

                                    if (activityRowsAffected > 0) {
                                        out.println("<p style='color: green;'>Activity details recorded successfully.</p>");
                                    } else {
                                        out.println("<p style='color: red;'>Error storing activity data in the database.</p>");
                                    }
                                }
                            } else {
                                out.println("<p style='color: red;'>You're not registered. Please <a href='register.jsp'>register</a> first.</p>");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p style='color: red;'>Database connection error: " + e.getMessage() + "</p>");
                    }
                }
            %>

            <form action="activity.jsp" method="post">
                <div class="form-group">
                    <label for="rollno">Roll No:</label>
                    <input type="text" id="rollno" name="rollno" value="<%= rollno %>" placeholder="Enter your Roll No" required>
                    <span class="error"><%= rollnoError %></span>
                </div>

                <div class="form-group">
                    <label for="activity">Activity Name:</label>
                    <input type="text" id="activity" name="activity" value="<%= activity %>" placeholder="Enter the activity name" required>
                    <span class="error"><%= activityError %></span>
                </div>

                <div class="form-group">
                	<%= description = "" %>
                    <label for="description">Description:</label>
                    <textarea id="description" name="description" placeholder="Enter a small description (optional)"><%= description %></textarea>
                </div>

                <div class="form-group">
                    <label for="hours">Hours:</label>
                    <input type="text" id="hours" name="hours" value="<%= hours %>" placeholder="Enter the hours spent" required>
                    <span class="error"><%= hoursError %></span>
                </div>

                <input type="submit" class="button" value="Submit">
            </form>
        </div>
    </div>
</body>
</html>
