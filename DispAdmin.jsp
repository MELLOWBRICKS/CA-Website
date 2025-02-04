<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Display Registration Data</title>
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

        .delete-btn {
            background-color: #dc3545;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
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
                <%-- <li><a href="dispReg.jsp">Members</a></li>       --%>  
                <li><a href="DispAdmin.jsp">Manage Details</a></li>
                <%-- <li><a href="ActDisp.jsp">Activity</a></li> --%>
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
                    <th>Designation</th>
                    <th>Stream</th>
                    <th>Email</th>
                    <th>Skills</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String searchQuery = request.getParameter("searchQuery");
                    String selectQuery;

                   		if (searchQuery != null && !searchQuery.isEmpty()) {
                   		    selectQuery = "SELECT r.rollno, r.name, d.designation, r.stream, r.email, d.skills FROM registration r " +
                   		            "LEFT JOIN designation d ON r.rollno = d.rollno " +
                   		            "WHERE r.name LIKE '%" + searchQuery + "%' OR r.rollno LIKE '%" + searchQuery + "%'";
                   		} else {
                   		    selectQuery = "SELECT r.rollno, r.name, d.designation, r.stream, r.email, d.skills FROM registration r " +
                   		            "LEFT JOIN designation d ON r.rollno = d.rollno";
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
                                String designation = resultSet.getString("designation");
                                String stream = resultSet.getString("stream");
                                String email = resultSet.getString("email");
                                String skills = resultSet.getString("skills");

                                out.println("<tr>");
                                out.println("<td>" + rollno + "</td>");
                                out.println("<td>" + name + "</td>");
                                out.println("<td>" + designation + "</td>");
                                out.println("<td>" + stream + "</td>");
                                out.println("<td>" + email + "</td>");
                                out.println("<td>" + skills + "</td>");

                                out.println("<td>");
                                out.println("<form method='post' action='delete.jsp'>");
                                out.println("<input type='hidden' name='deleteName' value='" + name + "'>");
                                out.println("<input type='hidden' name='deleteRoll' value='" + rollno + "'>");
                                out.println("<input type='hidden' name='deleteDesig' value='" + designation + "'>");
                                out.println("<input type='hidden' name='deleteStream' value='" + stream + "'>");
                                out.println("<input type='hidden' name='deleteMail' value='" + email + "'>");
                                out.println("<input type='hidden' name='deleteSkills' value='" + skills + "'>");
                                out.println("<button type='submit' class='delete-btn'>Delete</button>");
                                out.println("</form>");
                                out.println("</td>");

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
