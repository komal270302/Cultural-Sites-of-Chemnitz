## Cultural Sites of Chemnitz

# Project Overview
This is a web application developed as a term paper project for the course "Datenbanken und Web-Techniken" in the Web Engineering study program at Technische Universität Chemnitz. The application allows users to explore cultural sites in Chemnitz, including museums, restaurants, artworks, and more, displayed on an interactive map. It features user authentication, favorites, reviews, and an admin dashboard. The app fetches cultural site data from OpenStreetMap (via GeoJSON), stores it in a MySQL database, and provides a frontend interface for browsing, filtering, and interacting with the sites.

# Features
- User Authentication: Register and login with JWT-based security. The first registered user becomes an admin.
- Interactive Map: Displays cultural sites using Leaflet.js, with markers for locations, details on click (name, type, website), and geolocation centering.
- Search and Filters: Filter sites by tourism/amenity types or search by name.
- Favorites: Add/remove sites to favorites and view a filtered list/map.
- Reviews: Add, edit, delete, and view reviews with ratings (1-5 stars) for sites.
- Top Rated Sites: View sites sorted by average rating.
- User Profile: Update name, email, or password.
- Admin Dashboard: View statistics (active/deleted users, sites, reviews, favorites) in a pie chart, manage users (deactivate/restore), and view deleted users.
- Data Management: Sites data imported from GeoJSON and stored in the database.

# Technologies Used
- Backend: Python with FastAPI, MySQL (via mysql-connector-python), JWT for authentication (jose, passlib).
- Frontend: HTML, CSS, JavaScript, Leaflet.js for maps, Chart.js for admin charts.
- Database: MySQL (schema includes tables for users, sites, reviews, favorites).
- Other Tools: GeoJSON for data import, XAMPP/phpMyAdmin for database setup.

# Installation
1. Prerequisites:
- Python 3.10+
- pip (Python package manager)
- XAMPP or MySQL Server
- Visual Studio Code (or any IDE)
- Web Browser (e.g., Chrome or Firefox)

2. Steps:
Clone the Repository: git clone https://github.com/your-username/cultural-sites-chemnitz.git, cd cultural-sites-chemnitz

3. Set Up the MySQL Database:
- Start XAMPP and enable Apache/MySQL.
- Open localhost/phpmyadmin in your browser.
- Create a new database: CREATE DATABASE cultural_sites_db;.
- Import cultural_sites_db.sql to create tables and insert sample data.

4. Install Python Dependencies : pip install -r requirements.txt

# Usage
- Run the Backend: Rub python -m uvicorn main:app --reload. The API will be available at http://localhost:8000.
- Access the Frontend: Open static/index.html in your browser or visit http://localhost:8000/ (served by FastAPI).
- Register and Login: Register a new user (first user is admin). Login to access features like map, favorites, reviews, and profile updates.
- Admin Features: Admins see a "Show Admin Dashboard" button for stats and user management.

For detailed step-by-step instructions, refer to User_manual.txt.

# API Documentation
The API endpoints are tested on Postman. All of the endpoint documentation is provided in the URL below: https://documenter.getpostman.com/view/44785890/2sB2xBBoue

# Contributors 
- Komal (komal202220@gmail.com)
- Sneha reddy Sripureddy

Contributors
Sneha Reddy Sriyapureddy Komal
