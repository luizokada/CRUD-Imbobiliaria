.section .data
	txtAbertura: 		.asciz 	"\n*** Controle de Imobiliária ***\n"
	txtContinuar: 		.asciz 	"\nDeseja continuar?\n <1> Sim  <2> Não\n"

    menuOp: 	    	.asciz 	"\nSelecione uma opção:\n <1> - Inserir registro \n <2> - Consultar registro\n <3> - Remover registro \n <4> - Relatório de registros \n <5> - Gravar registro \n <6> - Recuperar registro \n <7> - Sair \n"

	txtPedeNome:		.asciz	"\nDigite o nome completo: " #64Bytes
	txtPedeDataNasc: 	.asciz 	"\nDigite a data de nascimento: \n" #12Bytes
	txtPedeDia:			.asciz	"Dia: " #64bytes
	txtPedeMes:			.asciz	"Mes: " #4bytes
	txtPedeAno:			.asciz	"Ano: " #32bytes
	txtPedeIdade:		.asciz 	"\nDigite a idade: " #4bytes
	txtPedeCPF: 		.asciz 	"\nDigite o CPF: "#16bytes
	txtPedeMetragem:	.asciz	"\nDigite a metragem Total: " #4bytes
	txtPedeDDD:			.asciz	"\nDigite o DDD: " #4bytes
	txtPedeTelefone:	.asciz	"\nDigite o telefone: " #16bytes
    txtPedeTipoImovel:	.asciz	"\nDigite o tipo do imóvel (casa ou apartamento): " #12bytes

	txtPedeEndereco:	.asciz	"\nDigite o endereço\n" #100bytes
	txtPedeRua:			.asciz	"Rua: " #64bytes
	txtPedeNumero:		.asciz	"Número: " #4bytes
	txtPedeBairro:		.asciz	"Bairro: " #32bytes
    txtPedeNumQuartos:	.asciz	"\nDigite a quantidade quartos: " #4bytes
    txtPedeNumSuites:	.asciz	"\nDigite o número de suítes: " #4bytes 
	txtPedeBanheiro:	.asciz	"\nDigite o número de banheiros sociais: " #4bytes 
    txtPedeCozinha:		.asciz	"\nTem cozinha? <S> Sim <N> Não " #4bytes 
    txtPedeSala:		.asciz	"\nTem sala? <S> Sim <N> Não " #4bytes 
    txtPedeGaragem:		.asciz	"\nTem garagem? <S> Sim <N> Não " #4bytes 

	txtMostraRegistro:	.asciz	"\nRegistro %d: \n "
	txtMostraReg:		.asciz	"\nRegistro lido: "
	textoParaContinuar:	.asciz	"\nDigite qualquer caracter para continuar: "
	txtMostraNome:		.asciz	"\nNome: %s"
	txtMostraDataNasc:	.asciz	"\nData de nascimento: %d/%d/%d"
	txtMostraIdade:		.asciz	"\nIdade: %d"
	txtMostraCPF:		.asciz	"\nCPF: %s"
	txtMostraDDD:		.asciz	"\nDDD: %s"
	txtMostraTelefone:	.asciz	"\nTelefone: %s"
	txtMostraTipoImovel: .asciz	"\nTipo do Imovel: %s"
	txtMostraEndereco:	.asciz	"\nEndereco: \n Rua: %s \n Numero: %d \nBairro: %s"
	txtMostraMetragem:	.asciz	"\nMetragem: %d"
	txtMostraQuarto:	.asciz	"\nQuarto: %d"
	txtMostraSuite:		.asciz	"\nSuite: %d"
	txtMostraBanheiro:	.asciz	"\nBanheiro: %d"
	txtMostraCozinha:	.asciz	"\nCozinha: %s"
	txtMostraSala:		.asciz	"\nSala: %s"
	txtMostraGaragem:	.asciz	"\nGaragem: %s"
	
	testando:			.asciz	"\nTESTANDO"
	testandoNum:		.asciz	"\n%d\n"
	testandoStr:		.asciz	"\n%s\n"

	tipoNum: 			.asciz 	"%d"
	imprimeTipoNum: 	.asciz 	"%d\n"
	tipoChar:			.asciz	"%c"
	tipoStr:			.asciz	"%s"
	pulaLinha: 			.asciz 	"\n"

	opcao:				.int	0
	limpaScan:			.space	10

	tamanhoRegistro:  	.int 	260 # tamanho do registro
	tamanhoLista:		.int 	0	# tamanho da lista
	CPF:				.int 	0

	cabecaLista:		.space  4	# cabeça da lista
	inicioRegistro:				.space	4	# campo inicial do registro que está sendo inserido no momento
	pai:				.space	4	# registro antecessor 
	filho:				.space	4	# registro sucessor
	teste:				.space 	4	
    fimLista:   		.space 	4	# último endereço do registro

	NULL:				.int 	0
	posicaoAtual: 		.int	0	
	iteracao:			.int	0
	
.section .text
.globl _start
_start:
	pushl	$txtAbertura
	call	printf
	addl	$4, %esp # limpa o(s) pushl
	movl 	$NULL, %eax
	movl 	%eax, cabecaLista
	call	resolveOpcoes
	
fim:
	pushl $0
	call exit

printTeste:
	pushl $testando
	call printf
	addl $4 , %esp
	RET


resolveOpcoes:
    pushl   $menuOp
	call    printf
    pushl	$opcao
	pushl	$tipoNum
	call	scanf

	addl	$12, %esp # limpa o(s) pushl

	# inserção
	cmpl	$1, opcao
	je	_insereReg

	# consulta
	cmpl	$2, opcao
	je	_consultaReg
	
	# remoção
	cmpl	$3, opcao
	je	_removeReg

	# relatório
    cmpl	$4, opcao
	je	_imprimeRelatorio

	# gravação
    cmpl	$5, opcao
	je	_gravaReg

	# recuperação
    cmpl	$6, opcao
	je	_recuperaReg

	# fim
	cmpl	$7, opcao
	je	fim

	RET

	_insereReg:
        call limpaScanf
        call leRegistro
        jmp resolveOpcoes
    _consultaReg:
	 	call limpaScanf
	    call consultaReg
        jmp resolveOpcoes
    _removeReg:
		call limpaScanf
		call removeReg
        jmp resolveOpcoes
    _imprimeRelatorio:
        call mostraReg
        jmp resolveOpcoes
    _gravaReg:
		call gravaReg
        jmp resolveOpcoes
    _recuperaReg:
		call recuperaReg
        jmp resolveOpcoes

consultaReg:
RET

removeReg:
RET

recuperaReg:
RET

gravaReg:
RET


# limpa o scanf por conta dos |n que sobram na pilha
limpaScanf:
	pushl	$limpaScan
	pushl   $tipoChar
	call 	scanf
	addl    $8, %esp # limpa o(s) pushl
	RET


insereOrdenado:
	movl  	inicioRegistro, %ecx # ecx guarda o registro atual
	addl 	$232, %ecx # número de quartos de REG

	movl 	$NULL, %ebx
	movl 	cabecaLista, %edi
	cmpl 	%edi, %ebx
	je	 	_insere 

	movl 	cabecaLista, %edi
	movl 	%edi, pai
	
	addl 	$232, %edi # número de quartos do primeiro cara da lista
	movl 	(%edi),%eax
	cmpl  	%eax,(%ecx)
	jle 	_insereComoPrimeiro # novo registro vira o primeiro da lista

	movl	pai,%edi
	addl 	$256, %edi
	cmpl 	$NULL, (%edi)
	je 		_insereFim
	movl 	(%edi), %eax
	movl 	%eax, filho

	movl  	inicioRegistro, %ecx # ecx guarda o registro atual
	call	printTeste
	

	_loopInsereOrdenado:
		movl 	pai, %edi
		movl 	filho, %ebx

	 	addl 	$256, %edi

		addl 	$232, %ebx
		movl 	(%ecx), %eax
		cmpl 	(%ebx), %eax 
		jle 	_insereAntesFilho
		movl 	filho, %ebx 
		movl 	%ebx, pai

		movl	pai,%edi
		addl 	$256, %edi
		cmpl 	$NULL, (%edi)
		je 		_insereFim

		movl 	(%ebx), %eax
		movl 	%eax, filho
		jmp 	_loopInsereOrdenado

	RET

# quando é o primeiro elemento
	_insere:
		movl	inicioRegistro, %ecx
		movl	%ecx, cabecaLista
		movl	%ecx, fimLista
		addl	$256, %ecx
		movl	$NULL, (%ecx)
		movl	tamanhoLista,%ebx
		addl	$1, %ebx
		movl	%ebx, tamanhoLista
		RET
	

	_insereComoPrimeiro:
		call	printTeste
		movl	inicioRegistro, %ecx #ECX Guarda o registro atual
		addl	$256, %ecx # posição pra indicar o próximo
		movl	cabecaLista, %edi
		movl	%edi, (%ecx) # faz o resto da lista ligar com reg
		movl	inicioRegistro, %ecx #ECX Guarda o registro atual
		movl	%ecx, cabecaLista
		movl	tamanhoLista,%ebx
		addl	$1, %ebx
		movl	%ebx, tamanhoLista
		RET

	
	_insereFim:
		call	printTeste
		movl 	pai, %edi
		movl 	inicioRegistro, %ebx
		addl 	$256, %edi
		movl 	%ebx, (%edi)
		movl 	%ebx, fimLista
		addl 	$256, %ebx	
		movl 	$NULL, (%ebx)
		RET

	_insereAntesFilho:
		movl 	pai, %edi
		movl 	filho, %ebx
		movl 	inicioRegistro, %ecx
		addl 	$256,%edi
		movl 	%ecx, (%edi)
		addl 	$256,%ecx
		movl 	%ebx, (%ecx)
		movl 	tamanhoLista,%ebx
		addl 	$1, %ebx
		movl 	%ebx, tamanhoLista
		RET

	

leRegistro:

	_initLoopLeitura:
		pushl	tamanhoRegistro
		call	malloc
		movl	%eax, inicioRegistro
		movl	inicioRegistro, %edi
		addl	$4, %esp # limpa o(s) pushl

		pushl	$txtPedeNome
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	stdin
		pushl	$64
		pushl	%edi
		call	fgets

		popl	%edi
		addl	$8, %esp # limpa o(s) pushl
		

		
		addl	$64, %edi # faz o ponteiro andar pro final do campo

		
		#DATA DE NASCIMENTO
		pushl	%edi
		pushl	$txtPedeDataNasc
		call	printf
		addl	$4, %esp # limpa o(s) pushl 
		popl	%edi

		#DIA
		pushl	%edi

		pushl	$txtPedeDia
		call	printf
		addl	$4, %esp # limpa o(s) pushl 

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl 

		popl	%edi
		addl 	$4, %edi

		pushl	$limpaScan
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl
		
		#MES
		pushl	%edi

		pushl	$txtPedeMes
		call	printf
		addl	$4, %esp # limpa o(s) pushl 

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl 

		popl	%edi
		addl 	$4, %edi

		pushl	$limpaScan
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl

		#ANO

		pushl	%edi

		pushl	$txtPedeAno
		call	printf
		addl	$4, %esp # limpa o(s) pushl 

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl 

		popl	%edi
		addl 	$4, %edi

		pushl	stdin
		pushl	$20
		pushl	$limpaScan
		call	fgets
		addl	$12, %esp # limpa o(s) pushl 

		# Idade

		pushl	%edi
		pushl	$txtPedeIdade
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl
		popl	%edi
	
		addl	$4, %edi 	# faz o ponteiro andar pro final do campo
		
		pushl	$limpaScan
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl

		#CPF
		pushl	%edi
	
		pushl	$txtPedeCPF
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi
		addl	$16, %edi  #faz o ponteiro andar pro final do campo

		#Metragem

		pushl	%edi

		pushl	$txtPedeMetragem
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf

		addl   $4,%esp

		popl	%edi
		addl	$4, %edi # faz o ponteiro andar pro final do campo


		pushl	$limpaScan
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl

		#DDD do Telefone
		pushl	%edi

		pushl	$txtPedeDDD
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

		
		pushl	stdin
		pushl	$4
		pushl	%edi
		call	fgets
		
		popl	%edi
		addl 	$8, %esp
		
		
		addl 	$4,%edi


		#Telefone 

		pushl	%edi

		pushl	$txtPedeTelefone
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

		
		pushl	stdin
		pushl	$16
		pushl	%edi
		call	fgets

		popl	%edi
		addl 	$8, %esp


		addl $16, %edi 	# faz o ponteiro andar pro final do campo

		#Tipo Imovel

		pushl %edi

		pushl	$txtPedeTipoImovel
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl %edi

		pushl	stdin
		pushl	$12
		pushl	%edi
		call	fgets

		popl	%edi
		addl 	$8, %esp

		
		addl $12, %edi # faz o ponteiro andar pro final do campo

		#Emdereço
		pushl %edi

		pushl	$txtPedeEndereco
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

		#RUA
		pushl	%edi
		pushl	$txtPedeRua
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

			
		pushl	stdin
		pushl	$64
		pushl	%edi
		call	fgets

		popl	%edi
		addl 	$8, %esp

		addl	$64, %edi # faz o ponteiro andar pro final do campo

		#Número

		pushl	%edi

		pushl	$txtPedeNumero
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		addl	$4, %edi 		# faz o ponteiro andar pro final do campo

		pushl	stdin
		pushl	$20
		pushl	$limpaScan
		call	fgets
		addl	$12, %esp # limpa o(s) pushl 

		#BAIRRO

		pushl	%edi

		pushl	$txtPedeBairro
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

		pushl	stdin
		pushl	$32
		pushl	%edi
		call	fgets

		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		addl	$32, %edi  # faz o ponteiro andar pro final do campo

		#Número de Quartos

		pushl	%edi
        
		pushl	$txtPedeNumQuartos
		call	printf
		addl	$4, %esp # limpa o(s) pushl

	
		pushl	$tipoNum
		call	scanf
	

		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		
		addl	$4, %edi # faz o ponteiro andar pro final do campo

		pushl	stdin
		pushl	$20
		pushl	$limpaScan
		call	fgets
		addl	$12, %esp # limpa o(s) pushl 

		#SUITES
		pushl	%edi
		
		pushl	$txtPedeNumSuites
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		
		addl	$4, %edi # faz o ponteiro andar pro final do campo

		pushl	stdin
		pushl	$20
		pushl	$limpaScan
		call	fgets
		addl	$12, %esp # limpa o(s) pushl 

		#Banheiro
		pushl	%edi

		pushl	$txtPedeBanheiro
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		addl	$4, %edi # faz o ponteiro andar pro final do campo

		pushl	stdin
		pushl	$20
		pushl	$limpaScan
		call	fgets
		addl	$12, %esp # limpa o(s) pushl 

		#Cozinha
		pushl 	%edi
		pushl	$txtPedeCozinha
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		pushl	stdin
		pushl	$4
		pushl	%edi
		call	fgets


		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		addl	$4, %edi # faz o ponteiro andar pro final do campo

		#Sala

		pushl	%edi

		pushl	$txtPedeSala
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		pushl	stdin
		pushl	$4
		pushl	%edi
		call	fgets


		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		addl	$4, %edi # faz o ponteiro andar pro final do campo


		#Garagem

		pushl	%edi

		pushl	$txtPedeGaragem
		call	printf
		addl	$4, %esp # limpa o(s) pushl
		popl 	%edi

		pushl	stdin
		pushl	$4
		pushl	%edi
		call	fgets


		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		addl	$4, %edi # faz o ponteiro andar pro final do campo


		# fazer inserção ordenada

		movl 	$NULL,%eax
		movl   	%eax, (%edi)

		call 	insereOrdenado

		pushl 	$txtContinuar
		call 	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$opcao
		pushl   $tipoNum
		call 	scanf

		addl	$8, %esp # limpa o(s) pushl
		movl 	opcao,%eax
		#
		

		cmpl  	$1,%eax
		je		_volta

		
	
	RET
	_volta:
		pushl	$limpaScan
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl
		jmp _initLoopLeitura
			

mostraReg:
	movl 	cabecaLista, %edi

	movl 	$0, iteracao
	_initLoopMostra:

	movl 	iteracao, %eax
	pushl	%eax
	pushl	$txtMostraRegistro
	call 	printf
	addl 	$8, %esp

	#NOME
	pushl	%edi
	pushl 	$txtMostraNome
	call 	printf
	addl 	$8,%esp
	addl 	$64, %edi #vai para o Próximo Campo

	#Nascimento
	movl 	(%edi), %eax
	addl	$4, %edi
	movl 	(%edi), %ebx
	addl	$4, %edi
	movl 	(%edi), %ecx

	pushl 	%ecx
	pushl 	%ebx
	pushl 	%eax
	pushl 	$txtMostraDataNasc
	call	printf
	addl	$16, %esp
	addl	$4, %edi #vai para o Próximo Campo
	
	#Idade
	movl 	(%edi), %eax
	pushl	%eax
	pushl	$txtMostraIdade
	call	printf
	addl 	$8, %esp

	addl 	$4, %edi

	#CPF
	pushl	%edi
	pushl 	$txtMostraCPF
	call	printf
	addl	$8,%esp
	addl	$16,%edi #vai para o Próximo Campo

	#METRAGEM
	movl 	(%edi), %eax
	pushl 	%eax
	pushl	$txtMostraMetragem
	call	printf
	addl 	$8, %esp
	addl	$4, %edi #vai para o Próximo Campo

	#DDD

	pushl 	%edi
	pushl 	$txtMostraDDD
	call	printf
	addl	$8, %esp

	addl	$4, %edi #vai para o Próximo Campo

	#TELEFONE

	pushl 	%edi
	pushl 	$txtMostraTelefone
	call	printf
	addl	$8, %esp

	addl	$16, %edi #vai para o Próximo Campo

	#TIPO IMOVEL 

	pushl	%edi
	pushl 	$txtMostraTipoImovel
	call	printf
	addl	$8, %esp

	addl	$12, %edi #vai para o Próximo Campo

	#ENDERECO

	movl 	%edi, %eax
	addl	$64, %edi
	movl 	(%edi), %ebx
	addl	$4, %edi
	movl 	%edi, %ecx

	pushl 	%ecx
	pushl 	%ebx
	pushl 	%eax
	pushl 	$txtMostraEndereco
	call	printf
	addl	$16, %esp
	addl	$32, %edi #vai para o Próximo Campo

	
	#QUARTO
	pushl 	(%edi)
	pushl	$txtMostraQuarto
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#SUITE
	pushl 	(%edi)
	pushl	$txtMostraSuite
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#BANHEIRO
	pushl 	(%edi)
	pushl	$txtMostraBanheiro
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#COZINHA
	pushl 	%edi
	pushl	$txtMostraCozinha
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#SALA

	pushl 	%edi
	pushl	$txtMostraSala
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#GARAGEM

	pushl 	%edi
	pushl	$txtMostraGaragem
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	movl	(%edi), %eax
	movl	$NULL, %ebx
	cmpl	%eax, %ebx
	je		_fimMostra
	movl 	iteracao, %eax
	addl 	$1, %eax
	movl	$iteracao, %ebx
	movl	%eax, (%ebx)
	movl	(%edi), %eax	
	movl 	%eax,%edi
	
	jmp 	_initLoopMostra



	_fimMostra:
	RET
