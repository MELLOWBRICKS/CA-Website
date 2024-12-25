import java.io.IOException;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String imageName = request.getParameter("image");
        String comment = request.getParameter("comment");

        try {
            insertIntoDatabase(imageName, comment);
            response.sendRedirect("memories.jsp");
        } catch (SQLException | ClassNotFoundException e) {
            handleException(response, e);
        }
    }

    private void insertIntoDatabase(String imageName, String comment)
            throws SQLException, ClassNotFoundException {
        String jdbcURL = "jdbc:mysql://localhost/images";
        String dbUser = "root";
        String dbPassword = "";

        Class.forName("com.mysql.cj.jdbc.Driver");

        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
             PreparedStatement statement = connection.prepareStatement("INSERT INTO user_images (image_path, comment) VALUES (?, ?)")) {

            String imagePath = imageName;

            statement.setString(1, imagePath);
            statement.setString(2, comment);

            statement.executeUpdate();
        }
    }
    private void handleException(HttpServletResponse response, Exception e) throws IOException {
        e.printStackTrace();
        response.getWriter().println("Error: " + e.getMessage());
    }
}
