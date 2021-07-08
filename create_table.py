#!/usr/bin/python
import psycopg2
from config import config
from read_sql import read_sql

def create_tables():
    """ Connect to the PostgreSQL database server """
    conn = None

    commands = read_sql('schemas.sql')

    try:
        # read connection parameters
        params = config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
		
        # create a cursor
        cur = conn.cursor()
        
	# execute statements
        print("Creating tables...")
        for command in commands:
            cur.execute(command)

	# close the communication with the PostgreSQL
        cur.close()
    # commit the changes
        conn.commit()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')


if __name__ == '__main__':
    create_tables()
