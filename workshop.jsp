<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <title>Workshop Details</title>
    <style>
        .image-text {
            display: flex;
            flex-direction: column;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>
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

    <div>
        <h1>Workshop Details</h1>

        <form action="" method="POST" style="padding-left: 30px;">
            <label for="workshopName" style="margin-right: 10px;">Search Workshop:</label>
            <input type="text" id="workshopName" name="workshopName">
            <button type="submit" style="margin-left: 10px;">Search </button>
            <H5 style="margin-right: 10px;"><a href="WorksReg.jsp">Register</a> for a Workshop right now</H5>
        </form>

        <div class="grid-container">
            <% 
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    String url = "jdbc:mysql://localhost/registration";
                    String username = "root";
                    String password = "";
                    Connection connection = DriverManager.getConnection(url, username, password);

                    String workshopNameParam = request.getParameter("workshopName");
                    CallableStatement callableStatement = connection.prepareCall("{call GetWorkshops(?)}");

                    if (workshopNameParam != null && !workshopNameParam.isEmpty()) {
                        callableStatement.setString(1, workshopNameParam);
                    } else {
                        callableStatement.setString(1, null);
                    }

                    ResultSet resultSet = callableStatement.executeQuery();

                    while (resultSet.next()) {
                        String wsName = resultSet.getString("ws_name");
                        String wsDescription = resultSet.getString("ws_description");
                        String date = resultSet.getString("date");
                        String time = resultSet.getString("time");
                        String imagePath = resultSet.getString("image_path");

                        out.println("<div class=\"grid-item\">");
                        out.println("<div class=\"image-overlay\">");
                        out.println("<img src='" + imagePath + "' alt='Workshop Image'>");
                        out.println("<div class=\"image-text\">");
                        out.println("<h1>" + wsName + "</h1><br><br>");
                        out.println("<p><strong>Description:</strong> <h4>" + wsDescription + "</h4></p><br><br>");
                        out.println("<p><strong>Date:</strong> " + date + "</p><br><br>");
                        out.println("<p><strong>Time:</strong> " + time + "</p><br><br>");
                        out.println("</div>");
                        out.println("</div>");
                        out.println("</div>");
                    }
                } catch (ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                } 
            %>
        </div>
    </div>
</body>
</html>
