<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registration for Workshops</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
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
            <h1>Registration for Workshops</h1>
            <%
                String jdbcUrl = "jdbc:mysql://localhost/registration";
                String dbUser = "root";
                String dbPassword = "";

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                    // Call the stored procedure
                    CallableStatement callableStatement = connection.prepareCall("{call GetWorkshopDetails()}");
                    callableStatement.execute();

                    // Retrieve workshop names for the form
                    String selectWorkshopsQuery = "SELECT ws_name FROM ca_workshops";
                    try (Statement statement = connection.createStatement();
                         ResultSet resultSet = statement.executeQuery(selectWorkshopsQuery)) {
            %>
                        <form action="" method="post">
                            <div class="form-group">
                                <label for="wsName">Select Workshop:</label>
                                <select id="wsName" name="wsName">
                                    <%
                                        while (resultSet.next()) {
                                            String workshopName = resultSet.getString("ws_name");
                                    %>
                                            <option value="<%= workshopName %>"><%= workshopName %></option>
                                    <%
                                        }
                                    %>
                                </select>
                            </div>

                            <div class="form-group">
                                <label for="rollno">Roll Number:</label>
                                <input type="text" id="rollno" name="rollno" placeholder="Enter your roll number" required>
                            </div>

                            <div class="form-group">
                                <label for="email">Email:</label>
                                <input type="email" id="email" name="email" placeholder="Enter your email" required>
                            </div>

                            <input type="submit" class="button" value="Register">
                        </form>

                        <%
                            if (request.getMethod().equalsIgnoreCase("post")) {
                                String selectedWorkshop = request.getParameter("wsName");
                                String rollNumber = request.getParameter("rollno");
                                String email = request.getParameter("email");

                                String checkRollNumberQuery = "SELECT * FROM registration WHERE rollno=?";
                                try (PreparedStatement checkStatement = connection.prepareStatement(checkRollNumberQuery)) {
                                    checkStatement.setString(1, rollNumber);

                                    try (ResultSet checkResultSet = checkStatement.executeQuery()) {
                                        if (checkResultSet.next()) {
                                            String insertRegistWorksQuery = "INSERT INTO registWorks (ws_name, rollno, email) VALUES (?, ?, ?)";
                                            try (PreparedStatement preparedStatement = connection.prepareStatement(insertRegistWorksQuery)) {
                                                preparedStatement.setString(1, selectedWorkshop);
                                                preparedStatement.setString(2, rollNumber);
                                                preparedStatement.setString(3, email);

                                                int rowsAffected = preparedStatement.executeUpdate();

                                                if (rowsAffected > 0) {
                                                    out.println("<p style='color: green;'>Registration successful.</p>");
                                                } else {
                                                    out.println("<p style='color: red;'>Error registering for the workshop.</p>");
                                                }
                                            }
                                        } else {
                                            out.println("<p style='color: red;'>User Doesn't Exist. Please first <a href='register.jsp'>register</a></p>");
                                        }
                                    }
                                }
                            }
                        %>
            <%
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    out.println("<p style='color: red;'>Database connection error: " + e.getMessage() + "</p>");
                }
            %>
        </div>
    </div>
</body>
</html>
