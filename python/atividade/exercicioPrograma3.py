print("\nBem vindo ao interrogatório sobre a morte de joao banana...\n")
print("Responda 5 perguntas rápidas!\n")

quest1 = input("TELEFONOU PARA A VÍTIMA?\n")
quest2 = input("ESTEVE NO LOCAL DO CRIME?\n")
quest3 = input("MORA PERTO DA VÍTIMA\n")
quest4 = input("DEVIA PARA A VÍTIMA?\n")
quest5 = input("JÁ TRABALHOU COM A VÍTIMA\n")
contagem = 0

match quest1 :
    case "sim" :
        contagem = contagem + 1
match quest2 :
    case "sim" :
        contagem = contagem + 1
match quest3 :
    case "sim" :
        contagem = contagem + 1
match quest4 :
    case "sim" :
        contagem = contagem + 1
match quest5 :
    case "sim" :
        contagem = contagem + 1

if contagem < 2 :
    print("Você é inocente!!")
elif contagem == 2 :
    print("Você é suspeito(a)!!")
elif contagem < 5 :
    print("Você é cúmplice!!")
elif contagem == 5 :
    print("Você é o(a) assassino(a)!")