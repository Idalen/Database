import database as db
import datetime

print("""Bem vindo à aplicação!\n""")

func = int(input("""Qual das funcinalidades a seguir você quer executar?
1- INSERIR
2- CONSULTAR RESTAURANTES MAIS BEM AVALIADOS
    """))
if func == 1:
    passaporte = input("Informe seu passaporte:")
    nome = input("Informe seu nome:")
    data_nascimento = input("Informe sua data de nascimento (yyyy-mm-dd):")
    telefone = input("Informe seu telefone:")

    if not db.inserir(passaporte, nome, data_nascimento, telefone):
        print(f"{nome} ({passaporte}) foi adicionado ao banco.")
elif func == 2:
    pais = db.consultar_pais()
    for i in range(len(pais)):
        print(f'{i}- {pais[i]}')
    p = int(input('Escolha o país onde seu parque se encontra: '))

    parque = db.consultar_parque(pais[p])
    for i in range(len(parque)):
        print(f'{i}- {parque[i][1]}')
    p = int(input('Escolha o parque onde você está:'))

    cozinha = db.consultar_cozinha()
    for i in range(len(cozinha)):
        print(f'{i}- {cozinha[i]}')
    c = int(input('Escolha o tipo de comida oferecido:'))

    avaliacao = db.consultar(parque[p][0], cozinha[c])
    print(f"NOTAS MEDIAS DOS RESTAURANTES COM COMIDA {cozinha[c].upper()}:")
    if(not avaliacao):
        print("Não há restaurantes com essas caracteristicas nesse parque.")
    else:    
        for a in avaliacao:
            if a[3] == None:
                print(f"{a[1]} --> NAO AVALIADO")
            else:
                print(f"{a[1]} --> NOTA: {float(a[3])} ESTRELAS")