# Trabalho 03 de FAC
# Cálculo do Arco da Cotangente de um número Real maior que 0
# Será resolvida utilizando o Arco da Tangente


.data	

	entradaX:  .double  					# Variavel de Entrada
	arctan:    .double  					# Valor do Arco Tangente
	arccotg:   .double  					# Valor do Arco Cotangente
	resultadoTemp: .double  				# Resultado temporario da parcela
	resultadoFinal: .double					# Resultado final da parcela
	fatorCorrecao: .double 1.57079632679 	# pi/2 fator de correção para arco de cotangente
	stringEntrada: .asciiz "Entre com o Valor de X: \n"
	stringInvalida: .asciiz "Entrada Inválida. \n"
	valorCotangente: .asciiz "O valor do Arco Cotangente é: \n"
	valorZero: .double 0
	valorUnitario: .double 1
	
.text


main:
	# le um numero float
	li $v0, 7
	syscall

	mov.d $f2, $f0 # copia o valor lido acima para uma novo registro

	#l.d $f4, valorZero 			# armazena o valor 0 no registrador f4
	c.lt.d $f2, $f4 				# verifica se o valor fornecido e menor do que 0
	bc1t entradaInvalida 			# se o valor for menor do que 0, vai para a label entradaInvalida
	
	l.d $f6, valorUnitario 			# armazena o valor 1 no registrador f6
	c.lt.d $f2, $f6 				# verifica se o valor fornecido e menor do que 1
	bc1f calculaArctanMaior1 		# se o valor for maior que 1, vai para a label calculaArctanMaior1
	j calculaArctanMenor1 			# se o valor for menor que 1, vai para a label calculaArctanMaior1
	

	
calculaArctanMenor1:
	
	li $t1, 1						# valor inicial do contador do Indice
	li $t2, 23						# valor final do contador do Indice
	li $t3, 1						# valor do contador do sinal
	
	
	loopArcTan:
	bgt $t1, $t2, retornaValorCotangMenor1 		# Criterio arbitrario de parada do loop de termos
	j pow 										# Apenas somando a função de exponencial
		

calculaTermo:
	# passa o valor do registrador t1 para o f8
	mtc1 $t1, $f8
	cvt.d.w $f8, $f8
	
	mul.d $f12, $f14, $f8				# multiplica o resultado da exponenciacao pelo indice e salva no f12
	
	div.d $f12, $f6, $f12						# Divide 1 pelo resultado da multiplicacao acima e salva no f12
	addi $t1, $t1, 2							# Incrementa o contador do LoopArcTan em 2
	beq $t3, 1, calculaTermoSinalPositivo		# Comparação que decide se calcula para um termo positivo ou negativo
	
	# calculo para o termo com sinal negativo
	sub.d $f16, $f16, $f12						# salva em f16 o valor do termo
	addi $t3, $t3, 1							# muda o valor do termo para positivo
	j loopArcTan								# Volta para loopArcTan

	# calculo para o termo com sinal positivo
	calculaTermoSinalPositivo:
	add.d $f16, $f16, $f12						# salva em f16 o valor do termo
	subi $t3, $t3, 1							# muda o valor do termo para negativo
	j loopArcTan								# Volta para loopArcTan


pow:
	li $t4, 1							# contador da exponenciacao
	mov.d $f10, $f2						# salva o valor inicial em f10
	mov.d $f14, $f6 					# seta o valor inicial de f14 para 1
	
	exponenciacao:
	bgt $t4, $t1, calculaTermo			# quando t4 atingir t1 voltara para calculaTermoSoma
	mul.d $f14, $f14, $f10				# realiza a exponenciacao salvando em f14 o resultado 
	addi $t4, $t4, 1					# soma 1 ao contador da exponenciacao
	j exponenciacao


retornaValorCotangMenor1:
	l.d $f20, fatorCorrecao			# Carrega o fator de correcao em f20
	add.d $f12, $f20, $f16			# soma o fator de correcao ao valor da arcotangente calculado e armazena em f12				
	sub.d $f12, $f20, $f12			# subtrai do fator de correcao o resultado da adicao acima e armazena em f12
	j saidaPrograma					# exibe o resultado da operacao feita	


calculaArctanMaior1:
	
	
entradaInvalida:
	li $v0, 4
	la $a0, stringInvalida
	syscall
	
	li $v0, 10
	syscall
	
saidaPrograma:

# =================== IMPLEMENTE AQUI SUA SOLUCAO: FIM      

      jal  print            # call print routine. 
      li   $v0, 10          # system call for exit
      syscall               # we are out of here.
		
#########  routine to print messages
      .data
space:		.asciiz  " "          # space
new_line:	.asciiz  "\n"         # newline
string_ARCCOT:	.asciiz  "arccot= "
      .text
print:	la   $a0, string_ARCCOT  
      	li   $v0, 4				# specify Print String service
      	syscall               	# print heading
      	move   $a0, $t0      	# 
	li   $v0, 3           		# specify Print Double service
      	syscall               	# print $t0


