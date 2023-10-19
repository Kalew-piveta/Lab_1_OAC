# LABORATORIO 1 - OAC
# GRUPO - 1 
# KALEW SILVA PIVETA 
# OBJETIVO GERAL : gerar um codigo objeto montado em Hexadecimal em arquivo de texto ASCII. 

.data
	# área para os dados na memória principal
	msg: .asciiz "Digite o caminho do programa a ser compilado: " # mensagem a ser ecibida pelo usuário

.text 
	# área para instruções do programa
	li $v0, 4 # Instrução para impressão de STRING
	la $a0, msg # Indicar o endereço que está a mensagem
	syscall # Imprimir 
	li $v0, 8 # Ler o caminho a ser enviado
	syscall
	li $v0, 4
	syscall