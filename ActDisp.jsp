<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display User Activity</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <style>
        .container {
            display: flex;
            flex-wrap: wrap;
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); 
        }

        .table {
            background-color: white;
        }
    </style>
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
        <form method="post" action="">
            <label for="searchQuery">Search:</label>
            <input type="text" id="searchQuery" name="searchQuery" placeholder="Enter name or roll number">
            <button type="submit">Search</button>
        </form>

        <table class="table">
            <thead>
                <tr>
                    <th>Roll No</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Activity</th>
                    <th>Description</th>
                    <th>Hours</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String searchQuery = request.getParameter("searchQuery");
                    String selectQuery;

                    if (searchQuery != null && !searchQuery.isEmpty()) {
                        selectQuery = "SELECT r.rollno, r.name, r.email, a.activity, a.description, a.hours FROM registration r " +
                                "LEFT JOIN activity a ON r.rollno = a.rollno " +
                                "WHERE (r.name LIKE '%" + searchQuery + "%' OR r.rollno LIKE '%" + searchQuery + "%') " +
                                "AND a.activity IS NOT NULL AND a.description IS NOT NULL";
                    } else {
                        selectQuery = "SELECT r.rollno, r.name, r.email, a.activity, a.description, a.hours FROM registration r " +
                                "LEFT JOIN activity a ON r.rollno = a.rollno " +
                                "WHERE a.activity IS NOT NULL AND a.description IS NOT NULL";
                    }

                    String jdbcUrl = "jdbc:mysql://localhost/registration";
                    String dbUser = "root";
                    String dbPassword = "";

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

                        try (Statement statement = connection.createStatement();
                             ResultSet resultSet = statement.executeQuery(selectQuery)) {

                            while (resultSet.next()) {
                                String rollno = resultSet.getString("rollno");
                                String name = resultSet.getString("name");
                                String email = resultSet.getString("email");
                                String activity = resultSet.getString("activity");
                                String description = resultSet.getString("description");
                                int hours = resultSet.getInt("hours");

                                out.println("<tr>");
                                out.println("<td>" + rollno + "</td>");
                                out.println("<td>" + name + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + activity + "</td>");
                                out.println("<td>" + description + "</td>");
                                out.println("<td>" + hours + "</td>");
                                out.println("</tr>");
                            }
                        }
                    } catch (ClassNotFoundException | SQLException e) {
                        out.println("<p style='color: red;'>Error retrieving data from the database: " + e.getMessage() + "</p>");
                    }
                %>
            </tbody>
        </table>
    </div>
</body>
</html>