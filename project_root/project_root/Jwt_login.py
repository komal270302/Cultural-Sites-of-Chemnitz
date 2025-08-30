from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from pydantic import BaseModel
from passlib.context import CryptContext
from jose import JWTError, jwt
from datetime import datetime, timedelta
import mysql.connector

# Router
router = APIRouter(prefix="/auth")

# JWT Config
SECRET_KEY = "your-secret-key"
ALGORITHM = "HS256"
ACCESS_TOKEN_EXPIRE_MINUTES = 60

# Password hashing
pwd_context = CryptContext(schemes=["bcrypt"])
oauth2_scheme = OAuth2PasswordBearer(tokenUrl="/auth/login")

# Database connection
def get_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='cultural_sites_db'
    )

# Utility functions
def hash_password(password: str):
    return pwd_context.hash(password)

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)

def create_access_token(data: dict, expires_delta: timedelta = None):
    to_encode = data.copy()
    expire = datetime.utcnow() + (expires_delta or timedelta(minutes=ACCESS_TOKEN_EXPIRE_MINUTES))
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT is_admin FROM users WHERE id = %s", (data["sub"],))
    is_admin_row = cursor.fetchone()
    conn.close()
    is_admin = is_admin_row[0] if is_admin_row else False
    to_encode.update({"exp": expire, "is_admin": is_admin})
    return jwt.encode(to_encode, SECRET_KEY, algorithm=ALGORITHM)

def decode_token(token: str):
    try:
        payload = jwt.decode(token, SECRET_KEY, algorithms=[ALGORITHM])
        return payload.get("sub")
    except JWTError:
        return None

def get_current_user(token: str = Depends(oauth2_scheme)):
    user_id = decode_token(token)
    if not user_id:
        raise HTTPException(status_code=401, detail="Invalid or expired token")
    return int(user_id)

def get_current_admin(token: str = Depends(oauth2_scheme)):
    user_id = decode_token(token)
    if not user_id:
        raise HTTPException(status_code=401, detail="Invalid or expired token")

    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT is_admin FROM users WHERE id = %s", (user_id,))
    row = cursor.fetchone()
    conn.close()

    if not row or row[0] != 1:
        raise HTTPException(status_code=403, detail="Admin privileges required")
    return int(user_id)

# Pydantic Models
class UserLogin(BaseModel):
    email: str
    password: str

class UserRegister(BaseModel):
    name: str
    email: str
    password: str

@router.post("/register")
def register(user: UserRegister):
    conn = get_connection()
    cursor = conn.cursor()

    # Check if any admin exists
    cursor.execute("SELECT COUNT(*) FROM users WHERE is_admin = 1")
    is_admin = cursor.fetchone()[0] == 0

    # Check for duplicate email
    cursor.execute("SELECT id FROM users WHERE email = %s", (user.email,))
    if cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=400, detail="Email already registered")

    # Insert new user
    hashed_pw = hash_password(user.password)
    cursor.execute(
        "INSERT INTO users (name, email, password_hash, is_admin) VALUES (%s, %s, %s, %s)",
        (user.name, user.email, hashed_pw, is_admin)
    )
    conn.commit()
    conn.close()

    return {"message": "User registered successfully", "is_admin": is_admin}

@router.post("/login")
def login(user: UserLogin):
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT id, password_hash FROM users WHERE email = %s", (user.email,))
    db_user = cursor.fetchone()
    conn.close()

    if not db_user or not verify_password(user.password, db_user[1]):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    user_id = db_user[0]
    token = create_access_token(data={"sub": str(user_id)})
    return {"access_token": token, "token_type": "bearer"}

@router.get("/users/me")
def read_users_me(current_user: int = Depends(get_current_user)):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name, email, is_admin FROM users WHERE id = %s", (current_user,))
    user = cursor.fetchone()
    conn.close()

    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    return user

@router.get("/admin/users")
def get_users(admin_user: int = Depends(get_current_admin)):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name, email, is_admin FROM users WHERE is_deleted = FALSE")

    users = cursor.fetchall()
    conn.close()
    return users

@router.get("/admin/stats")
def get_stats(admin_user: int = Depends(get_current_admin)):
    conn = get_connection()
    cursor = conn.cursor()
    # Count active users
    cursor.execute("SELECT COUNT(*) FROM users WHERE is_deleted = FALSE")
    active_users = cursor.fetchone()[0]

    # Count deleted users
    cursor.execute("SELECT COUNT(*) FROM users WHERE is_deleted = TRUE")
    deleted_users = cursor.fetchone()[0]


    cursor.execute("SELECT COUNT(*) FROM sites")
    sites = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM reviews")
    reviews = cursor.fetchone()[0]

    cursor.execute("SELECT COUNT(*) FROM favorites")
    favorites = cursor.fetchone()[0]

    conn.close()
    return {
        "active_users": active_users,
        "deleted_users": deleted_users,
        "sites": sites,
        "reviews": reviews,
        "favorites": favorites
    }

@router.put("/admin/deactivate_user/{user_id}")
def deactivate_user(user_id: int, admin_user: int = Depends(get_current_admin)):
    conn = get_connection()
    cursor = conn.cursor()

    # Make sure the user exists and is not already deleted
    cursor.execute("SELECT id FROM users WHERE id = %s AND is_deleted = FALSE", (user_id,))
    if not cursor.fetchone():
        conn.close()
        raise HTTPException(status_code=404, detail="User not found or already deactivated")

    # Prevent admin from deactivating themselves
    if admin_user == user_id:
        conn.close()
        raise HTTPException(status_code=400, detail="Admin cannot deactivate themselves")

    cursor.execute("UPDATE users SET is_deleted = TRUE WHERE id = %s", (user_id,))
    conn.commit()
    conn.close()

    return {"message": f"User {user_id} has been deactivated (soft-deleted)"}

@router.get("/admin/deleted_users")
def get_deleted_users(admin_user: int = Depends(get_current_admin)):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT id, name, email, is_admin FROM users WHERE is_deleted = TRUE")
    users = cursor.fetchall()
    conn.close()
    return users


