<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="stylles.css">
    <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap" rel="stylesheet">
    <title>Computer Association</title>
</head>
<body>
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

        <section class="hero">
            <div class="hero-content">
                <h1>Welcome to Computer Association</h1>
                <p>The Computer Association, the pulse of our CS/IT community, is more than just an academic organization; it's a family of passionate minds, united by a shared love for technology and an unwavering commitment to excellence.</p>
                <p>Our student body chapter is a hub of creativity and camaraderie, where cutting-edge coding and exciting events collide. From coding competitions that fuel friendly rivalries to hackathons that push the boundaries of innovation, we're always at the forefront of technological advancement. But don't be fooled by the tech jargon; we also know how to unwind and have a great time together.</p>
            </div>
            <div class="about-image">
                <img src="IMG_1388.jpg" alt="Computer Association Image">
            </div>
            
        </section>
        <section class="about">
            <div class="hero-image">
                <img src="ca-image.png" alt="Computer Association Image">
            </div>
            <div class="about-content">
                <h2>Know Some More</h2>
                <p>At the Computer Association, we believe that fun is an essential part of the learning experience. Our members don't just build software; they forge lasting friendships and create unforgettable memories through social events, game nights, and spontaneous adventures. Whether you're a seasoned programmer or just embarking on your journey in the world of CS/IT, you'll discover a welcoming community that encourages personal growth, skill development, and, most importantly, a lot of fun!</p>
                <p>Join us as we code, create, and celebrate the thrilling world of technology. Together, we're shaping a future where innovation and enjoyment go hand in hand.</p>
            </div>
            
        </section>

    <script>
        // Get elements for menu toggle
const menuToggle = document.querySelector(".menu-toggle");
const navLinks = document.querySelector(".nav-links");

// Toggle the navigation menu on click
menuToggle.addEventListener("click", () => {
    navLinks.classList.toggle("show");
    menuToggle.classList.toggle("open");
});

// Close the navigation menu when a link is clicked
const navLinksList = document.querySelectorAll(".nav-links a");
navLinksList.forEach((link) => {
    link.addEventListener("click", () => {
        navLinks.classList.remove("show");
        menuToggle.classList.remove("open");
    });
});

// Add a hover effect to the menu items
navLinksList.forEach((link) => {
    link.addEventListener("mouseenter", () => {
        link.style.color = "#FF5733";
    });

    link.addEventListener("mouseleave", () => {
        link.style.color = "white";
    });
});

    </script>
</body>
</html>
