.section .data

	txtAbertura: 		.asciz 	"\n*** Leitura e Escrita de Registros ***\n"
	txtContinuar: 		.asciz 	"\nDeseja continuar: <1> - Sim  <2>- Nao\n"

    menuOp: 	    	.asciz 	"\nSelecione uma opcao:\n <1> - Inserir Registro \n <2> - Consultar Registro\n <3> - Remover Registro \n <4> - Relatorio de Registro \n <5> - Gravar Registro \n <6> - Recuperar Registro \n <7> - Sair \n"

	txtPedeNome:		.asciz	"\nDigite o nome (completo): " #64Bytes
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

    txtPedeNumQuartos:	.asciz	"\nDigite a quantidade quartos: " #4bytes + #4bytes ponteiro
    txtPedeNumSuites:	.asciz	"\nDigite o número de suites: " #4bytes + #4bytes ponteiro
	txtPedeBanheiro:	.asciz	"\nDigite o número de Banheiros Sociais: " #4bytes + #4bytes ponteiro
    txtPedeCozinha:		.asciz	"\nTem Cozinha: <S> Sim <N> Nao " #4bytes + #4bytes ponteiro
    txtPedeSala:		.asciz	"\nTem Sala : <S> Sim <N> Nao " #4bytes + #4bytes ponteiro
    txtPedeGaragem:		.asciz	"\nTem garagem: <S> Sim <N> Nao " #4bytes + #4bytes ponteiro

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

limpaScanf:
        pushl	$opcao
		pushl   $tipoChar
		call 	scanf
		addl    $8, %esp
        RET



inserOrdenado:
	movl tamList,%ebx
	movl listaReg, %edi
	movl %edi, paiReg
	cmpl $0, %ebx
	je	 _insere
	addl $208, %edi
	movl (%edi), %eax
	movl %eax, filhoReg
	movl  reg, %ecx //ECX Guarda o registro atual
	addl $176, %ecx // numero de quartos de REG
	_loopInsereOrdenado:
		movl paiReg, %edi
		movl filhoReg, %ebx
	 	addl $176, %edi
		addl $176, %ebx
		movl (%ecx), %eax
		cmpl %eax, (%ebx)
		jle _insereAntesDoFilho
		movl posicaoAtual,%eax 
		cmpl %eax




	_insere:
		addl $208, %edi
		movl reg, %eax
		movl %eax, (%edi)
		RET

leReg:
	call pegaFInal
	pushl	tamReg
	call	malloc
	movl	%eax, reg
	movl	reg, %edi

	_initLoop:

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

		pushl	$txtPedeGenero
		call	printf
		addl	$4, %esp

		pushl	$tipoChar
		call	scanf		
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeRG
		call	printf
		addl	$4, %esp

		pushl	$tipoStr
		call	scanf

		addl	$4, %esp
		popl	%edi
		addl	$16, %edi
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

		pushl	$txtPedeDN
		call	printf

		pushl	$txtPedeDia
		call	printf
		addl	$8, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeMes
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi

		pushl	$txtPedeAno
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
		pushl	%edi
		
		pushl	$txtPedeIdade
		call	printf
		addl	$4, %esp

		pushl	$tipoNum
		call	scanf
		addl	$4, %esp

		popl	%edi
		addl	$4, %edi
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
		
		pushl 	$txtContinuar
		call 	printf

		pushl	$opcao
		pushl  $tipoNum
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


	movl	reg, %edi


	_loopDeLeitura:

	pushl	$txtMostraReg
	call	printf
	addl	$4, %esp

	pushl	%edi
	pushl	$txtMostraNome
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$64, %edi
	pushl	%edi

	movl	(%edi), %eax
	pushl	%eax
	pushl	$txtMostraGenero
	call	printf
	addl	$8, %esp

	popl	%edi
	addl	$4, %edi
	pushl	%edi

	pushl	$txtMostraRG
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$16, %edi
	pushl	%edi

	pushl	$txtMostraCPF
	call	printf
	addl	$4, %esp

	popl	%edi
	addl	$16, %edi

	movl	(%edi), %eax
	addl	$4, %edi
	movl	(%edi), %ebx
	addl	$4, %edi
	movl	(%edi), %ecx

	pushl	%edi
	pushl	%ecx
	pushl	%ebx
	pushl	%eax
	pushl	$txtMostraDN
	call	printf
	addl	$16, %esp

	popl	%edi
	addl	$4, %edi
	movl	(%edi), %eax

	pushl   %edi
	pushl	%eax
	pushl	$txtMostraIdade
	call	printf
	addl	$8, %esp


	popl    %edi
	addl    $4,%edi

	movl	%edi,%eax
	addl    $8,%edi
	movl	%edi,%ecx

	pushl 	%ecx
	pushl 	%eax
	pushl 	$txtMostraTelefone
	call 	printf
	addl	$12, %esp
	addl 	$16, %edi
	movl 	posicaoAtual,%ebx
	cmpl 	%ebx, tamList
	je		_fimLoop

	addl	$8, %esp
	movl	(%edi),%esi
	movl  	%esi,%edi
	addl 	$1, %ebx
	movl	%ebx, posicaoAtual
	jmp 	_loopDeLeitura
	_fimLoop:
		RET
