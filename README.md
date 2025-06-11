# Computer Association Web Application

## Overview
This project is a web application for a Computer Association. It allows members to register for activities, view information about the association, share memories, and provides administrative functionalities.

## Features
-   **Activity Registration:** Users can register for various activities organized by the association.
-   **Information Hub:** Provides details about the association, its activities, and workshops.
-   **Memory Sharing:** Members can upload images and comments to share their memories.
-   **Admin Panel:** (Inferred) Likely includes administrative features to manage users, activities, and content.

## Technology Stack
### Frontend
-   HTML
-   CSS (stylles.css)
-   JavaScript
-   Bootstrap

### Backend
-   Java Servlets
-   JSP (JavaServer Pages)

### Database
-   MySQL

## Setup and Installation
To run this project locally, you will need:
-   Java JDK (8 or higher)
-   Apache Tomcat (or any other Servlet container)
-   MySQL Server

**Database Setup:**
1.  Ensure your MySQL server is running.
2.  Create two databases named `registration` and `images`.
3.  The application expects the MySQL user `root` with no password, or you may need to update the database connection details in the Java files (e.g., `UploadServlet.java`, `activity.jsp`, `memories.jsp`).

**Deployment:**
1.  Compile the Java Servlet (`UploadServlet.java`). Ensure the compiled class file is placed in the correct `WEB-INF/classes` directory.
2.  Deploy the entire project folder (including JSP files, HTML, CSS, images, and `WEB-INF` directory) to your Servlet container (e.g., copy to Tomcat's `webapps` folder).
3.  Access the application through your web browser (e.g., `http://localhost:8080/your-project-name/`).
