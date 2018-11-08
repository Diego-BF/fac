## Calculo de arco cotg por série de taylor 

.data

verificador1: .float 1
zero: .float 0

.text

main: 
	li $v0, 6 # Le float
	syscall 
	
	mov.s $f2, $f0 # Move float para f2 para que as operações possam ser executadas
	l.s $f4, zero # Valor 0 para comparar a entrada
	l.s $f3, verificador1 # Carrega o valor para verificar se o intervalo de f0
	
	c.lt.s $f2, $f4  # Compara para ver se f2 menor que f3 e seta a flag do coprocessor
	bc1t entradaInvalida # pular para função calculaArctangMenor1
	c.lt.s $f2, $f3  # Compara para ver se f2 menor que f3 e seta a flag do coprocessor
	bc1f calculaArctangMaior1 # pula para função calculaArctangMaior1 pois o valor inserido é maior que 1
	j calculaArctangMenor1 # pula para função calculaArctangMaior1 pois o valor inserido é menor que 1
	

	

calculaArctangMenor1:

	addi $s0, $zero, 1 # inciando o contador em 1
	
	expoenteDenominador:	
	beq $s0, 7, calculaArctangMenor1 # Limite arbitrario 
	jal armazenaExpoente
	div.s $f12, $f0, $s0 # verificar se precisa converter para float
	## Salvar resultado em variavel final somando os termos
	addi $s0, $s0, 2 # Incrementa de 2 em 2 t0
	j expoenteDenominador
	
	armazenaExpoente:  # Rotina que eu arrumo a variavel do expoente 
	addi $t0, $s0, 0 # salva de s0 para t0 armazena o expoente no t0
	add.s $f0, $f4, $f2 # Salva o valor incial em f0
	
	loop:
	beq $t0, 1, exitCalculaTermo  # verifcando se o expoente ja chegou em 1
	mul.s $f0, $f0, $f0 # realiza a exponenciacao de 1 vez
	addi $t0, $t0, -1 # decrementa o exponete em 1 para chegar na condicao desejada
	j loop	
	

	
	exitCalculaTermo:
	j $ra # Volta por jal
	
	
	
	
	
		

	
calculaArctangMaior1:

		
	
entradaInvalida:
	li $v0, 10
	syscall






