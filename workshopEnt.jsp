<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Workshop</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css"> <!-- Your custom styles -->
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
</head>
<body class="meow">
    <header class="header">
        <nav class="navbar">
            <a href="WebAdmin.jsp">
                <img src="logo.png" alt="CA Logo" class="logo">
            </a>
            
            <ul class="nav-links">
            	<li><a href="dispReg.jsp">Members</a></li>            
                <li><a href="DispAdmin.jsp">Manage Details</a></li>
                <li><a href="ActDisp.jsp">Activity</a></li>
                <li><a href="workshopEnt.jsp">Add Workshop</a></li>
                <li><a href="AddAMemory.jsp">Add Memory</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div class="form-wrapper">
            <h1>Add Workshop</h1>
            <%
                String wsName = request.getParameter("wsName");
                String wsDescription = request.getParameter("wsDescription");
                String date = request.getParameter("date");
                String time = request.getParameter("time");
                String imagePath = "update?" + request.getParameter("imagePath");
               
                String wsNameError = "";
                String dateError = "";
                String timeError = "";

                boolean valid = true;

                if (wsName == null || wsName.trim().isEmpty()) {
                    wsNameError = "Workshop name is required";
                    valid = false;
                    wsName = "";
                }

                if (date == null || date.trim().isEmpty()) {
                    dateError = "Date is required";
                    valid = false;
                    date = "";
                }

                if (time == null || time.trim().isEmpty()) {
                    timeError = "Time is required";
                    valid = false;
                    time = "";
                }

                if (valid) {
                    String jdbcUrl = "jdbc:mysql://localhost/registration";
                    String dbUser = "root";
                    String dbPassword = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
                        String insertWorkshopQuery = "INSERT INTO ca_workshops (ws_name, ws_description, date, time, image_path) VALUES (?, ?, ?, ?, ?)";
                        try (PreparedStatement preparedStatement = connection.prepareStatement(insertWorkshopQuery)) {
                            preparedStatement.setString(1, wsName);
                            preparedStatement.setString(2, wsDescription);
                            preparedStatement.setString(3, date);
                            preparedStatement.setString(4, time);
                            preparedStatement.setString(5, imagePath);

                            int rowsAffected = preparedStatement.executeUpdate();

                            if (rowsAffected > 0) {
                                out.println("<p style='color: green;'>Workshop details recorded successfully.</p>");
                            } else {
                                out.println("<p style='color: red;'>Error storing workshop data in the database.</p>");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p style='color: red;'>Database connection error: " + e.getMessage() + "</p>");
                    }
                }
            %>
            <form action="" method="post">
                <div class="form-group">
                    <label for="wsName">Workshop Name:</label>
                    <input type="text" id="wsName" name="wsName" value="<%= wsName %>" placeholder="Enter workshop name" required>
                    <span class="error"><%= wsNameError %></span>
                </div>
                
                <div class="form-group">
                	<% imagePath=""; %>
                    <label for="imagePath">Image Path:</label>
                    <input type="text" id="imagePath" name="imagePath" value="<%= imagePath %>" placeholder="Enter image path (optional)">
                </div>

                <div class="form-group">
		             <% wsDescription =""; %>
                    <label for="wsDescription">Workshop Description:</label>
                    <textarea id="wsDescription" name="wsDescription" placeholder="Enter workshop description"><%= wsDescription %></textarea>
                </div>

                <div class="form-group">
                    <label for="date">Date:</label>
                    <input type="date" id="date" name="date" value="<%= date %>" required>
                    <span class="error"><%= dateError %></span>
                </div>

                <div class="form-group">
                    <label for="time">Time:</label>
                    <input type="time" id="time" name="time" value="<%= time %>" required>
                    <span class="error"><%= timeError %></span>
                </div>

                <input type="submit" class="button" value="Submit">
            </form>
        </div>
    </div>
</body>
</html>
