import database as db


def format_line(index, words):
    ret = ''
    length = 30
    for i in range(len(index)):
        string = str(index[i])+'- '+ words[i]
        for x in range(length - len(string)):
            string+=(" ")
        ret+=string

    return ret
        
def print_format_line(elements):
    words = []
    index = []
    for i in range(len(elements)):
        words.append(elements[i])
        index.append(i)
        if (i+1)%3 == 0:
            print(format_line(index, words))
            words = []
            index = []
    print(format_line(index, words))
    words = []
    index = []


user = 12345678900
user_name = None

print("""
 ____    ____                                                  _____      ________ 
|    \  |       |\    /|         \          /   |   |\     |  |     \    |        | 
|    |  |       | \  / |          \        /    |   | \    |  |      \   |        |
|____/  |----   |  \/  |   ---     \      /     |   |  \   |  |       |  |        |
|    \  |       |      |            \    /      |   |   \  |  |       |  |        |
|    |  |       |      |             \  /       |   |    \ |  |      /   |        | 
|____/  |____   |      |              \/        |   |     \|  |____ /    |________|  
""")

while True:
    func = int(input("""Qual das funcinalidades a seguir você quer executar?
    1- CADASTRAR TURISTA
    2- LOGAR COM SEU PASSAPORTE
    3- AVALIAR RESTAURANTE
    4- CONSULTAR RESTAURANTES MAIS BEM AVALIADOS
    5- SAIR DO SISTEMA
    """))
    print("\n")
    if func == 1:
    
        passaporte = input("Informe seu passaporte:")
        nome = input("Informe seu nome:")
        data_nascimento = input("Informe sua data de nascimento (yyyy-mm-dd):")
        telefone = input("Informe seu telefone:")

        if not db.inserir_turista(passaporte, nome, data_nascimento, telefone):
            print(f"{nome} ({passaporte}) foi adicionado ao banco.")
        print('\n')

    elif func == 2:
        if user != None:
            print(f"Voce ja esta logado no sistema, {user_nome}")
        else:
            user = input('Insira seu passaporte para logar no sistema:')

            user_nome = db.consultar_turista(user)

            if user_nome == None:
                user = None
                print('Erro: passaporte incorreto')
            else:
                user_nome = user_nome[0]
                print(f'Que bom que voltou, {user_nome}')

            print(' ')

    elif func == 3:
        if user == None:
            print('Você precisa está logado para avaliar restaurantes!')
        else:
            pais = db.consultar_pais()
            print_format_line(pais)

            p = int(input('Escolha o país onde seu parque se encontra: '))
            print("\n")

            parque = db.consultar_parque(pais[p])
            parque_doc, parque_nome =  map(list,zip(*parque))
            print_format_line(parque_nome)
            p = int(input('Escolha o parque onde você está:'))
            print("\n")

            restaurante = db.consultar_restaurante(parque_doc[p])
            restaurante_doc, restaurante_nome =  map(list,zip(*restaurante))
            print(restaurante_doc)
            print_format_line(restaurante_nome)   
            r = int(input('Escolha o restaurante que voce quer avaliar:'))
            n = int(input('Escolha sua nota para o resturante (entre 0 e 5):'))      

            db.inserir_avaliacao(user,restaurante_doc[r],n) 

            print(f'Voce avaliou {restaurante_doc[r]} com {n} estrelas!')  
            print('\n')


    elif func == 4:
        
        pais = db.consultar_pais()
        print_format_line(pais)
            
        p = int(input('Escolha o país onde seu parque se encontra: '))
        print("\n")

        parque = db.consultar_parque(pais[p])
        parque_doc, parque_nome =  map(list,zip(*parque))
        print_format_line(parque_nome)
        p = int(input('Escolha o parque onde você está:'))
        print("\n")

        cozinha = db.consultar_cozinha()
        print_format_line(cozinha)
        c = int(input('Escolha o tipo de comida oferecido:'))
        print("\n")

        avaliacao = db.consultar_avaliacoes(parque_doc[0], cozinha[c])
        print(f"NOTAS MEDIAS DOS RESTAURANTES COM COMIDA {cozinha[c].upper()}:")
        if(not avaliacao):
            print("Não há restaurantes com essas caracteristicas nesse parque.")
        else:    
            for a in avaliacao:
                if a[3] == None:
                    print(f"{a[1]} --> NAO AVALIADO")
                else:
                    print(f"{a[1]} --> NOTA: {float(a[3])} ESTRELAS")
    elif func == 5:
        print("Saindo do sistema...\n")
        break;