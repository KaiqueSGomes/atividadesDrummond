print("Insira o valor do seu salário BRUTO para calcular o IRPF:")
salario = float(input(""))

if salario <= 2259.20 :
    print("Seu salário não tem descontos!")
elif salario <= 2826.65 :
    calculo = (salario * 0.075) - 169.44
    final = salario - calculo
    print(f"o seu salário de R$ {salario:.2f} sofre uma retenção mensal de {calculo:.2f}, chegando em {final:.2f}.")
elif salario <= 3751.05 :
    calculo = (salario * 0.15) - 381.44
    final = salario - calculo
    print(f"o seu salário de R$ {salario:.2f} sofre uma retenção mensal de {calculo:.2f}, chegando em {final:.2f}.")
elif salario <= 4664.68 :
    calculo = (salario * 0.225) - 662.77
    final = salario - calculo
    print(f"o seu salário de R$ {salario:.2f} sofre uma retenção mensal de {calculo:.2f}, chegando em {final:.2f}.")
elif salario > 4664.68:
    calculo = (salario * 0.275) - 896
    final = salario - calculo
    print(f"o seu salário de R$ {salario:.2f} sofre uma retenção mensal de {calculo:.2f}, chegando em {final:.2f}.")

