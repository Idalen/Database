#!/usr/bin/python

import psycopg2
from config import config
from read_sql import read_sql

def inserir(passaporte, nome, data_nascimento, telefone=None):

    sql = """INSERT INTO turista(passaporte,nome,data_nascimento,telefone)
                VALUES(%s,%s,%s,%s);"""
    conn = None
    erro = 0
    try:
        # read database configuration
        params = config()
        # connect to the PostgreSQL database
        conn = psycopg2.connect(**params)
        # create a new cursor
        cur = conn.cursor()
        # execute the UPDATE  statement
        cur.execute(sql, (passaporte, nome, data_nascimento, telefone))
        # get the number of updated rows
        conn.commit()
        # Close communication with the PostgreSQL database
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print("ERRO", error)
        erro = 1
    finally:
        if conn is not None:
            conn.close()
    return erro

def consultar(pais='ARGENTINA'):
    sql= """SELECT
                restaurante.documento,
                restaurante.nome,
                restaurante.tipo_cozinha,
                AVG(a.nota)::NUMERIC(2,1)
            FROM(
                SELECT 
                rest_by_pais.parque, rest_by_pais.nome, c.tipo_cozinha
                FROM(
                    SELECT r.documento AS documento, p.nome AS parque, r.nome AS nome
                    FROM parque_tematico p
                    INNER JOIN restaurante r
                        ON p.documento = r.parque
                    WHERE p.documento = %s
                )rest_by_pais INNER JOIN cozinha c
                    ON rest_by_pais.documento = c.restaurante
                WHERE c.tipo_cozinha = %s
            )restaurante LEFT OUTER JOIN avaliacao a
                ON a.restaurante = restaurante.documento
            GROUP BY 
                restaurante.documento,
                restaurante.nome, 
                restaurante.tipo_cozinha
            ORDER BY AVG(a.nota);"""
    conn = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (12345678911,'ITALIANA'))
        print("The number of parts: ", cur.rowcount)
        row = cur.fetchone()

        while row is not None:
            print(row)
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()