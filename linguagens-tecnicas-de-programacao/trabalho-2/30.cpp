#include <stdio.h>
#include <stdlib.h>
#define MAX_PRODUCTS 50

typedef struct
{
    int id;
    char name[50];
    float price;
} Product;

typedef struct
{
    int id;
    int quantity;
} Order;

int main()
{
    Product menu[10] = {
        {1, "Hambúrguer", 15.00},
        {2, "Pizza", 25.00},
        {3, "Refrigerante", 5.00},
        {4, "Batata Frita", 10.00},
        {5, "Salada", 12.00},
        {6, "Sundae", 8.00},
        {7, "Cachorro Quente", 14.00},
        {8, "Suco Natural", 6.00},
        {9, "Torta", 20.00},
        {10, "Água Mineral", 3.00}};

    float total = 0.0;
    Order choices[MAX_PRODUCTS];

    printf("Menu de Produtos:\n");
    for (int i = 0; i < 10; i++)
    {
        printf("%d. %s - R$ %.2f\n", menu[i].id, menu[i].name, menu[i].price);
    }

    printf("Selecione o produto pelo número correspondente:\n");

    while (1)
    {
        int choice;
        printf("Digite o número do produto (0 para sair): ");
        scanf("%d", &choice);
        if (choice == 0)
            break;

        if (choice < 1 || choice > 10)
        {
            printf("Escolha inválida. Tente novamente.\n");
            continue;
        }

        choices[choice - 1].id = menu[choice - 1].id;
        choices[choice - 1].quantity++;
        printf("Produto %s adicionado ao pedido.\n", menu[choice - 1].name);
    }

    printf("Produtos selecionados:\n");
    for (int i = 0; i < 10; i++)
    {
        if (choices[i].quantity > 0)
        {
            printf("%d. %s - R$ %.2f (Preço Base R$ %.2f)\n", menu[i].id,
                   menu[i].name,
                   menu[i].price * choices[i].quantity,
                   menu[i].price);
            total += menu[i].price * choices[i].quantity;
        }
    }

    printf("Total a pagar: R$ %.2f\n", total);

    return 0;
}