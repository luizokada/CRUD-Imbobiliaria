.section .data
	txtAbertura: 		.asciz 	"\n*** Controle de Imobiliária ***\n"
	txtContinuar: 		.asciz 	"\nDeseja continuar?\n <1> Sim  <2> Não\n"

    menuOp: 	    	.asciz 	"\nSelecione uma opção:\n <1> - Inserir registro \n <2> - Consultar registro\n <3> - Remover registro \n <4> - Relatório de registros \n <5> - Gravar registro \n <6> - Recuperar registro \n <7> - Sair \n"

	txtPedeNome:		.asciz	"\nDigite o nome completo: " #64Bytes
	txtPedeDataNasc: 	.asciz 	"\nDigite a data de nascimento: \n" #12Bytes
	txtPedeDia:			.asciz	"Dia: " #4bytes
	txtPedeMes:			.asciz	"Mes: " #4bytes
	txtPedeAno:			.asciz	"Ano: " #4bytes
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
	

	txtPedeRegParaRemover: .asciz	"\nDigite o numero do registro para remover: " #12bytes
	txtPedeRegParaConsultar: .asciz "\nDigite o numero de comodos que quer consultar: "


	

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
	txtMostraTotal:	.asciz	"\nNúmero de Comodos: %d"
	txtMostraErroRemove:	.asciz	"\Registro Nao Existe \n"
	
	testando:			.asciz	"\nTESTANDO"
	testandoNum:		.asciz	"\n%d\n"
	testandoStr:		.asciz	"\n%s\n"

	tipoNum: 			.asciz 	"%d"
	imprimeTipoNum: 	.asciz 	"%d\n"
	tipoChar:			.asciz	"%c"
	tipoStr:			.asciz	"%s"
	pulaLinha: 			.asciz 	"\n"

	opcao:				.int	0
	regParaRemover:		.int	0 	# número do registro que será removido. será comparado com os índices
	limpaScan:			.space	10

	tamanhoRegistro:  	.int 	264 # tamanho do registro
	tamanhoLista:		.int 	0	# tamanho da lista

	cabecaLista:			.space  4	# cabeça da lista
	inicioRegistro:			.space	4	# campo inicial do registro que está sendo inserido no momento
	registroConsultaAtual:	.space 4 # registro que está sendo consultado
	pai:					.space	4	# registro antecessor 
	filho:					.space	4	# registro sucessor
	enderecoRemove:			.space 	4	# endereço do registro para remover
    fimLista:   			.space 	4	# último endereço do registro

	NULL:				.int 	0
	numComodos:			.int 	0
	posicaoAtual: 		.int	0	
	iteracao:			.int	0	# número da iteração atual, será usada na remoção
	
	comodosParaConsultar: .int	0
	totalComodos:		.int	0

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
TESTENUM:
		pushl	%eax
		pushl	$imprimeTipoNum
		call 	printf
		addl 	$8, %esp
		RET

consultaReg:
	pushl 	$txtPedeRegParaConsultar
	call 	printf
	addl 	$4, %esp

	pushl 	$comodosParaConsultar
	pushl 	$tipoNum
	call 	scanf
	addl 	$8, %esp
	movl 	cabecaLista, %edi
	movl 	$NULL, %ebx
	cmpl 	%ebx, (%edi)
	je		_fimConsulta

	movl 	%edi, registroConsultaAtual

	_loopConsultaRegistro:

		movl registroConsultaAtual, %edi
		movl $0, %eax

	
		addl 	$256, %edi 	# toral de comodos

		movl 	(%edi),%eax
		movl 	%eax, totalComodos
		# se a quantidade de comodos for igual ao que ele quer, mostra o registro completo
		cmpl 	 comodosParaConsultar,%eax
		jge 	_mostraRegistroConsulta
		_trocaReg:
			movl 	registroConsultaAtual, %edi
			addl 	$260, %edi
			movl 	$NULL, %ebx
			cmpl	%ebx, (%edi)
			je		_fimConsulta
			movl	(%edi), %ecx
			movl	%ecx, registroConsultaAtual
			jmp		_loopConsultaRegistro

	_fimConsulta:
		RET

RET

_mostraRegistroConsulta:
	call 	mostraRegistroConsulta
	jmp		_trocaReg

mostraRegistroConsulta:
	movl registroConsultaAtual, %edi

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

	RET

removeReg:
	call	mostraReg
	pushl	$txtPedeRegParaRemover
	call	printf
	addl	$4,%esp
	
	# número do registro que será removido
	pushl	$regParaRemover
	pushl 	$tipoNum
	call	scanf
	addl	$8,%esp

	# verifica se é o primeiro índice
	movl 	regParaRemover, %eax
	cmpl	$0,%eax
	je		_removePrimeiro

	# começa as iterações
	movl 	$0, iteracao
	movl 	cabecaLista, %edi
	movl 	%edi, pai
	addl 	$260, %edi # move o ponteiro pro próximo elemento
	movl 	(%edi), %ebx
	movl	%ebx, filho
	movl 	regParaRemover, %eax # guarda o "índice" do registro que será removido
	subl 	$1, %eax	
	movl 	%eax, regParaRemover

	_loopRemove:
		movl 	iteracao, %eax
		cmpl 	%eax, regParaRemover
		je		_removeMeio # remove no meio
		movl 	pai, %edi
		movl 	filho, %ebx
		movl 	$NULL, %ecx

	
		cmpl   	%ebx,%ecx # verifica se da para avança na lista
		je 		_erroRemove
		addl 	$1,	%eax	# incrementa a iteracao
		movl 	%eax, iteracao
		movl 	%ebx, pai	# filho passa a ser pai
		addl	$260, %ebx	# pega o filho do filho
		movl	(%ebx), %ecx	
		movl 	%ecx, filho	# pega o filho do filho e faz ele ser pai
		jmp		_loopRemove
		RET


	_removePrimeiro:
		movl	cabecaLista, %edi
		movl 	%edi, enderecoRemove # usar o free nessa variável depois de mudar a cabeça
		addl 	$260, %edi
		movl 	(%edi), %eax
		movl 	%eax, cabecaLista

		pushl	enderecoRemove
		call 	free
		addl 	$4, %esp
		RET

	_removeMeio:
		movl	filho, %edi
		movl	%edi, enderecoRemove
		addl	$260,%edi
		movl	(%edi), %eax
		movl	%eax,filho
		movl	pai, %ecx
		movl	filho, %edi
		addl	$260,%ecx
		movl	%edi, (%ecx)
		
		pushl	enderecoRemove
		call 	free
		addl 	$4, %esp

		movl 	$NULL,%ebx
		cmpl 	%eax, %ebx
		je		_atualizaFimLista
		RET
	_atualizaFimLista:
		movl	pai,%edi
		movl	%edi, fimLista
		RET
	_erroRemove:
		pushl	$txtMostraErroRemove
		call	printf
		addl	$4,%esp
		RET


recuperaReg:
RET

gravaReg:
RET


# limpa o scanf por conta dos \n que sobram na pilha
limpaScanf:
	pushl	$limpaScan
	pushl   $tipoChar
	call 	scanf
	addl    $8, %esp # limpa o(s) pushl
	RET


insereOrdenado:
	movl  	inicioRegistro, %ecx # ecx guarda o registro atual
	addl 	$256, %ecx # número de quartos de REG

	movl 	$NULL, %ebx
	movl 	cabecaLista, %edi
	cmpl 	%edi, %ebx
	je	 	_insere 

	movl 	cabecaLista, %edi
	movl 	%edi, pai
	
	addl 	$256, %edi # número de quartos do primeiro cara da lista
	movl 	(%edi),%eax
	cmpl  	%eax,(%ecx)
	jle 	_insereComoPrimeiro # novo registro vira o primeiro da lista
	movl	pai,%edi
	addl 	$260, %edi
	cmpl 	$NULL, (%edi)
	je 		_insereFim
	movl	pai,%edi
	addl 	$260, %edi
	movl 	(%edi), %eax
	movl 	%eax, filho
	movl  	inicioRegistro, %ecx # ecx guarda o registro atual
	addl 	$256, %ecx # número de quartos de REG
	_loopInsereOrdenado:
		movl 	pai, %edi
		movl 	filho, %ebx

	 	addl 	$260, %edi

		addl 	$256, %ebx
		movl 	(%ecx), %eax
		cmpl 	(%ebx), %eax 
		jle 	_insereAntesFilho
		movl 	filho, %ebx 
		movl 	%ebx, pai

		movl	pai,%edi
		addl 	$260, %edi
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
		addl	$260, %ecx
		movl	$NULL, (%ecx)
		movl	tamanhoLista,%ebx
		addl	$1, %ebx
		movl	%ebx, tamanhoLista
		RET
	

	_insereComoPrimeiro:
		movl	inicioRegistro, %ecx #ECX Guarda o registro atual
		addl	$260, %ecx # posição pra indicar o próximo
		movl	cabecaLista, %edi
		movl	%edi, (%ecx) # faz o resto da lista ligar com reg
		movl	inicioRegistro, %ecx #ECX Guarda o registro atual
		movl	%ecx, cabecaLista
		movl	tamanhoLista,%ebx
		addl	$1, %ebx
		movl	%ebx, tamanhoLista
		RET

	
	_insereFim:
		movl 	pai, %edi
		movl 	inicioRegistro, %ebx
		addl 	$260, %edi
		movl 	%ebx, (%edi)
		movl 	%ebx, fimLista
		addl 	$260, %ebx	
		movl 	$NULL, (%ebx)
		RET

	_insereAntesFilho:
		movl 	pai, %edi
		movl 	filho, %ebx
		movl 	inicioRegistro, %ecx
		addl 	$260,%edi
		movl 	%ecx, (%edi)
		addl 	$260,%ecx
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
		addl	$16, %edi  # faz o ponteiro andar pro final do campo

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
		movl	(%edi),%eax
		movl	%eax, numComodos

		
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

		movl	(%edi),%eax
		addl	%eax, numComodos
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
		movl	(%edi),%eax
		addl	%eax, numComodos
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

		movl 	numComodos, %eax
		movl	%eax,(%edi)
		addl	$4, %edi # faz o ponteiro andar pro final do campo

		movl 	$NULL,%eax
		movl   	%eax, (%edi)

		call 	insereOrdenado
		RET


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
	addl 	$64, %edi # vai para o Próximo Campo

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
	addl	$4, %edi # vai para o Próximo Campo
	
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
	addl	$16,%edi # vai para o Próximo Campo

	#METRAGEM
	movl 	(%edi), %eax
	pushl 	%eax
	pushl	$txtMostraMetragem
	call	printf
	addl 	$8, %esp
	addl	$4, %edi # vai para o Próximo Campo

	#DDD

	pushl 	%edi
	pushl 	$txtMostraDDD
	call	printf
	addl	$8, %esp

	addl	$4, %edi # ai para o Próximo Campo

	#TELEFONE

	pushl 	%edi
	pushl 	$txtMostraTelefone
	call	printf
	addl	$8, %esp

	addl	$16, %edi # vai para o Próximo Campo

	#TIPO IMOVEL 

	pushl	%edi
	pushl 	$txtMostraTipoImovel
	call	printf
	addl	$8, %esp

	addl	$12, %edi # vai para o Próximo Campo

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
	addl	$32, %edi # vai para o Próximo Campo

	
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

	#Total
	pushl 	(%edi)
	pushl	$txtMostraTotal
	call	printf
	addl 	$8, %esp
	addl	$4, %edi

	#vai pro próximo
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
