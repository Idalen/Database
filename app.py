import connect

print("""Bem vindo à aplicação!""")

conn = connect.connect_postgres()

print(conn)
