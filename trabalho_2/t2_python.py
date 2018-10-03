# funcao que calcula o mdc de dois numeros
def mdc(num1, num2):
    num1 = num1
    num2 = num2
    # testa a condicao de erro
    if (int(num1) < 2 or int(num2) < 2):
        # retorna -1 para ficar claro que deu erro
        return -1
    else:
        if (int(num1) > int(num2)):
            divisor, dividendo = num1, num2
        else:
            divisor, dividendo = num2, num1

        while (dividendo != 0):
            resto = int(divisor) % int(dividendo)
            divisor = dividendo
            dividendo = resto
        
        return divisor

def mmc(num1, num2, mdc):
    return int(num1) * (int(num2) / mdc)

num1 = input ()
num2 = input ()

resultado_mdc = mdc(num1, num2)

print('========')
if (int(resultado_mdc) >= 0):
    print (f"MDC: {resultado_mdc}")
    print (f"MDC: {mmc(num1, num2, resultado_mdc)}")
else:
    print("Entrada invalida")