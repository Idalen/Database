#!/usr/bin/python
import psycopg2
from config import config
from read_sql import read_sql

def connect_postgres():
    """ Connect to the PostgreSQL database server """
    conn = None

    try:
        # read connection parameters
        params = config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
		
        # create a cursor
    except Exception as err:
        print ("PostgreSQL Connect() ERROR:", err)
        conn = None

    return conn
