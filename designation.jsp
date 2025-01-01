<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Designation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <script>
        function showSkills() {
            var designation = document.querySelector('input[name="designation"]:checked').value;
            var skillGroups = document.querySelectorAll('.checkbox-group');
            
            skillGroups.forEach(function(group) {
                group.style.display = 'none';
            });
            
            var selectedGroup = document.getElementById(designation.toLowerCase() + '-skills');
            if (selectedGroup) {
                selectedGroup.style.display = 'block';
            }
        }

    </script>
</head>
<body class="meow">
    <header class="header">
        <nav class="navbar">
            <a href="index.jsp">
                <img src="logo.png" alt="CA Logo" class="logo">
            </a>
            
            <ul class="nav-links">
                <li><a href="register.jsp">Register</a></li>
                <li><a href="activity.jsp">Activity</a></li>
                <li><a href="display.jsp">Details</a></li>
                <li><a href="workshop.jsp">Workshops</a></li>
                <li><a href="memories.jsp">Memories</a></li>
                <li><a href="about.jsp">About</a></li>
            </ul>
        </nav>
    </header>
    <div class="container">
        <div class="form-wrapper">
            <h1>Choose One designation and what skills you have</h1>
            <%
    String rollno = request.getParameter("rollno");
    String designation = request.getParameter("designation");
    String[] skillsArray = request.getParameterValues("skills");
	List<String> skillsList = (skillsArray != null) ? Arrays.asList(skillsArray) : null;
	String skills = (skillsList != null && !skillsList.isEmpty()) ? String.join(", ", skillsList) : null;


    String rollnoError = "";
    String designationError = "";
    String skillError = "";

    boolean valid = true;

    if (rollno == null || !rollno.matches("^[0-9]+$")) {
        rollnoError = "Roll No should contain only numbers";
        valid = false;
        rollno = "";
    }

    if (valid) {
        String jdbcUrl = "jdbc:mysql://localhost/registration";
        String dbUser = "root";
        String dbPassword = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
            String insertQuery = "INSERT INTO `designation`(`rollno`, `designation`, `skills`) VALUES (?, ?, ?)";
            try (PreparedStatement preparedStatement = connection.prepareStatement(insertQuery)) {
                preparedStatement.setString(1, rollno);
                preparedStatement.setString(2, designation);
                preparedStatement.setString(3, skills);

                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {
                    out.println("<p style='color: green;'>The details you entered are recorded. We'll contact you soon.</p>");
                } else {
                    out.println("<p style='color: red;'>Error storing data in the database.</p>");
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            out.println("<p style='color: red;'> User Doesn't Exist Please first <a href='register.jsp'> register</a> </p>");
        }
    }
%>

            <form action="" method="post">
                <div class="form-group">
                    <label for="rollno">Roll No:</label>
                    <input type="text" id="rollno" name="rollno" value="<%= rollno %>" placeholder="Enter your Roll No" required>
                    <span class="error"><%= rollnoError %></span>
                </div>

                <div class="form-group">
                    <label>Designation:</label>
                    <label class="radio-label" for="graphics"><input type="radio" id="graphics" name="designation" value="Graphics" <%= "Graphics".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> Graphics</label>
                    <label class="radio-label" for="coverage"><input type="radio" id="coverage" name="designation" value="Coverage" <%= "Coverage".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> Coverage</label>
                    <label class="radio-label" for="creativity"><input type="radio" id="creativity" name="designation" value="Creativity" <%= "Creativity".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> Creativity</label>
                    <label class="radio-label" for="epub"><input type="radio" id="epub" name="designation" value="epub" <%= "epub".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> E-pub</label>
                    <label class="radio-label" for="publicity"><input type="radio" id="publicity" name="designation" value="Publicity" <%= "Publicity".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> Publicity</label>
                    <label class="radio-label" for="content"><input type="radio" id="content" name="designation" value="Content" <%= "Content".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> Content</label>
                    <label class="radio-label" for="mis"><input type="radio" id="mis" name="designation" value="MIS" <%= "MIS".equals(designation) ? "checked" : "" %> onclick="showSkills()" required> MIS</label>
                </div>

                <div class="form-group">
                    <label>Skills:</label>

                    <div class="checkbox-group" id="graphics-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Figma"> Figma</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Illustrator"> Illustrator</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Photoshop"> Photoshop</label>
                    </div>

                    <div class="checkbox-group" id="coverage-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Lightroom"> Lightroom</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Priemere Pro"> Priemere Pro</label>
                    </div>

                    <div class="checkbox-group" id="creativity-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Drawing"> Drawing</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Creative thinking"> Creative thinking</label>
                    </div>

                    <div class="checkbox-group" id="epub-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="E-book Creation">E-book Creation</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Social Media handling"> Social Media handling</label>
                    </div>

                    <div class="checkbox-group" id="publicity-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Social Media Marketing"> Social Media Marketing</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Event Promotion"> Event Promotion</label>
                    </div>

                    <div class="checkbox-group" id="content-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Content Writing"> Content Writing</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Copywriting"> Copywriting</label>
                    </div>

                    <div class="checkbox-group" id="mis-skills">
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Data Analysis"> Data Analysis</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="Reporting"> Reporting</label>
                        <label class="checkbox-label"><input type="checkbox" name="skills" value="MS Excel"> MS Excel</label>
                    </div>

                </div>

                <input type="submit" class="button" value="Submit">
            </form>
        </div>
    </div>
</body>
</html>
