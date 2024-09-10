num1=float(input("Insira o primeiro numero"))
num2=float(input("Insira o segundo numero"))
num3=float(input("Insira o terceiro numero"))

if num1 > num2 and num1 > num3 :
    maior = num1
elif num2 > num1 and num2 > num3 :
    maior = num2
elif num3 > num1 and num3 > num2 :
    maior = num3

if num1 < num2 and num1 < num3 :
    menor = num1
elif num2 < num1 and num2 < num3 :
    menor = num2
elif num3 < num1 and num3 < num2 :
    menor = num3

if num1 > menor and num1 < maior:
    meio = num1
elif num2 > menor and num2 < maior:
    meio = num2
elif num3 > menor and num3 < maior:
    meio = num3

print(menor, meio, maior)