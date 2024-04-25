# Movie List Program
This directory contains the implementation for the Movie List application. This program provides a command-line interface to manage a movie database.


## Features
- Add new movies to the collection with details such as name, year, and runtime.
- View movies by category or year.
- Delete movies from the collection.
- Filter and view movies with a runtime less than a specified number of minutes.


## Structure
- `db.py`: Contains all the database operations such as connecting to the SQLite database, and CRUD (Create, Read, Update, Delete) operations for movies.
- `objects.py`: Defines the `Movie` and `Category` classes used to represent the data.
- `ui.py`: Handles the user interface and interaction with the program.
- `data.py`: Creates a sampele data to test the code.


## Getting Started
To run the Movie List program, make sure you have Python installed on your system and follow these steps:

1. Clone the repository and navigate to the `Problem1` directory.
2. Run the program using Python:

```bash
python3 data.py
python3 ui.py
```

3. Follow the on-screen prompts to interact with the movie database.


## Dependencies
- Python 3.x
- SQLite 3.x
