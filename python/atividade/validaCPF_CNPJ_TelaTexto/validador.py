def valida_cpf(num_cpf):
    if len(num_cpf)!=11:
        return False
    else:
        return True

def valida_cnpj(num_cnpj):
    if len(num_cnpj)!=14:
        return False
    else:
        return True