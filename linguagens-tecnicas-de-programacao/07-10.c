#include <stdio.h>
#define INTERACTION 5

int main()
{
    int val;

    for (int i = 0; i < INTERACTION; i++)
    {
        printf("Informe %d Valor: ", i + 1);
        scanf("%d", &val);

        if (val % 2 == 0)
        {
            printf("Valor %d: ", i + 1);
            printf("Par\n");
            continue;
        }

        printf("Valor %d:", i + 1);
        printf("Ímpar\n");
    }

    return 0;
}