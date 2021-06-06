a = int(input('Digite o valor de A:'))
b = int(input('Digite o Valor de B:'))
soma = a + b
subtracao = a - b
divisao = a / b
multiplicacao = a * b

print('Soma: {soma}. \nSubtração: {subtracao}.'
       '\nDivisão: {divisao} '
       '\nMultiplicação: {multiplicacao}' .format(soma=soma,
                                                  subtracao=subtracao,
                                                  multiplicacao=multiplicacao,
                                                  divisao=divisao))