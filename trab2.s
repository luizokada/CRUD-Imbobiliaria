.section .data
	txtAbertura: 		.asciz 	"\n*** Controle de Imobiliária ***\n"
	txtContinuar: 		.asciz 	"\nDeseja continuar?\n <1> Sim  <2> Não\n"

    menuOp: 	    	.asciz 	"\nSelecione uma opção:\n <1> - Inserir registro \n <2> - Consultar registro\n <3> - Remover registro \n <4> - Relatório de registros \n <5> - Gravar registro \n <6> - Recuperar registro \n <7> - Sair \n"

	txtPedeNome:		.asciz	"\nDigite o nome completo: " #64Bytes
	txtPedeDataNasc: 	.asciz 	"\nDigite a data de nascimento: " #32Bytes
	txtPedeIdade:		.asciz 	"\nDigite a idade: " #8bytes
	txtPedeCPF: 		.asciz 	"\nDigite o CPF: "#16bytes
	txtPedeDDD:			.asciz	"\nDigite o DDD: " #8bytes
	txtPedeTelefone:	.asciz	"\nDigite o telefone: " #16bytes
    txtPedeTipoImovel:	.asciz	"\nDigite o tipo do imóvel (casa ou apartamento): " #12bytes

	txtPedeEndereco:		.asciz	"\nDigite o endereço\n" #100bytes
	txtPedeRua:			.asciz	"Rua: " #64bytes
	txtPedeNumero:		.asciz	"Número: " #4bytes
	txtPedeBairro:		.asciz	"Bairro: " #32bytes

    txtPedeNumQuartos:	.asciz	"\nDigite a quantidade quartos: " #4bytes
    txtPedeNumSuites:	.asciz	"\nDigite o número de suítes: " #4bytes 
	txtPedeBanheiro:	.asciz	"\nDigite o número de banheiros sociais: " #4bytes 
    txtPedeCozinha:		.asciz	"\nTem cozinha? <S> Sim <N> Não " #4bytes 
    txtPedeSala:		.asciz	"\nTem sala? <S> Sim <N> Não " #4bytes 
    txtPedeGaragem:		.asciz	"\nTem garagem? <S> Sim <N> Não " #4bytes 

	txtMostraReg:		.asciz	"\nRegistro lido: "
	txtMostraNome:		.asciz	"\nNome: %s"
	txtMostraRG:		.asciz	"\nRG: %s"
	txtMostraCPF:		.asciz	"\nCPF: %s"
	txtMostraDataNasc:	.asciz	"\nData de nascimento: %d/%d/%d"
	txtMostraTelefone:	.asciz	"\nTelefone: (%s) %s"

	tipoNum: 			.asciz 	"%d"
	imprimeTipoNum: 	.asciz 	"%d\n"
	tipoChar:			.asciz	"%c"
	tipoStr:			.asciz	"%s"
	pulaLinha: 			.asciz 	"\n"

	opcao:				.int	0

	tamanhoRegistro:  	.int 	144 # tamanho do registro
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
	
.section .text
.globl _start
_start:
	pushl	$txtAbertura
	call	printf
	addl	$4, %esp # limpa o(s) pushl

	call	resolveOpcoes
	
fim:
	pushl $0
	call exit

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
	pushl	$opcao
	pushl   $tipoChar
	call 	scanf
	addl    $8, %esp # limpa o(s) pushl
	RET


insereOrdenado:
	movl  inicioRegistro, %ecx # ecx guarda o registro atual
	addl $176, %ecx # número de quartos de REG

	movl tamanhoLista,%ebx
	movl cabecaLista, %edi
	movl %edi, pai
	# se for o primeiro registro, insere normal
	cmpl $0, %ebx
	je	 _insere

	addl $176, %edi # número de quartos do primeiro cara da lista
	movl (%edi),%eax
	cmpl  (%ecx),%eax
	jle _insereComoPrimeiro # novo registro vira o primeiro da lista
	movl pai,%edi
	addl $208, %edi
	cmpl $-1, (%edi)
	je 	_trataPaiSemFilho
	movl (%edi), %eax
	movl %eax, filho

	movl  inicioRegistro, %ecx # ecx guarda o registro atual
	addl $176, %eax # número de quartos de filhos 

	# se entrou aqui significa que o reg nao entra antes do pai
	_loopInsereOrdenado:
		movl pai, %edi
		movl filho, %ebx
	 	addl $208, %edi
		addl $176, %ebx
		movl (%ecx), %eax
		cmpl %eax, (%ebx)
		jle _insereAntesFilho
		movl filho, %ebx 
		movl %ebx, pai
		addl $208,%ebx
		cmpl $-1, (%ebx)
		je _insereFim
		movl (%ebx), %eax
		movl %eax, filho
		jmp _loopInsereOrdenado

	_insereFim:
		movl pai, %edi
		movl inicioRegistro, %ebx
		addl $208, %edi
		movl %ebx, (%edi)
		movl %ebx, fimLista
		addl $208, %ebx
		movl $-1, (%ebx)

	# quando é o primeiro elemento
	_insere:
		movl inicioRegistro, %ecx
		movl %ecx, cabecaLista
		movl %ecx, fimLista
		addl $208, %ecx
		movl $-1, (%ecx)
		movl tamanhoLista,%ebx
		addl $1, %ebx
		movl %ebx, tamanhoLista
		RET

	_trataPaiSemFilho:
		movl inicioRegistro, %ecx
		movl pai, %edi
		addl $176, %edi
		addl $176, %ecx
		movl (%edi), %eax
		cmpl %eax, (%ecx)
		jle _insereAntes
		movl inicioRegistro, %ecx
		movl pai, %edi
		addl $208, %edi
		movl %ecx, (%edi)
		movl tamanhoLista,%ebx
		addl $1, %ebx
		movl %ebx, tamanhoLista
		RET

		_insereAntes:
			movl inicioRegistro, %ecx
			movl pai, %edi
			addl $208, %ecx
			movl %edi, (%ecx)
			movl inicioRegistro, %ecx
			movl %ecx, cabecaLista
			movl %edi, fimLista
			movl tamanhoLista,%ebx
			addl $1, %ebx
			movl %ebx, tamanhoLista
			RET

	_insereComoPrimeiro:
		movl  inicioRegistro, %ecx #ECX Guarda o registro atual
		addl $208, %ecx # posição pra indicar o próximo
		movl cabecaLista, %edi
		movl %edi, (%ecx) # faz o resto da lista ligar com reg
		movl  inicioRegistro, %ecx #ECX Guarda o registro atual
		movl %ecx, cabecaLista
		movl tamanhoLista,%ebx
		addl $1, %ebx
		movl %ebx, tamanhoLista
		RET

	_insereAntesFilho:
		movl pai, %edi
		movl filho, %ebx
		movl inicioRegistro, %ecx
		addl $208,%edi
		movl %ecx, (%edi)
		addl $208,%ecx
		movl %ebx, (%ecx)
		movl tamanhoLista,%ebx
		addl $1, %ebx
		movl %ebx, tamanhoLista
		RET
		
leRegistro:
	_initLoop:
		pushl	tamanhoRegistro
		call	malloc
		movl	%eax, inicioRegistro
		movl	inicioRegistro, %edi

		pushl	$txtPedeNome
		call	printf
		addl	$8, %esp # limpa o(s) pushl

		pushl	stdin
		pushl	$64
		pushl	%edi
		call	fgets

		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		# faz o ponteiro andar pro final do campo
		addl	$64, %edi

		pushl	$txtPedeDataNasc
		call	printf
		addl	$4, %esp # limpa o(s) pushl 

		pushl	stdin
		pushl	$32
		pushl	%edi
		call	fgets

		popl	%edi
		addl	$8, %esp # limpa o(s) pushl

		# faz o ponteiro andar pro final do campo
		addl	$32, %edi
		pushl	%edi

		pushl	$txtPedeIdade
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf

		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$8, %edi
		pushl	%edi

		pushl	$txtPedeCPF
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf

		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$16, %edi
		pushl	%edi

		pushl	$txtPedeDDD
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$8, %edi
		pushl	%edi

		pushl	$txtPedeTelefone
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl %edi

		# faz o ponteiro andar pro final do campo
		addl $16, %edi
		pushl %edi

		pushl	$txtPedeTipoImovel
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl %edi

		# faz o ponteiro andar pro final do campo
		addl $12, %edi
		pushl %edi

		pushl	$txtPedeEndereco
		call	printf

		pushl	$txtPedeRua
		call	printf
		addl	$8, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$64, %edi
		pushl	%edi

		pushl	$txtPedeNumero
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeBairro
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$32, %edi
		
		pushl	$txtPedeNumQuartos
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	%edi
		pushl	$tipoNum
		call	scanf

		addl	$4, %esp # limpa o(s) pushl
		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi
		
		pushl	$txtPedeNumSuites
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeBanheiro
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$4, %edi

		pushl	$txtPedeCozinha
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoChar
		pushl	%edi
		call	scanf

		popl	%edi
		addl	$4, %esp # limpa o(s) pushl
		
		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeSala
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoChar
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi

		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeGaragem
		call	printf
		addl	$4, %esp # limpa o(s) pushl

		pushl	$tipoChar
		call	scanf
		addl	$4, %esp # limpa o(s) pushl

		popl	%edi
		
		# faz o ponteiro andar pro final do campo
		addl	$4, %edi
		pushl	%edi		
		
		# fazer inserção ordenada

		pushl 	$txtContinuar
		call 	printf

		pushl	$opcao
		pushl   $tipoNum
		call 	scanf
		addl	$12, %esp # limpa o(s) pushl
		movl 	opcao,%eax
		
		cmpl  	$1,%eax
		je		_volta
	
	RET
	_volta:
		movl    tamanhoLista, %eax
		addl    $1, %eax
		movl    %eax, tamanhoLista
	
		pushl	tamanhoRegistro
		call	malloc
		movl	%eax, (%edi)
		movl  	%eax, %edi
		
		pushl	$opcao
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp # limpa o(s) pushl
		jmp _initLoop

mostraReg:
	RET
