print("--------------------------------------------------")
print("- Codigo -     Produto     - Preço unitário (R$) -")
print("--------------------------------------------------")
print("- 100    - Cachorro quente - R$ 1,70             -")
print("- 101    - Baurú simples   - R$ 2,30             -")
print("- 102    - Baurú com ovo   - R$ 2,60             -")
print("- 103    - Hambúrguer      - R$ 2,40             -")
print("- 104    - Cheeseburguer   - R$ 2,50             -")
print("- 105    - Refrigerante    - R$ 1,00             -")
print("--------------------------------------------------")

valor100 = 1.70
valor101 = 2.30
valor102 = 2.60
valor103 = 2.40
valor104 = 2.50
valor105 = 1.00

opcao = input("Escolha uma opção: ")

match opcao:
    case "100" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor100 * quantidade
        print(f"Você comprou {quantidade} cachorros quentes, valor: R$ {total:.2f}.\n")
    case "101" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor101 * quantidade
        print(f"Você comprou {quantidade} Baurús simples, valor: R$ {total:.2f}.\n")
    case "102" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor102 * quantidade
        print(f"Você comprou {quantidade} Baurús com ovo, valor: R$ {total:.2f}.\n")
    case "103" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor103 * quantidade
        print(f"Você comprou {quantidade} Hambúrguers, valor: R$ {total:.2f}.\n")
    case "104" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor104 * quantidade
        print(f"Você comprou {quantidade} Cheeseburguers, valor: R$ {total:.2f}.\n")
    case "105" :
        quantidade = int(input("Escolha a quantidade: "))
        total = valor105 * quantidade
        print(f"Você comprou {quantidade} Refrigerantes, valor total de R$ {total:.2f}.\n")
    case _ :
        print("Insira um código válido!")


print("Qual a forma de pagamento? ")
print(f"1 - Pagamento a vista (Debito/Dinheiro) - Desconto de 5% ")
print(f"2 - Pagamento a vista via PIX   - Desconto de 8% ")
print(f"3 - Pagamento em 3x - Sem juros")
print(f"4 - Pagamentos com 4 ou mais parcelas (máximo 10x) Juros 2% ao mês\n")

pagamento = input("")

match pagamento :
    case "1" :
        final = total * 0.95
        print(f"Você recebeu 5% de desconto por ter pago no dinheiro, o valor final foi de R$ {final:.2f}")
    case "2" :
       final = total * 0.92
       print(f"Você recebeu 8% de desconto por ter pago no dinheiro, o valor final foi de R$ {final:.2f}") 
    case "3" :
        print(f"Você não terá desconto e nem pagará juros, o valor final se mantém R$ {total:.2f}")
    case "4" :
        juros = input("Em quantas vezes? (max 10x)")
        match juros :
                case "1" :
                    print(f"até 3 vezes voce não paga juros e o valor se mantém R$ {total:.2f}")
                case "2" :
                    print(f"até 3 vezes voce não paga juros e o valor se mantém R$ {total:.2f}")
                case "3" :
                    print(f"até 3 vezes voce não paga juros e o valor se mantém R$ {total:.2f}")
                case "4" :
                    final = total * 1.02
                    print(f"Você vai pagar 2% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "5" :
                    final = total * 1.04
                    print(f"Você vai pagar 4% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "6" :
                    final = total * 1.06
                    print(f"Você vai pagar 6% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "7" :
                    final = total * 1.08
                    print(f"Você vai pagar 8% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "8" :
                    final = total * 1.1
                    print(f"Você vai pagar 10% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "9" :
                    final = total * 1.12
                    print(f"Você vai pagar 12% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
                case "10" :
                    final = total * 1.14
                    print(f"Você vai pagar 14% de juros por estar pagando em 4x no crédito, e o valor final será R$ {final:.2f}")
