import os
import sqlite3

# Connect to the database
conn = sqlite3.connect('termux_directories.db')

# Create a cursor object
c = conn.cursor()

# Create a table for the directory information
c.execute('''CREATE TABLE directories (id INTEGER PRIMARY KEY, name TEXT, path TEXT)''')

# Iterate through the directories and subdirectories in Termux
for dirpath, dirnames, filenames in os.walk('./'):
    for name in dirnames + filenames:
        path = os.path.join(dirpath, name)
        # Insert the file and directory information into the table
        c.execute('INSERT INTO directories (name, path) VALUES (?, ?)', (name, path))

# Commit the changes to the database
conn.commit()

# Close the connection to the database
conn.close()
