#include <stdio.h>
#include <stdlib.h>

typedef struct
{
    int note;
    char obs[50];
} Rating;

int main()
{
    int qty_ratings, rating_notes[4] = {0, 0, 0, 0};
    float average = 0;

    printf("Quantas avaliações você deseja inserir? ");
    scanf("%d", &qty_ratings);

    Rating *ratings = (Rating *)malloc(qty_ratings * sizeof(Rating));

    if (ratings == NULL)
    {
        printf("Erro de alocação de memória!\n");
        return 1;
    }

    for (int i = 0; i < qty_ratings; i++)
    {
        int note;
        printf("Digite a nota da avaliação %d (1 = Ruim, 2 = Regular, 3 = Bom, 4 = Ótimo): \n", i + 1);
        scanf("%d", &note);

        if (note < 1 || note > 4)
        {
            printf("Nota inválida! Tente novamente.\n");
            i--;
            continue;
        }


        rating_notes[note - 1]++;
        ratings[i].note = note;

        printf("Digite uma observação para a avaliação %d (máximo 50 caracteres): \n", i + 1);
        scanf(" %[^\n]", ratings[i].obs);

        average += ratings[i].note;
    }

    average /= qty_ratings;
    printf("\n=====================================\n");
    printf("Resumo das Avaliações:\n");
    for (int i = 0; i < qty_ratings; i++)
    {
        printf("%d. Nota: %d - Observação: %s\n", i + 1, ratings[i].note, ratings[i].obs);
    }

    printf("\nContagem de Notas:\n");
    printf("Ruim (1): %d\n", rating_notes[0]);
    printf("Regular (2): %d\n", rating_notes[1]);
    printf("Bom (3): %d\n", rating_notes[2]);
    printf("Ótimo (4): %d\n", rating_notes[3]);
    printf("A média das avaliações é: %.2f\n", average);

    free(ratings);

    return 0;
}