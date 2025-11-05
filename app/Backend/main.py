from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector
import os

app = Flask(__name__)
CORS(app)

@app.route("/")
def home():
    return jsonify({"message": "Backend connected successfully!"})

@app.route("/api/hello")
def api_hello():
    return jsonify({"message": "Hello from Flask backend!"})

@app.route("/db")
def db_test():
    try:
        conn = mysql.connector.connect(
            host=os.getenv("DB_HOST", "db"),
            user=os.getenv("DB_USER", "root"),
            password=os.getenv("DB_PASSWORD", "password"),
            database=os.getenv("DB_NAME", "app_db")
        )
        cursor = conn.cursor()
        cursor.execute("SELECT DATABASE();")
        data = cursor.fetchone()
        cursor.close()
        conn.close()
        return jsonify({"connected_to": data[0]})
    except Exception as e:
        return jsonify({"error": str(e)})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

