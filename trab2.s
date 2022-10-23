.section .data
	txtAbertura: 		.asciz 	"\n*** Leitura e Escrita de Registros ***\n"
	txtContinuar: 		.asciz 	"\nDeseja continuar: <1> - Sim  <2>- Nao\n"

    menuOp: 	    	.asciz 	"\nSelecione uma opcao:\n <1> - Inserir Registro \n <2> - Consultar Registro\n <3> - Remover Registro \n <4> - Relatorio de Registro \n <5> - Gravar Registro \n <6> - Recuperar Registro \n <7> - Sair \n"

	txtPedeNome:		.asciz	"\nDigite o nome completo: " #64Bytes
	txtPedeDataNasc: 	.asciz 	"\nDigite a data de nascimento: " #32Bytes
	txtPedeIdade:		.asciz 	"\nDigite a idade: " #8bytes
	txtPedeCPF: 		.asciz 	"\nDigite o CPF: "#16bytes
	txtPedeDDD:			.asciz	"\nDigite o DDD: " #8bytes
	txtPedeTelefone:	.asciz	"\nDigite o Telefone: " #16bytes
    txtPedeTipoImovel:	.asciz	"\nDigite o Tipo do Imovel (Casa ou Apartamento): " #12bytes

	txtPedeEnderec:		.asciz	"\nDigite o endereco\n" #100bytes
	txtPedeRua:			.asciz	"Rua: " #64bytes
	txtPedeNumero:		.asciz	"Numero: " #4bytes
	txtPedeBairro:		.asciz	"Bairro: " #32bytes

    txtPedeNumQuartos:	.asciz	"\nDigite a quantidade quartos: " #4bytes
    txtPedeNumSuites:	.asciz	"\nDigite o número de suites: " #4bytes 
	txtPedeBanheiro:	.asciz	"\nDigite o número de banheiros sociais: " #4bytes 
    txtPedeCozinha:		.asciz	"\nTem Cozinha: <S> Sim <N> Nao " #4bytes 
    txtPedeSala:		.asciz	"\nTem Sala : <S> Sim <N> Nao " #4bytes 
    txtPedeGaragem:		.asciz	"\nTem garagem: <S> Sim <N> Nao " #4bytes 

	txtMostraReg:		.asciz	"\nRegistro Lido"
	txtMostraNome:		.asciz	"\nNome: %s"
	txtMostraRG:		.asciz	"\nRG: %s"
	txtMostraCPF:		.asciz	"\nCPF: %s"
	txtMostraDataNasc:	.asciz	"\nData de Nascimento: %d/%d/%d"
	txtMostraTelefone:	.asciz	"\nTelefone: (%s) %s"

	tipoNum: 			.asciz 	"%d"
	imprimeTipoNum: 	.asciz 	"%d\n"
	tipoChar:			.asciz	"%c"
	tipoStr:			.asciz	"%s"
	pulaLinha: 			.asciz 	"\n"

	opcao:				.int	0

	tamReg:  			.int 	144
	tamList:			.int 	0
	CPF:				.int 	0

	listaReg:			.space  4
	reg:				.space	4
	paiReg:				.space	4
	filhoReg:			.space	4
	teste:				.space 	4
    fimLista:   		.space 	4

	NULL:				.int 	0
	posicaoAtual: 		.int	0	
	
.section .text
.globl _start
_start:
	pushl	$txtAbertura
	call	printf
	addl	$4, %esp

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

	addl	$12, %esp

	cmpl	$1, opcao
	je	_insereReg

	cmpl	$2, opcao
	je	_consultaReg
	
	cmpl	$3, opcao
	je	_removeReg

    cmpl	$4, opcao
	je	_imprimeRelatorio

    cmpl	$5, opcao
	je	_gravaReg

    cmpl	$6, opcao
	je	_recuperaReg

	cmpl	$7, opcao
	je	fim

	RET

	_insereReg:
        call limpaScanf
        call leReg
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


limpaScanf:
        pushl	$opcao
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp
        RET

inserOrdenado:
	movl  reg, %ecx #ECX Guarda o registro atual
	addl $176, %ecx # numero de quartos de REG

	movl tamList,%ebx
	movl listaReg, %edi
	movl %edi, paiReg
	cmpl $0, %ebx
	je	 _insere

	addl $176, %edi #Numero de quartos do primeiro cara da lista
	movl (%edi),%eax
	cmpl  (%ecx),%eax
	jle _insereComoPrimeiro #novo registro vira o primeiro da lista
	movl paiReg,%edi
	addl $208, %edi
	cmpl $-1, (%edi)
	je 	_trataPaiSemFilho
	movl (%edi), %eax
	movl %eax, filhoReg

	movl  reg, %ecx #ECX Guarda o registro atual
	addl $176, %eax # numero de quartos de filhos 

	_loopInsereOrdenado:
		movl paiReg, %edi
		movl filhoReg, %ebx
	 	addl $208, %edi
		addl $176, %ebx
		movl (%ecx), %eax
		cmpl %eax, (%ebx)
		jle _insereAntesFilho
		movl filhoReg, %ebx 
		movl %ebx, paiReg
		addl $208,%ebx
		cmpl $-1, (%ebx)
		je _insereFim
		movl (%ebx), %eax
		movl %eax, filhoReg
		jmp _loopInsereOrdenado

	_insereFim:
		movl paiReg, %edi
		movl reg, %ebx
		addl $208, %edi
		movl %ebx, (%edi)
		movl %ebx, fimLista
		addl $208, %ebx
		movl $-1, (%ebx)

	_insere:
		movl reg, %ecx
		movl %ecx, listaReg
		movl %ecx, fimLista
		addl $208, %ecx
		movl $-1, (%ecx)
		movl tamList,%ebx
		addl $1, %ebx
		movl %ebx, tamList
		RET

	_trataPaiSemFilho:
		movl reg, %ecx
		movl paiReg, %edi
		addl $176, %edi
		addl $176, %ecx
		movl (%edi), %eax
		cmpl %eax, (%ecx)
		jle _insereAntes
		movl reg, %ecx
		movl paiReg, %edi
		addl $208, %edi
		movl %ecx, (%edi)
		movl tamList,%ebx
		addl $1, %ebx
		movl %ebx, tamList
		RET

		_insereAntes:
			movl reg, %ecx
			movl paiReg, %edi
			addl $208, %ecx
			movl %edi, (%ecx)
			movl reg, %ecx
			movl %ecx, listaReg
			movl %edi, fimLista
			movl tamList,%ebx
			addl $1, %ebx
			movl %ebx, tamList
			RET

	_insereComoPrimeiro:
		movl  reg, %ecx #ECX Guarda o registro atual
		addl $208, %ecx # posicao pra indicar o proximo
		movl listaReg, %edi
		movl %edi, (%ecx) # faco o resto da lista ligar com reg
		movl  reg, %ecx #ECX Guarda o registro atual
		movl %ecx, listaReg
		movl tamList,%ebx
		addl $1, %ebx
		movl %ebx, tamList
		RET

	_insereAntesFilho:
		movl paiReg, %edi
		movl filhoReg, %ebx
		movl reg, %ecx
		addl $208,%edi
		movl %ecx, (%edi)
		addl $208,%ecx
		movl %ebx, (%ecx)
		movl tamList,%ebx
		addl $1, %ebx
		movl %ebx, tamList
		RET
		
leReg:
	_initLoop:
		pushl	tamReg
		call	malloc
		movl	%eax, reg
		movl	reg, %edi

		pushl	$txtPedeNome
		call	printf
		addl	$8, %esp

		pushl	stdin
		pushl	$64
		pushl	%edi
		call	fgets

		popl	%edi
		addl	$8, %esp

		addl	$64, %edi
		pushl	%edi

		pushl	$txtPedeDataNasc
		call	printf
		addl	$4, %esp

		popl %edi

		pushl	stdin
		pushl	$32
		pushl	%edi	
		addl	$4, %esp

		popl	%edi
		addl	$32, %edi
		pushl	%edi

		pushl	$txtPedeIdade
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf

		addl	$4, %esp
		popl	%edi
		addl	$8, %edi
		pushl	%edi

		pushl	$txtPedeCPF
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf

		addl	$4, %esp
		popl	%edi
		addl	$16, %edi
		pushl	%edi

		pushl	$txtPedeDDD
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$8, %edi
		pushl	%edi

		pushl	$txtPedeTelefone
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp

		popl %edi
		addl $16, %edi
		pushl %edi

		pushl	$txtPedeTipoImovel
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp

		popl %edi
		addl $12, %edi
		pushl %edi

		pushl	$txtPedeEnderec
		call	printf

		pushl	$txtPedeRua
		call	printf
		addl	$8, %esp

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$64, %edi
		pushl	%edi

		pushl	$txtPedeNumero
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeBairro
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$32, %edi
		pushl	%edi
		
		pushl	$txtPedeNumQuartos
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi
		
		pushl	$txtPedeNumSuites
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeBanheiro
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeCozinha
		call	printf
		addl	$4, %esp

		pushl	$tipoChar
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi


		pushl	$txtPedeSala
		call	printf
		addl	$4, %esp

		pushl	$tipoChar
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeGaragem
		call	printf
		addl	$4, %esp

		pushl	$tipoChar
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi		
		
		pushl 	$txtContinuar
		call 	printf

		pushl	$opcao
		pushl   $tipoNum
		call 	scanf
		addl	$12, %esp
		movl 	opcao,%eax
		
		cmpl  	$1,%eax
		je		_volta
	
	RET
	_volta:
		movl    tamList, %eax
		addl    $1, %eax
		movl    %eax, tamList
	
		pushl	tamReg
		call	malloc
		movl	%eax, (%edi)
		movl  	%eax, %edi
		
		pushl	$opcao
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp
		jmp _initLoop

mostraReg:
	RET
