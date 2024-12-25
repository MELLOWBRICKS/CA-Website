<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Your Memories</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
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
    <div class="containerAdd">
        <div class="form-wrapperAdd">
            <h1>Add Your Memories</h1>
            
            <form method="POST">
                <label for="image">Image Name:</label>
                <input type="text" name="image" id="image" required>
                <br><br>
                <label for="comment">Comment:</label>
                <textarea name="comment" id="comment" rows="2" required></textarea>
                <br><br>
                <input type="submit" value="Submit">
            

            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String imageName = request.getParameter("image");
                    String comment = request.getParameter("comment");

                    String jdbcURL = "jdbc:mysql://localhost/registration";
                    String dbUser = "root";
                    String dbPassword = "";

                    Connection connection = null;
                    PreparedStatement statement = null;

                    try {
                        // Step 1: Establish a connection
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);

                        // Step 2: Prepare and execute the insert statement
                        String query = "INSERT INTO user_images (image_path, comment) VALUES (?, ?)";
                        statement = connection.prepareStatement(query);
                        statement.setString(1, imageName);
                        statement.setString(2, comment);
                        statement.executeUpdate();

                        // Step 3: Redirect after successful insertion
                        out.println("<p>Memory added successfully!</p>");
                        response.sendRedirect("memories.jsp"); // Optionally redirect after submission

                    } catch (SQLException | ClassNotFoundException e) {
                        e.printStackTrace();
                        out.println("<p>Error: " + e.getMessage() + "</p>");
                    } finally {
                        // Step 4: Close the database resources
                        try {
                            if (statement != null) statement.close();
                            if (connection != null) connection.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
</form>
        </div>
    </div>
</body>
</html>
