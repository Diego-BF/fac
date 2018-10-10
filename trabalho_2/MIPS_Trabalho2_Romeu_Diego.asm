# 1) Escreva um programa em linguagem de montagem para MIPS usando, preferencialmente, o
# simulador MARS como plataforma de desenvolvimento e validação. A sua aplicação deverá
# calcular a o máximo divisor comum (MDC) e o mínimo múltiplo comum (MMC). Seguem
# os requisitos de implementação:
# ? Sua aplicação deverá receber em entrada em console dois números inteiros positivos e
# maiores que 1 e, em seguida, imprimir uma mensagem como resultado da operação.
# ? Exemplo de entrada:
# 9
# 6
# ? Saída para o exemplo acima:
# MDC: 3
# MMC: 18
# ? Outros exemplos:
# 15
# 4
# ========
# MDC: 1
# MMC: 60
# %%%%%%%%
# ­1
# 4
# =======
# Entrada invalida.

	
## TRABALHO 02 
### Romeu Carvalho Antunes - 15/0147554
### Diego Barbosa da Mota França - 14/0136355

.data

in_string: 			.asciiz "Digite um numero Inteiro: \n"
string_mmc: 		.asciiz "O Resultado do MMC foi: \n"
string_mdc: 		.asciiz "O Resultado do MDC foi: \n"
string_invalido: 	.asciiz "\n %%%%%%%%%% Numero digitado inválido %%%%%%%%%% \n"
out_string: 		.asciiz "O inteiro digitado foi : \n"
quebra_linha: 		.asciiz "\n"

.text

main:
	li $v0, 4					# Print instrução para o usuário
	la $a0, in_string			# Carrega a string em a0
	syscall
	
	li $v0,5					# função para ler inteiro
	syscall					
	move $t0, $v0				# Armazena primeiro numero em t0

	li $v0, 4					# Print instrução para o usuário
	la $a0, in_string			# Carrega a string em a0
	syscall
	
	li $v0,5					# função para ler inteiro
	syscall					
	move $t1, $v0				# Armazena primeiro numero em t1
	
	bltz $t0, out_of_here		# verifica se valor é inválido caso seja pula para função out_of_here
	bltz $t1, out_of_here		# verifica se valor é inválido caso seja pula para função out_of_here
	
	slt $t2, $t1, $t0					# Verifica se o segundo numero inserido é menor que o primeiro
	bne $t2, $zero, arruma_valores		# Caso seja menor a função arruma valor irá arrumar as posições
	add $s0, $zero, $t0					# Salva valor de entrada em s0 para mmc
	add $s1, $zero, $t1					# salva valor de entrada em s1 para mmc
	j calculaMDC
	
	arruma_valores:
	move $t3, $t0						# Move o valor do primeiro numero em t3
	move $t4, $t1						# Move o valor do segundo em t4
	move $t1, $t3						# Move o valor do primeiro numero para o segundo 
	move $t0, $t4						# Move o valor do segundo numero para o primeiro
	move $t3, $zero						# Zera o registrador t3
	move $t4, $zero						# Zera o registrador t4
	move $t5, $zero						# Zera o registrador t5	
	add $s0, $zero, $t0					# Salva valor de entrada em s0 para mmc
	add $s1, $zero, $t1					# salva valor de entrada em s1 para mmc
	j calculaMDC

calculaMDC:

	bne $t1, 0, loopMDC						# Verifica se t1 != 0
	j finalMDC							# Se t1 = 0 Resultado do MDC é o prório T0
		
	loopMDC:
		div $t0, $t1 						# Divisão de inteiros
		mflo $t4							# Resultado do cociente
		mfhi $t2							# Resto da divisão
		move $t0, $t1						# Movendo o valor de t1 para t0
		move $t1, $t2						# Movendo o resto t2 para t1
		j calculaMDC						# Retorna a Função de calcular MDC

finalMDC:
	add $s7, $zero, $t0 	# Armazena o resultado do mdc em S7
		
	li $v0, 4				# comando para print de string
	la $a0, string_mdc		# carrega em a0 a string para ser printada
	syscall
	
	move $a0, $t0			# move o valor em t0 para a0
	li $v0, 1				# comando para print de inteiro
	syscall
	
	li $v0, 4				# comando para print string
	la $a0, quebra_linha	# printa string de quebra de linha que é carregada en a0
	syscall
	
	li $t7, 100 			# garante o primeiro loop do mmc
	syscall
	
	mult $s0,$s1 			# multiplicação para mmc
	mflo $s2				# Aarmazena o resultado da multiplicação em s2
	move $t0, $s0			# Carrega valores iniciais para calculo do mmc
	move $t1, $s1			# Carrega valores iniciais para calculo do mmc
	
	j calculaMMC
	
calculaMMC:
	
	bne $t7, 0, loopMMC						# Condição de loop para calculo do mmc
	div $s2, $t0							# divisao dos numeros de entrada 
	mflo $s3								# resultado da divisao
	j resultadoMMC
	
	loopMMC:
		div $t0, $t1 						# Divisão de inteiros
		mflo $t4							# Resultado do cociente
		mfhi $t7							# Resto da divisão
		move $t0, $t1						# movendo valor de t1 para t0
		move $t1, $t7						# movendo valor do resto para t1
		j calculaMMC
		
		
resultadoMMC:
			
		
	li $v0, 4				# comando de print de string
	la $a0, string_mmc		# carrega em a0 a string que será printada
	syscall
	
	move $a0, $s3			# carrega em a0 o resultado do mmc
	li $v0, 1				# print do resultado armazenado em a0
	syscall
	
	li $v0, 10				# termina o programa 
	syscall



out_of_here:
	
	li $v0, 4							# comando de print de string
	la $a0, string_invalido				# avisa que o numero entrado é inválido
	syscall
	
	li $v0, 10							# comando para terminar o programa
	syscall

	
	
