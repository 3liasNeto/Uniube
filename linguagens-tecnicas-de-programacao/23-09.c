#include <stdio.h>

int main()
{
    int menu, pizza = 0, bebida = 0, sobremesa = 0, select;
    while (menu != 4)
    {

        printf("Menu de Opções:\n");
        printf("1 - Pizza\n");
        printf("2 - Bebidas\n");
        printf("3 - Sobremesas\n");
        printf("4 - Finalizar Pedido\n");
        printf(" Informe sua escolha: ");
        scanf("%d", &menu);

        switch (menu)
        {
        case 1:
            printf("===========================\n");
            printf("Escolha sua pizza:\n");
            printf("1 - Margherita\n");
            printf("2 - Pepperoni\n");
            printf("3 - Quatro Queijos\n");
            printf("4 - Calabresa\n");
            printf("5 - Frango com Catupiry\n");
            printf("6 - Voltar ao menu principal\n");
            printf("Informe sua escolha: ");
            scanf("%d", &select);
            if (select == 6)
            {
                break;
            }
            pizza = select;
            break;
        case 2:
            printf("===========================\n");
            printf("Escolha sua bebida:\n");
            printf("1 - Refrigerante\n");
            printf("2 - Suco\n");
            printf("3 - Água\n");
            printf("4 - Cerveja\n");
            printf("5 - Voltar ao menu principal\n");
            printf("Informe sua escolha: ");
            scanf("%d", &select);
            if (select == 5)
            {
                break;
            }
            bebida = select;
            break;
        case 3:
            printf("===========================\n");
            printf("Escolha sua sobremesa:\n");
            printf("1 - Torta de Limão\n");
            printf("2 - Brownie\n");
            printf("3 - Sorvete\n");
            printf("4 - Fruta da Estação\n");
            printf("5 - Voltar ao menu principal\n");
            printf("Informe sua escolha: ");
            scanf("%d", &select);
            if (select == 5)
            {
                break;
            }
            sobremesa = select;
            break;

        case 4:
            printf("Saindo do programa. Até logo!\n");
            break;
        default:
            break;
        }
    }

    printf("Seu pedido:\n");
    printf("Pizza: %d\n", pizza);
    printf("Bebida: %d\n", bebida);
    printf("Sobremesa: %d\n", sobremesa);
    printf("Obrigado por seu pedido!\n");

    return 0;
}