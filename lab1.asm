# LABORATORIO 1 - OAC
# GRUPO - 1 
# KALEW SILVA PIVETA 
# OBJETIVO GERAL : gerar um codigo objeto montado em Hexadecimal em arquivo de texto ASCII. 

.data
	# �rea para os dados na mem�ria principal
	msg: .asciiz "Digite o caminho do programa a ser compilado: " # mensagem a ser ecibida pelo usu�rio

.text 
	# �rea para instru��es do programa
	li $v0, 4 # Instru��o para impress�o de STRING
	la $a0, msg # Indicar o endere�o que est� a mensagem
	syscall # Imprimir 
	li $v0, 8 # Ler o caminho a ser enviado
	syscall
	li $v0, 4
	syscall