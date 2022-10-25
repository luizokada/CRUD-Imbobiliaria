# CRUD-Imobiliária

### Como compilar:
>   as -32 trab2.s -o trab2.o
>   ld -m elf_i386 trab2.o -l c -dynamic-linker /lib/ld-linux.so.2 -o trab2
>   ./trab2

Implementar em linguagem Gnu Assembly para plataforma 32bits, um programa de Controle de Cadastro de Imobiliário para locação, usando exclusivamente as instruções e recursos de programação passados durante as aulas. O programa deve executar as funcionalidades de cadastro de uma imobiliária. As seguintes funcionalidades devem ser implementadas: inserção, remoção, consulta, gravar cadastro, recuperar cadastro e relatório de registros. Deve-se usar uma lista encadeada dinâmica (com malloc) para armazenar os registros dos imóveis ordenados por número de cômodos.

Para cada registro de imóvel deve-se ter as seguintes informações:
- Nome completo

- CPF e celular do proprietário

- Tipo do imóvel (casa ou apartamento) 

- Endereço do imóvel (cidade, bairro, rua e número),

- Número de quartos simples e de suites, se tem banheiro social, cozinha, sala e garagem 

- metragem total

- valor do aluguel

As consultas de registros devem ser feitas por número de cômodos.

O relatório deve mostrar todos os registros cadastrados de forma ordenada.

A remoção deve liberar o espaço de memória alocada (pode-se usar a função free(), empilhando o endereço antes de chamá-la com call).

A lista encadeada será manipulada em memoria e disco, devendo os registros serem digitados a cada execução ou todos eles lidos/gravados durante a execução. A manipulação de disco para as operações de leitura/gravação deverá utilizar chamadas ao sistema, não funções de biblioteca.

Os trabalhos devem ser feitos em grupos de no máximo 3 alunos. O código fonte deve ser entregue juntamente com um relatório contendo: identificação dos participantes, descrição dos principais módulos desenvolvidos e auto-avaliação do funcionamento (elencar as partes que funcionam corretamente, as partes que não funcionam corretamente e sob quais circunstancias, bem como as partes que não foram implementadas). O programa deve ser estruturado em procedimentos/funções Deve-se utilizar menu de opções. O código deve ser comentado. Entregar o código fonte. 