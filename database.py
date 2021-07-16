#!/usr/bin/python

import psycopg2
from config import config
from read_sql import read_sql

"""Essa e a biblioteca onde estão as funcoes que conversam diretamente
com a biblioteca psycopg2, que executa o sql embutido no python"""


def inserir_turista(passaporte, nome, data_nascimento, telefone=None):

    sql = """INSERT INTO turista(passaporte,nome,data_nascimento,telefone)
                VALUES(%s,%s,%s,%s);"""
    conn = None
    erro = 0
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (passaporte, nome.upper(), data_nascimento, telefone))
        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print("ERRO", error)
        erro = 1
    finally:
        if conn is not None:
            conn.close()
    return erro

def inserir_avaliacao(passaporte, restaurante, nota):

    sql = """INSERT INTO avaliacao(turista,restaurante,nota)
                VALUES(%s,%s,%s);"""
    conn = None
    erro = 0
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (passaporte,restaurante,nota))
        conn.commit()
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print("ERRO", error)
        erro = 1
    finally:
        if conn is not None:
            conn.close()
    return erro

def consultar_pais():
    sql = """SELECT nome_pais FROM pais"""
    conn = None
    pais = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql)
        row = cur.fetchone()

        while row is not None:
            pais.append(row[0])
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return pais

def consultar_turista(passaporte):
    sql = """SELECT nome FROM turista WHERE passaporte = %s"""
    conn = None
    nome = None
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (passaporte,))
        nome = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return nome

def consultar_cozinha():
    sql = """SELECT DISTINCT tipo_cozinha FROM cozinha"""
    conn = None
    cozinha = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql)
        row = cur.fetchone()

        while row is not None:
            cozinha.append(row[0])
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return cozinha

def consultar_parque(pais):
    sql = """SELECT documento, nome FROM parque_tematico WHERE pais=%s"""

    conn = None
    parque = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (pais,))
        row = cur.fetchone()

        while row is not None:
            parque.append(row)
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return parque

def consultar_restaurante(parque):
    sql = """SELECT documento, nome FROM restaurante WHERE parque=%s"""

    conn = None
    restaurante = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (parque,))
        row = cur.fetchone()

        while row is not None:
            restaurante.append(row)
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return restaurante

def consultar_avaliacoes(parque, cozinha):
    sql= """SELECT
                restaurante.documento,
                restaurante.nome,
                restaurante.tipo_cozinha,
                AVG(a.nota)::NUMERIC(2,1)
            FROM(
                SELECT 
                rest_by_pais.parque, rest_by_pais.documento, rest_by_pais.nome, c.tipo_cozinha
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
    avaliacao = []
    try:
        params = config()
        conn = psycopg2.connect(**params)
        cur = conn.cursor()
        cur.execute(sql, (parque,cozinha))
        row = cur.fetchone()

        while row is not None:
            avaliacao.append(row)
            row = cur.fetchone()

        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()

    return avaliacao