from validador import valida_cpf, valida_cnpj

if __name__ == '__main__':
    cpf=input("Digite seu cpf com 11 digitos:")
    if valida_cpf(cpf):
        print(f"O numero de cpf {cpf} é válido.")
    else:
        print(f"O numero de cpf {cpf} é INVÁLIDO!")

    cnpj= input("Digite o cnpj com 1e digitos:")
    if valida_cnpj(cnpj):
        print(f"O numero de cnpj {cnpj} é válido.")
    else:
        print(f"O numero de cnpj {cnpj} é INVÁLIDO!")