# What the progam does :
# Create a database with dummy data
# deploy it localy
# make a simple web app that connects to the database with
#  a search bar that takes user input and queries the database
# but a SQL injection vulnerability in the search bar
# and demonstrate how to exploit it
# and how to fix it

from flask import Flask, request, jsonify, render_template
import sqlite3
import os

app = Flask(__name__)

def get_db_connection():
    conn = sqlite3.connect('database.db')
    conn.row_factory = sqlite3.Row
    return conn

def initialize_db():
    if not os.path.exists("database.db"):  # Check if the database already exists
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Create table
        cursor.execute('''
            CREATE TABLE items (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                name TEXT NOT NULL,
                price INTEGER 
            )
        ''')
        
        # Insert sample data
        sample_data = [('Apple', 2.43), ('Banana', 1.39), ('Orange', 0.99), ('Grape', 1.83), ('Mango', 5.39)]
        cursor.executemany("INSERT INTO items (name, price) VALUES (?, ?)", sample_data)
        
         # Create users table
        cursor.execute('''
            CREATE TABLE users (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                username TEXT NOT NULL,
                email TEXT NOT NULL,
                password TEXT NOT NULL
            )
        ''')
        
        # Insert sample data into users table
        sample_users = [('admin', 'admin@example.com', 'FR2Z5x9n6h2ygP'), ('user1', 'user1@example.com', 'jc3RgHJ84nd27B'), ('user2', 'user2@example.com', 'd4n2B7jgH3J8cR')]
        cursor.executemany("INSERT INTO users (username, email, password) VALUES (?, ?, ?)", sample_users)

        conn.commit()
        conn.close()

@app.route('/search', methods=['POST'])
def search():
    data = request.get_json()
    query = data.get('query', '')
    security = data.get('security', False)

    if not query:
        return jsonify({"error": "Search query cannot be empty"}), 400
    
    conn = get_db_connection()
    cursor = conn.cursor()

    print(data)

    if security:
        # Secure query using parameterized queries (Protection against SQL Injection)
        # It uses precompiled sql request.
        cursor.execute("SELECT name, price FROM items WHERE name LIKE ?", (f"%{query}%",))
        results = cursor.fetchall()
    else:
        # Insecure query (Vulnerable to SQL Injection, do not use in production)
        insecure_query = f"SELECT name, price FROM items WHERE name LIKE '%{query}%'"
        cursor.execute(insecure_query)
        results = cursor.fetchall()
    
    conn.close()

    # for row in results:
    #     print(row)

    return jsonify({
        "mode": security,
        "results": [dict(row) for row in results],
    })

@app.route('/')
def base():
    return render_template('injection.html') 

if __name__ == '__main__':
    initialize_db()  # Populate the database at the start
    app.run(host="0.0.0.0", port=5000)