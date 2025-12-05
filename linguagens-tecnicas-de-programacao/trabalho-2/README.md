# Lista de Exercício 02 - Linguagem C

## Gabarito e Explicações

****Aluno:** Elias Alves de Carvalho Neto   RA: 5165123**

**Disciplina:** Linguagem e Técnicas de Programação
**Professor:** Dr. Camilo Barreto
**Curso:** CiênciadaComputação - UNIUBE

---

## Questões Teóricas - Gabarito

| Questões 01-09 | Questões 10-18 | Questões 19-27 |
| --------------- | --------------- | --------------- |
| 01 - B          | 10 - B          | 19 - A          |
| 02 - A          | 11 - B          | 20 - A          |
| 03 - B          | 12 - B          | 21 - A          |
| 04 - B          | 13 - B          | 22 - A          |
| 05 - B          | 14 - A          | 23 - A          |
| 06 - B          | 15 - B          | 24 - A          |
| 07 - C          | 16 - B          | 25 - B          |
| 08 - C          | 17 - A          | 26 - A          |
| 09 - A          | 18 - B          | 27 - A          |

## Questões Práticas - Explicações

### Q28 - Menu: Dia da Semana

**Arquivo:** [28.c](28.c)

**Conceitos utilizados:**

- `switch-case` para decisões múltiplas
- `default` para tratar casos inválidos
- `break` para evitar fall-through

**Explicação:**
O programa lê um número de 1 a 7 e usa `switch-case` para mapear cada número ao dia da semana correspondente. O caso `default` captura entradas inválidas. Cada `case` termina com `break` para evitar executar os próximos casos.

---

### Q29 - Menu: Mini-Calculadora

**Arquivo:** [29.c](29.c)

**Conceitos utilizados:**

- Funções com parâmetros e retorno
- `switch-case` para selecionar operação
- Validação de divisão por zero
- Protótipos de funções

**Explicação:**
Implementa uma calculadora básica com quatro operações. Utiliza funções separadas para cada operação (soma, subtração, multiplicação, divisão). A função de divisão verifica se o divisor é zero antes de calcular, prevenindo erro de execução. O `switch` seleciona qual função chamar baseado no operador inserido. E utilizado um sistema para calcular um valor em um unico input onde o usuario pode digitar o calculo em uma linha so como: 10 + 5 (num operator num).

---

### Q30 - Menu: Lanchonete

**Arquivo:** [30.c](30.c)

**Conceitos utilizados:**

- `struct` para representar produtos
- Vetores de structs (menu)
- Laço `while` com sentinela (0 para sair)
- Acumulador para calcular total

**Explicação:**
Simula um sistema de pedidos de lanchonete. Define uma struct `Product` com id, nome e preço. O menu é um vetor de produtos. O usuário pode adicionar múltiplos itens ao pedido, e o programa acumula o valor total. O laço continua até que o usuário digite 0.

---

### Q31 - Controle de Despesas Mensais

**Arquivo:** [31.c](31.c)

**Conceitos utilizados:**

- Alocação dinâmica de memória (`malloc`)
- `struct` para organizar dados
- Laço `for` para somar valores
- Cálculo de média

**Explicação:**
Gerencia despesas pessoais usando alocação dinâmica. Cria um array dinâmico de structs `Expense` contendo descrição e valor. Usa `for` para iterar sobre as despesas, somando os valores e calculando a média. Libera a memória alocada com `free()` ao final.

---

### Q32 - Relatório de Produção (7 dias)

**Arquivo:** [32.c](32.c)

**Conceitos utilizados:**

- Vetor de tamanho fixo (`float history[7]`)
- Laço `for` para leitura e processamento
- Variável acumuladora
- Busca do maior valor

**Explicação:**
Registra a produção de 7 dias em um vetor. Durante a leitura, simultaneamente soma os valores (total) e identifica o maior valor usando comparação `if`. Demonstra eficiência ao processar tudo em um único laço.

---

### Q33 - Pesquisa de Satisfação (contagem)

**Arquivo:** [33.c](33.c)

**Conceitos utilizados:**

- Vetor de contadores
- Alocação dinâmica para armazenar respostas
- `struct` para organizar dados de avaliação
- Validação de entrada

**Explicação:**
Sistema de avaliação que conta quantas respostas de cada tipo foram dadas. Usa um array `rating_notes[4]` onde cada índice representa um tipo de avaliação (Ruim, Regular, Bom, Ótimo). Valida entradas fora do intervalo 1-4 e permite redigitação. Calcula também a média das avaliações.

---

### Q34 - Jogo da Adivinhação

**Arquivo:** [34.c](34.c)

**Conceitos utilizados:**

- Geração de números aleatórios (`rand()`, `srand()`)
- `time(NULL)` para semente aleatória
- Laço `while` até acertar
- Controle de tentativas

**Explicação:**
Jogo de adivinhação onde o programa sorteia um número de 0 a 100. Usa `srand(time(NULL))` para garantir um número diferente a cada execução. O laço `while(1)` continua até o jogador acertar, fornecendo dicas ("maior" ou "menor") a cada tentativa. Armazena o histórico de tentativas em um vetor.

---

### Q35 - Menu até "Sair com S/s"

**Arquivo:** [35.c](35.c)

**Conceitos utilizados:**

- Laço `while` infinito com `break`
- Leitura de caractere (`%c`)
- Comparação com `||` (OR lógico)

**Explicação:**
Menu simples que repete até o usuário digitar 'S' ou 's'. Demonstra controle de laço com sentinela baseada em caractere. O espaço antes de `%c` no `scanf(" %c")` consome caracteres de espaço em branco deixados pelo buffer.

---

### Q36 - Soma até Sentinela

**Arquivo:** [36.c](36.c)

**Conceitos utilizados:**

- Laço `while` com sentinela (0)
- Variável acumuladora
- `break` para sair do laço

**Explicação:**
Programa simples que soma números até encontrar 0. Demonstra o padrão de sentinela, onde um valor especial (0) indica o fim da entrada. O acumulador `total` soma todos os valores antes do 0.

---

### Q37 - Estatísticas de Notas

**Arquivo:** [37.c](37.c)

**Conceitos utilizados:**

- Vetor para armazenar valores
- Funções auxiliares (`get_bigger`, `get_smaller`)
- Cálculo simultâneo de média, maior e menor
- Processamento em único laço

**Explicação:**
Sistema de análise de notas que calcula média, maior e menor nota. Usa funções auxiliares para encontrar o maior e menor valor, promovendo reutilização de código. Demonstra eficiência ao calcular todas as estatísticas em uma única passagem pelo vetor.

---

### Q38 - Substituir Negativos por Zero

**Arquivo:** [38.c](38.c)

**Conceitos utilizados:**

- Alocação dinâmica de memória
- Modificação in-place de vetor
- Validação condicional (`if`)

**Explicação:**
Programa que substitui valores negativos por zero durante a leitura. Usa alocação dinâmica para criar um vetor do tamanho especificado. A validação `if(val < 0)` identifica negativos e os substitui por 0 antes de armazenar no vetor.

---

### Q39 - Inverter Vetor "in place"

**Arquivo:** [39.c](39.c)

**Conceitos utilizados:**

- Alocação dinâmica
- Impressão reversa de vetor
- Iteração decrescente

**Explicação:**
Inverte a ordem de exibição dos elementos de um vetor. Em vez de trocar elementos no vetor (inversão in-place real), imprime do último para o primeiro usando um laço `for` decrescente: `for(int i = qty - 1; i >= 0; i--)`.

---

### Q40 - Calculadora com Funções

**Arquivo:** [40.c](40.c)

**Conceitos utilizados:**

- Funções com parâmetros e retorno `float`
- Protótipos de funções
- `switch-case` para dispatch
- Tratamento de divisão por zero

**Explicação:**
Versão modular da calculadora usando quatro funções separadas. Cada operação é implementada em sua própria função, tornando o código mais organizado e testável. O `main` usa `switch` para decidir qual função chamar. Idêntica à Q29, demonstrando as mesmas práticas.

---

### Q41 - Média Ponderada com Função

**Arquivo:** [41.c](41.c)

**Conceitos utilizados:**

- `struct` para agrupar dados relacionados
- Função que recebe struct e retorna float
- Cálculo de média ponderada
- Arrays dentro de struct

**Explicação:**
Calcula média ponderada usando uma struct para organizar notas e pesos. A função `median()` recebe a struct, calcula a soma ponderada (nota × peso) e divide pela soma dos pesos. Demonstra como structs facilitam passar múltiplos valores relacionados para funções.

---

### Q42 - Máximo e Mínimo com Funções

**Arquivo:** [42.c](42.c)

**Conceitos utilizados:**

- Funções que recebem arrays
- Busca de maior e menor valor
- Iteração com comparação

**Explicação:**
Implementa duas funções para encontrar o maior e menor valor em um array de 3 elementos. Cada função inicializa com o primeiro elemento e depois compara com os demais. Demonstra passagem de arrays para funções (por referência implícita).

---

### Q43 - Cadastro de Aluno

**Arquivo:** [43.c](43.c)

**Conceitos utilizados:**

- `struct` com múltiplos campos (strings e int)
- Leitura de strings com `fgets()`
- Remoção de newline da string
- Funções auxiliares para entrada/saída

**Explicação:**
Sistema de cadastro usando struct `Aluno` com campos para nome, curso, email e RA. Usa `fgets()` para leitura segura de strings (evita buffer overflow). Remove o caractere de nova linha (`\n`) deixado pelo `fgets`. Demonstra boas práticas de manipulação de strings em C.

---

### Q44 - Retângulo: Área e Perímetro

**Arquivo:** [44.c](44.c)

**Conceitos utilizados:**

- `struct` para representar forma geométrica
- Funções que recebem struct e retornam cálculos
- Formatação de saída com `%.2f`

**Explicação:**
Representa um retângulo com struct contendo largura e altura. Implementa duas funções matemáticas: `area()` (largura × altura) e `perimetro()` (2 × (largura + altura)). Demonstra como structs podem modelar conceitos matemáticos e geométricos de forma clara e organizada.

---

## Conceitos-Chave Abordados no Trabalho

### Estruturas de Controle

- **switch-case**: Decisões múltiplas baseadas em valores discretos
- **for**: Iteração com contador conhecido
- **while**: Iteração com condição de parada
- **break**: Saída de laços e cases
- **default**: Caso padrão em switch

### Estruturas de Dados

- **Vetores**: Arrays estáticos e dinâmicos
- **Structs**: Agrupamento de dados relacionados
- **Typedef**: Criação de aliases de tipos

### Funções

- **Protótipos**: Declaração antecipada
- **Parâmetros**: Passagem por valor
- **Retorno**: Valores de retorno de funções
- **Modularização**: Divisão do código em funções

### Memória

- **malloc()**: Alocação dinâmica
- **free()**: Liberação de memória
- **Ponteiros**: Referências indiretas (implícitas com arrays)

### Números Aleatórios

- **rand()**: Geração de números pseudo-aleatórios
- **srand()**: Inicialização da semente
- **time(NULL)**: Semente baseada no tempo

### Boas Práticas

- Validação de entrada
- Tratamento de erros (divisão por zero, alocação falha)
- Mensagens claras para o usuário
- Código modular e reutilizável
- Liberação de memória alocada

---

## Compilação e Execução

Para compilar qualquer questão:

```bash
gcc -o programa XX.c
./programa
```

Exemplo para a questão 28:

```bash
gcc -o dia_semana 28.c
./dia_semana
```

Rodar todas as questoes:

```bash
./run.sh || bash ./run.sh
```
