<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<html lang="en">
<head>
    <title>Delete User</title>
</head>
<body>

<%
    String jdbcUrl = "jdbc:mysql://localhost/registration";
    String dbUser = "root";
    String dbPassword = "";

    String deleteRoll = request.getParameter("deleteRoll");
    String deleteSkills = request.getParameter("deleteSkills");
    String deleteDesig = request.getParameter("deleteDesig");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);

        String deleteQuery;
        boolean isRegistration = "null".equals(deleteDesig) && "null".equals(deleteSkills);

        if (isRegistration) {
            deleteQuery = "DELETE FROM registration WHERE rollno = ?";
        } else {
            deleteQuery = "DELETE FROM designation WHERE rollno = ? AND (skills = ? OR skills IS NULL) AND (designation = ? OR designation IS NULL)";
        }

        try (PreparedStatement deleteStatement = connection.prepareStatement(deleteQuery)) {
            deleteStatement.setString(1, deleteRoll);

            if (!isRegistration) {
                deleteStatement.setString(2, "null".equals(deleteSkills) ? null : deleteSkills);
                deleteStatement.setString(3, "null".equals(deleteDesig) ? null : deleteDesig);
            }
            int rowsAffected = deleteStatement.executeUpdate();

            if (rowsAffected > 0) {
                out.println("<p>User deleted successfully.</p>");
                response.sendRedirect("DispAdmin.jsp");
            } else {
                out.println("<p>No user found with the specified details.</p>");
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        out.println("<p style='color: red;'>Error deleting user: " + e.getMessage() + "</p>");
    }
%>

</body>
</html>
