from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles
from fastapi.responses import FileResponse
import os
from fastapi import HTTPException
from fastapi import Path
from pydantic import BaseModel, conint
from fastapi import status
from Jwt_login import get_current_user
from fastapi import Depends,Query
from Jwt_login import router as auth_router  
from fastapi.middleware.cors import CORSMiddleware
from typing import Optional
import mysql.connector
from passlib.context import CryptContext

# Password hashing context
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Define app FIRST
app = FastAPI()

# Then mount static folder
app.mount("/static", StaticFiles(directory="static"), name="static")

# Then add route to serve index.html
@app.get("/", response_class=FileResponse)
def serve_index():
    return FileResponse(os.path.join("static", "index.html"))


# Allow frontend (like HTML in browser) to talk to backend
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Include the routes from Jwt_login.py
app.include_router(auth_router)

def get_connection():
    return mysql.connector.connect(
    # Replace with your actual DB credentials
    host='localhost',
    user='root',
    password='',  
    database='cultural_sites_db'
)

#Pydantc Models
class FavoriteCreate(BaseModel):
    user_id: int
    site_id: int

class ReviewCreate(BaseModel):
    user_id: int
    site_id: int
    rating: conint(ge=1, le=5) 
    text: str

class ReviewUpdate(BaseModel):
    rating: conint(ge=1, le=5)
    text: str    

class UserUpdate(BaseModel):
    name: Optional[str] = None
    email: Optional[str] = None
    password: Optional[str] = None  

#Post for favorite
@app.post("/favorites")
def add_favorite(favorite: FavoriteCreate):
    conn = get_connection()
    cursor = conn.cursor()
    try:
        # Check if user exists
        cursor.execute("SELECT id FROM users WHERE id = %s", (favorite.user_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"User ID {favorite.user_id} not found")

        # Check if site exists
        cursor.execute("SELECT id FROM sites WHERE id = %s", (favorite.site_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"Site ID {favorite.site_id} not found")

        # Check if already exists to prevent duplicates
        cursor.execute("SELECT * FROM favorites WHERE user_id = %s AND site_id = %s", (favorite.user_id, favorite.site_id))
        if cursor.fetchone():
            raise HTTPException(status_code=409, detail="Favorite already exists")

        # Insert new favorite
        cursor.execute(
            "INSERT INTO favorites (user_id, site_id) VALUES (%s, %s)",
            (favorite.user_id, favorite.site_id)
        )
        conn.commit()
        return {"message": "Favorite added successfully"}
    finally:
        conn.close()

# POST for Review
@app.post("/reviews", status_code=status.HTTP_201_CREATED)
def create_review(review: ReviewCreate):
    conn = get_connection()
    cursor = conn.cursor()

    try:
        # Check if user exists
        cursor.execute("SELECT id FROM users WHERE id = %s", (review.user_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"User ID {review.user_id} not found")

        # Check if site exists
        cursor.execute("SELECT id FROM sites WHERE id = %s", (review.site_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"Site ID {review.site_id} not found")

        # Optional: prevent multiple reviews by the same user for the same site
        cursor.execute("SELECT id FROM reviews WHERE user_id = %s AND site_id = %s", (review.user_id, review.site_id))
        if cursor.fetchone():
            raise HTTPException(status_code=409, detail="Review already exists for this user and site")

        # Insert review
        cursor.execute(
            "INSERT INTO reviews (user_id, site_id, rating, text) VALUES (%s, %s, %s, %s)",
            (review.user_id, review.site_id, review.rating, review.text)
        )
        conn.commit()
        return {"message": "Review submitted successfully"}
    finally:
        conn.close()        


#Get sites table
@app.get("/sites")
def read_sites():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SHOW TABLES")
    for table in cursor:
        print(table)

    # Execute a query
    cursor.execute("SELECT * FROM sites")#sites table

    # Fetch all rows
    rows = cursor.fetchall()

    # Print column names (optional)
    columns = [desc[0] for desc in cursor.description]

    result = [dict(zip(columns, row)) for row in rows]

    # Close connection   
    conn.close()
    return {"sites": result}

#Get top rated sites using reviews 
@app.get("/sites/top-rated")
def get_top_rated_sites():
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)

    query = """
        SELECT 
            s.id AS site_id,
            s.name,
            s.tourism,
            s.amenity,
            s.website,
            ROUND(AVG(r.rating), 2) AS average_rating,
            COUNT(r.id) AS total_reviews
        FROM sites s
        JOIN reviews r ON s.id = r.site_id
        WHERE s.deleted = FALSE
        GROUP BY s.id
        HAVING total_reviews > 0
        ORDER BY average_rating DESC
        LIMIT 10
    """
    cursor.execute(query)
    results = cursor.fetchall()

    for row in results:
        if row["website"]:
            row["website_link"] = f'<a href="{row["website"]}" target="_blank">{row["website"]}</a>'
        else:
            row["website_link"] = "Not available"

    conn.close()
    return {"top_rated_sites": results} 

#Get filtered sites   
@app.get("/sites/filter")
def filter_sites(
    tourism: Optional[str] = Query(None, description="Filter by tourism category"),
    amenity: Optional[str] = Query(None, description="Filter by amenity category")
):
    try:
        with get_connection() as conn:
            with conn.cursor(dictionary=True) as cursor:
                # Base query
                query = "SELECT * FROM sites WHERE deleted = FALSE"
                params = []

                if tourism:
                    query += " AND tourism = %s"
                    params.append(tourism)

                if amenity:
                    query += " AND amenity = %s"
                    params.append(amenity)

                cursor.execute(query, tuple(params))
                rows = cursor.fetchall()

        return {"filtered_sites": rows}

    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")   

#sites table (Access it with ID)   
@app.get("/sites/{site_id}")
def get_site_by_id(site_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM sites WHERE id = %s", (site_id,))
    row = cursor.fetchone()

    if row:
        columns = [desc[0] for desc in cursor.description]
        result = dict(zip(columns, row))
    else:
        result = {"message": f"Site with id {site_id} not found."}

    conn.close()
    return result

#Get sites table     
@app.get("/sites/{site_id}/websites/html")
def get_website_html(site_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT website FROM sites WHERE id = %s", (site_id,))
    row = cursor.fetchone()
    conn.close()

    if row and row[0]:
        website = row[0]
        html_link = f'<a href="{website}" target="_blank">{website}</a>'
        return {"site_id": site_id, "website_html": html_link}
    else:
        return {"site_id": site_id, "website_html": "Not available"}       


#Get users table
@app.get("/users")
def read_users():
    conn = get_connection()
    cursor = conn.cursor()  
    cursor.execute("SELECT * FROM users") 
    rows = cursor.fetchall() 
    # Print column names (optional)
    columns = [desc[0] for desc in cursor.description]

    result = [dict(zip(columns, row)) for row in rows]

    # Close connection   
    conn.close()
    return {"users": result}

#Get User table (Access it with ID)
@app.get("/users/{user_id}")
def get_user_by_id(user_id: int = Path(..., title="The ID of the user to retrieve")):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))
    row = cursor.fetchone()

    if row:
        columns = [desc[0] for desc in cursor.description]
        user_data = dict(zip(columns, row))
        result = {"user": user_data}
    else:
        result = {"message": f"User with ID {user_id} not found"}

    conn.close()
    return result


#Get favorites table
@app.get("/favorites")
def read_favorites():
    conn = get_connection()
    cursor = conn.cursor() 
    cursor.execute("SELECT * FROM favorites") 
    rows = cursor.fetchall() 
    # Print column names (optional)
    columns = [desc[0] for desc in cursor.description]

    result = [dict(zip(columns, row)) for row in rows]

    # Close connection   
    conn.close()
    return {"favorites": result} 

#Get favorites (using user_id)
@app.get("/favorites/{user_id}")
def get_user_favorites(user_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    query = """
        SELECT f.id AS favorite_id, f.site_id, s.name, s.website
        FROM favorites f
        JOIN sites s ON f.site_id = s.id
        WHERE f.user_id = %s
    """
    cursor.execute(query, (user_id,))
    rows = cursor.fetchall()
    columns = [desc[0] for desc in cursor.description]

    # Format result into desired structure
    favorites_list = [dict(zip(columns, row)) for row in rows]

    conn.close()
    return {
        "user_id": user_id,
        "favorites": favorites_list
    }

#Get reviews 
@app.get("/reviews")
def read_reviews():
    conn = get_connection()
    cursor = conn.cursor() 
    cursor.execute("SELECT * FROM reviews") 
    rows = cursor.fetchall() 
    # Print column names (optional)
    columns = [desc[0] for desc in cursor.description]

    result = [dict(zip(columns, row)) for row in rows]

    # Close connection   
    conn.close()
    return {"reviews": result}  

#Get reviews using site_id
@app.get("/reviews/site/{site_id}")
def get_site_reviews(site_id: int, current_user_id: int = Depends(get_current_user)):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    try:
        cursor.execute("SELECT id FROM sites WHERE id = %s AND deleted = FALSE", (site_id,))
        if not cursor.fetchone():
            raise HTTPException(status_code=404, detail=f"Site ID {site_id} not found")
        query = """
            SELECT r.id, r.user_id, u.name AS user_name, r.site_id, r.rating, r.text
            FROM reviews r
            JOIN users u ON r.user_id = u.id
            WHERE r.site_id = %s AND u.is_deleted = FALSE
        """
        cursor.execute(query, (site_id,))
        reviews = cursor.fetchall()
        return {"reviews": reviews}
    except mysql.connector.Error as e:
        raise HTTPException(status_code=500, detail=f"Database error: {str(e)}")
    finally:
        conn.close()
            
#reviews table(using site_id) 
@app.get("/reviews/{site_id}")
def get_reviews_by_site(site_id: int = Path(..., title="Site ID to retrieve reviews for")):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT * FROM reviews WHERE site_id = %s", (site_id,))
    rows = cursor.fetchall()

    if rows:
        columns = [desc[0] for desc in cursor.description]
        result = [dict(zip(columns, row)) for row in rows]
        conn.close()
        return {"reviews": result}
    else:
        conn.close()
        return {"message": f"No reviews found for site ID {site_id}"} 

#Delete favotites by using id
@app.delete("/favorites/{favorite_id}", status_code=200)
def delete_favorite(favorite_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id FROM favorites WHERE id = %s", (favorite_id,))
    favorite = cursor.fetchone()

    if not favorite:
        conn.close()
        raise HTTPException(status_code=404, detail=f"Favorite with ID {favorite_id} not found")

    cursor.execute("DELETE FROM favorites WHERE id = %s", (favorite_id,))
    conn.commit()
    conn.close()

    return {"message": f"Favorite deleted for ID {favorite_id}"}

#Delete the review by using id
@app.delete("/reviews/{review_id}", status_code=200)
def delete_review(review_id: int):
    conn = get_connection()
    cursor = conn.cursor()

    # Check if the review exists
    cursor.execute("SELECT id FROM reviews WHERE id = %s", (review_id,))
    review = cursor.fetchone()

    if not review:
        conn.close()
        raise HTTPException(status_code=404, detail=f"Review with ID {review_id} not found")

    # Delete the review
    cursor.execute("DELETE FROM reviews WHERE id = %s", (review_id,))
    conn.commit()
    conn.close()

    return {"message": f"Review deleted for ID {review_id}"}

#Put for review
@app.put("/reviews/users/{user_id}/sites/{site_id}", status_code=200)
def update_review(user_id: int, site_id: int, updated_review: ReviewUpdate):
    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT id FROM reviews WHERE user_id = %s AND site_id = %s", (user_id, site_id))
    review = cursor.fetchone()

    if not review:
        conn.close()
        raise HTTPException(status_code=404, detail=f"No review found for user_id={user_id} and site_id={site_id}")

    cursor.execute(
        "UPDATE reviews SET rating = %s, text = %s WHERE user_id = %s AND site_id = %s",
        (updated_review.rating, updated_review.text, user_id, site_id)
    )
    conn.commit()

    cursor.execute("SELECT * FROM reviews WHERE user_id = %s AND site_id = %s", (user_id, site_id))
    updated_row = cursor.fetchone()
    columns = [desc[0] for desc in cursor.description]
    updated_review_data = dict(zip(columns, updated_row))

    conn.close()
    return {
        "message": "Review updated successfully",
        "updated_review": updated_review_data
    }

#Update users using user_id
@app.put("/users/{user_id}", status_code=200)
def update_user(
    user_id: int,
    user_update: UserUpdate,
    current_user_id: int = Depends(get_current_user)
):
    if user_id != current_user_id:
        raise HTTPException(status_code=403, detail="Not authorized to update this user")

    with get_connection() as conn:
        with conn.cursor() as cur:
            # Check if user exists
            cur.execute("SELECT id FROM users WHERE id = %s", (user_id,))
            if not cur.fetchone():
                raise HTTPException(status_code=404, detail="User not found")

            # Optional: Ensure email isn't used by someone else
            if user_update.email:
                cur.execute("SELECT id FROM users WHERE email = %s AND id != %s", (user_update.email, user_id))
                if cur.fetchone():
                    raise HTTPException(status_code=409, detail="Email already used by another user")

            # Build update dynamically
            fields = []
            values = []

            if user_update.name is not None:
                fields.append("name = %s")
                values.append(user_update.name)
            if user_update.email is not None:
                fields.append("email = %s")
                values.append(user_update.email)
            if user_update.password is not None:
                # Hash the new password
                hashed_password = pwd_context.hash(user_update.password)
                fields.append("password_hash = %s")
                values.append(hashed_password)

            if not fields:
                raise HTTPException(status_code=400, detail="No fields provided for update")

            values.append(user_id)
            query = f"UPDATE users SET {', '.join(fields)} WHERE id = %s"
            cur.execute(query, values)
            conn.commit()

            # Return updated user
            cur.execute("SELECT * FROM users WHERE id = %s", (user_id,))
            row = cur.fetchone()
            columns = [desc[0] for desc in cur.description]
            user_data = dict(zip(columns, row))

    return {
        "message": "User updated successfully",
        "user": user_data
    }
