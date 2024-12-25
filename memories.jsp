<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.DataSource" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.naming.NamingException" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <title>Memories</title>
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
    <div class="grid-container">
        <% 
            try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				String url = "jdbc:mysql://localhost/registration";
				String username = "root";
				String password = "";
				Connection connection = DriverManager.getConnection(url, username, password);

                String sql = "SELECT image_path, comment FROM user_images";
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);

                while (resultSet.next()) {
                    String imagePath = resultSet.getString("image_path");
                    String comment = resultSet.getString("comment");

                    out.println("<div class=\"grid-item\">");
                    out.println("<div class=\"image-overlay\">");
                    out.println("<img src='" + imagePath + "' alt='Image'>");
                    out.println("<div class=\"image-text\">" + comment + "</div>");
                    out.println("</div>");
                    out.println("</div>");
                }
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            } 
        %>
    </div>
</body>
</html>
