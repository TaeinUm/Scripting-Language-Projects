import sqlite3

# Connect to the database. If it doesn't exist, it will be created.
conn = sqlite3.connect('movies.sqlite')

# Create a cursor object using the cursor() method
cursor = conn.cursor()

# Create tables
cursor.execute('''CREATE TABLE Category (
                    categoryID INTEGER PRIMARY KEY AUTOINCREMENT,
                    name TEXT NOT NULL)''')

cursor.execute('''CREATE TABLE Movie (
                    movieID INTEGER PRIMARY KEY AUTOINCREMENT,
                    categoryID INTEGER NOT NULL,
                    name TEXT NOT NULL,
                    year INTEGER NOT NULL,
                    minutes INTEGER NOT NULL,
                    FOREIGN KEY (categoryID) REFERENCES Category (categoryID))''')

# Insert sample categories
categories = [('Animation',), ('Comedy',), ('Drama',)]
cursor.executemany('INSERT INTO Category (name) VALUES (?)', categories)

# Insert sample movies
movies = [
    (1, 'Ice Age', 2002, 81),
    (1, 'Toy Story', 1995, 81),
    (1, 'Spirit: Stallion of the Cimarron', 2002, 83),
    (1, 'Aladdin', 1992, 90),
    (2, 'Monty Python and the Holy Grail', 1975, 91),
    (2, 'Monty Python\'s Life of Brian', 1979, 94)
]

cursor.executemany('INSERT INTO Movie (categoryID, name, year, minutes) VALUES (?, ?, ?, ?)', movies)

# Commit the changes
conn.commit()

# Close the database connection
conn.close()

print('Database and sample data created successfully.')
