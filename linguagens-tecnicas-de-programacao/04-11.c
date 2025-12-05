#include <stdio.h>
#include <stdlib.h>
#define MAX 3
#define DEFAULT_CHANCES 3

int main()
{
    int chances = DEFAULT_CHANCES, guess[3];
    int secret = 1 + (rand() % MAX);
    printf("Welcome to the Guessing Game!\n");
    printf("You have %d chances to guess the secret number between 0 and %d.\n", chances, MAX - 1);

    while (chances > 0)
    {
        printf("You have %d chances left.\n", chances);
        printf("Enter your guess: ");
        scanf("%d", &guess[DEFAULT_CHANCES - chances]);

        if (guess[DEFAULT_CHANCES - chances] < 0 || guess[DEFAULT_CHANCES - chances] >= MAX)
        {
            printf("Please enter a number between 0 and %d.\n", MAX - 1);
            continue;
        }

        if (guess[DEFAULT_CHANCES - chances] == secret)
        {
            printf("Congratulations! You've guessed the secret number %d!\n", secret);
            chances--;
            break;
        }
        else if (guess[DEFAULT_CHANCES - chances] < secret)
        {
            printf("Too low!\n");
        }
        else
        {
            printf("Too high!\n");
        }
        chances--;
    }

    printf("The secret number was: %d\n", secret);
    printf("Your guesses were:\n");
    for (int i = 0; i < (DEFAULT_CHANCES - chances); i++)
    {
        printf("%d: [ %d ]\n", i + 1, guess[i]);
    }

    return 0;
}
