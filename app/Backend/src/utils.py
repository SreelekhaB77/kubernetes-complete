import mysql.connector
import os

def get_db_connection():
    """Create and return a new database connection."""
    try:
        conn = mysql.connector.connect(
            host=os.getenv("DB_HOST", "db"),
            user=os.getenv("DB_USER", "appuser"),
            password=os.getenv("DB_PASS", "password"),
            database=os.getenv("DB_NAME", "appdb"),
            port=int(os.getenv("DB_PORT", 3306))
        )
        return conn
    except mysql.connector.Error as err:
        print(f"❌ Database connection failed: {err}")
        return None


def get_status_message():
    """Fetch a message from the MySQL 'status' table."""
    conn = get_db_connection()
    if not conn:
        return "Database connection failed!"

    try:
        cursor = conn.cursor()
        cursor.execute("SELECT message FROM status LIMIT 1;")
        row = cursor.fetchone()
        msg = row[0] if row else "No status message found."
        cursor.close()
        conn.close()
        return msg
    except mysql.connector.Error as err:
        return f"MySQL query error: {err}"
