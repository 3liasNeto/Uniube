#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
    #include <windows.h>
#endif  

typedef struct
{
    char description[100];
    float amount;
} Expense;

void clearScreen();

int main()
{
    int qty_expenses;
    float total = 0, average = 0;

    printf("=====================================\n");
    printf("Controle de Despesas Pessoais 6000! \n");
    printf("Digite suas despesas e eu calculo o total para você!\n");
    printf("Pressione ENTER para continuar...\n");
    printf("=====================================\n");
    getchar();
    // clearScreen();

    printf("Digite a quantidade de despesas que deseja inserir: ");
    scanf("%d", &qty_expenses);

    Expense *expenses = (Expense *)malloc(qty_expenses * sizeof(Expense));

    if(expenses == NULL)
    {
        printf("Erro de alocação de memória!\n");
        return 1;
    }

    for (int i = 0; i < qty_expenses; i++)
    {
        printf("Digite a descrição da despesa %d: ", i + 1);
        scanf(" %[^\n]", expenses[i].description);
        printf("Digite o valor da despesa %d: R$ ", i + 1);
        scanf("%f", &expenses[i].amount);
        total += expenses[i].amount;
    }

    average = total / qty_expenses;

    printf("=====================================\n");
    printf("Resumo das Despesas:\n");
    for (int i = 0; i < qty_expenses; i++)
    {
        printf("%d. %s - R$ %.2f\n", i + 1, expenses[i].description, expenses[i].amount);
    }
    printf("Média das Despesas: R$ %.2f\n", average);
    printf("Total das Despesas: R$ %.2f\n", total);
    printf("=====================================\n");

    free(expenses);

    return 0;
}

void clearScreen() {
    #ifdef _WIN32
        system("cls");
    #else
        system("clear");
    #endif
}
