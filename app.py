import database as db
import datetime

print("""Bem vindo à aplicação!\n""")

# passaporte = input("Informe seu passaporte:")
# nome = input("Informe seu nome:")
# data_nascimento = input("Informe sua data de nascimento (yyyy-mm-dd):")
# telefone = input("Informe seu telefone:")

# passaporte = 12345678998
# nome = 'MARCOS'
# data_nascimento = datetime.date(2000,6,17)
# telefone = '(73)999980423'

# if not db.inserir(passaporte, nome, data_nascimento, telefone):
#     print(f"{nome} ({passaporte}) foi adicionado ao banco.")

db.consultar()
