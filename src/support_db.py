# Database Connection and Operations
# -----------------------------------------------------------------------
import psycopg2
from psycopg2 import OperationalError, errorcodes


def sql_query(query: str):
    """
    Executes a given SQL query on a PostgreSQL database and retrieves all results along with column names.

    Parameters:
    - query (str): The SQL query to be executed on the database.

    Returns:
    - result (tuple): A tuple containing:
        - data (list of tuples): The query results.
        - columns (list of str): The column names from the query.
    """
    result = None
    columns = None
    connection = None

    try:
        # Establish the connection
        connection = psycopg2.connect(
            database='streaming_project',
            user='my_user',
            password='admin',
            host='localhost',
            port='5432'
        )

        # Query execution
        with connection.cursor() as cursor:
            cursor.execute(query)
            result = cursor.fetchall()  # Retrieve all data
            columns = [desc[0] for desc in cursor.description]  # Get column names

        print("Query performed successfully.")

    except OperationalError as e:
        if e.pgcode == errorcodes.INVALID_PASSWORD:
            print('Incorrect password')
        elif e.pgcode == errorcodes.CONNECTION_EXCEPTION:
            print('Connection error')
        elif e.pgcode == errorcodes.INVALID_CATALOG_NAME:
            print('Database does not exist')
        else:
            print(f"Database error: {e}")

    except Exception as e:
        print(f"Unexpected error: {e}")

    finally:
        # Closing connection
        if connection:
            try:
                connection.close()
                print("Database connection closed.")
            except Exception as e:
                print(f"Error closing connection: {e}")

    return result, columns