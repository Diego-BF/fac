# Trabalho 03 de FAC
# Cálculo do Arco da Cotangente de um número Real maior que 0
# Será resolvida utilizando o Arco da Tangente


.data	

	entradaX:  .float  			# Variavel de Entrada
	arctan:    .float  			# Valor do Arco Tangente
	arccotg:   .float  			# Valor do Arco Cotangente
	resultadoTemp: .float  			# Resultado temporario da parcela
	resultadoFinal: .float			# Resultado final da parcela
	fatorCorrecao: .float 1.57079632679 	# pi/2 fator de correção para arco de cotangente
	stringEntrada: .asciiz "Entre com o Valor de X: \n"
	stringInvalida: .asciiz "Entrada Inválida. \n"
	valorCotangente: .asciiz "O valor do Arco Cotangente é: \n"
	valorZero: .float 0
	valorUnitario: .float 1
	
.text


main:
	# le um numero float
	li $v0, 6
	syscall
	
	mov.s $f2, $f0 
	
	# O registrador f3 será usado para comparações do if/else
	l.s $f3, valorZero
	c.lt.s $f2, $f3
	bc1t entradaInvalida
	
	l.s $f3, valorUnitario
	c.lt.s $f2, $f3
	bc1f calculaArctanMaior1
	j calculaArctanMenor1
	

	
calculaArctanMenor1:
	
	li $t1, 1						# valor inicial do contador do Indice
	li $t2, 23					# valor final do contador do Indice
	li $t3, 1						# valor do contador do sinal
	
	
	loopArcTan:
	bgt $t1, $t2, retornaValorCotangMenor1 		# Criterio arbitrario de parada do loop de termos
	beq $t3, 1, calculaTermoSomaPart1				# Comparação que decide se soma ou subtrai o termo
	# jal calculaTermoSubtracaoPart1  TODO
	j loopArcTan




calculaTermoSomaPart1:
	j powSoma  # Apenas somando a função de exponencial
		

calculaTermoSomaPart2:
	div.s $f12, $f11, $t1						# Divide o resultado da exponencial pelo indice correspondente
	add.s $f15, $f15, $f12					# salva em f15 o valor do termo
	subi $t3, $t3, 1								# alterna o valor da variavel que controla o valor do termo
	addi $t1, $t1, 2								# Incrementa o contador do LoopArcTan
	j loopArcTan										# Volta para loopArcTan
	
powSoma:
	li $t4, 1										# contador da exponenciacao
	add.s $f10, $f3, $f2 				# salvando o valor inicial em f10
	
	exponenciacaoSoma:
	bgt $t4, $t1, calculaTermoSomaPart2						# quando t4 atingir t1 voltara para calculaTermoSoma
	mul.s $f11, $f11, $f10												# realiza a exponenciacao salvando em f11 o resultado 
	addi $t4, $t4, 1															# Soma 1 ao contador da exponenciacao
	j	exponenciacaoSoma





calculaTermoSubPart1:
	j powSub  # Apenas somando a função de exponencial
		

calculaTermoSubPart2:
	div.s $f12, $f11, $t1						# Divide o resultado da exponencial pelo indice correspondente
	sub.s $f15, $f15, $f12					# salva em f15 o valor do termo
	addi $t3, $t3, 1								# alterna o valor da variavel que controla o valor do termo
	addi $t1, $t1, 2								# Incrementa o contador do LoopArcTan
	j loopArcTan										# Volta para loopArcTan
	
powSub:
	li $t4, 1										# contador da exponenciacao
	add.s $f10, $f3, $f2 				# salvando o valor inicial em f10
	
	exponenciacaoSub:
	bgt $t4, $t1, calculaTermoSubPart2						# quando t4 atingir t1 voltara para calculaTermoSoma
	mul.s $f11, $f11, $f10												# realiza a exponenciacao salvando em f11 o resultado 
	addi $t4, $t4, 1															# Soma 1 ao contador da exponenciacao
	j	exponenciacaoSub

retornaValorCotangMenor1:
	
	l.s $f20, fatorCorrecao			# Carrega o fator de correcao em f20				
	sub.s $f21, $f20, $f15			# Retorna o valor da cotangente para Menor 1 em f21


















calculaArctanMaior1:
	
	
entradaInvalida:
	li $v0, 4
	la $a0, stringInvalida
	syscall
	
	li $v0, 10
	syscall


	
	





