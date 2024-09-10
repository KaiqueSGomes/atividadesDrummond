num1=float(input("Insira o primeiro numero: "))
num2=float(input("Insira o segundo numero: "))

print("O que voce quer fazedr com esses numeros\nEscolha uma opção")

print("1 - Calcula a média entre os dois numeros")
print("2 - Calcula a diferenca entre os dois números")
print("3 - Calcula a multiplicacao dos dois numeros")
print("4 - Calcula a divisão entre os dois numeros")

opcao = input("Escolha sua opção")

match opcao:
    case "1" :
        media = (num1 + num2)/2 
        print(f"A média entre o {num1} e o {num2} é: {media}\n")
    case "2" :
        diferenca = num1-num2
        print(f"A diferenca entre o {num1} e o {num2} é: {diferenca}\n")
    case "3" :
        multiplicacao = num1*num2 
        print(f"A multiplicacao entre {num1} e o {num2} é: {multiplicacao}\n")
    case "4" :
        divisao = num1/num2 
        print(f"A divisao entre o {num1} e o {num2} é: {divisao}\n")
    case _:
        print("opcao invalida")