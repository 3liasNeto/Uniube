#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define MAX 100

int main()
{
    srand(time(NULL)); 

    int guess[MAX], counter = 0;
    int secret = rand() % (MAX + 1);
    printf("Welcome to the Guessing Game!\n");
    printf("You have to guess the secret number between 0 and %d.\n", MAX);

    while (1)
    {
        printf("Enter your guess: ");
        scanf("%d", &guess[counter]);

        if (guess[counter] < 0 || guess[counter] >= MAX)
        {
            printf("Please enter a number between 0 and %d.\n", MAX);

            if(counter > 0) counter--;

            continue;
        }

        if (guess[counter] == secret)
        {
            printf("Congratulations! You've guessed the secret number %d!\n", secret);
            counter++;
            break;
        }
        else if (guess[counter] < secret)
        {
            printf("Too low!\n");
        }
        else
        {
            printf("Too high!\n");
        }
        counter++;
    }

    printf("The secret number was: %d\n", secret);
    printf("Your guesses were:\n");
    for (int i = 0; i < counter; i++)
    {
        printf("%d: [ %d ]\n", i + 1, guess[i]);
    }

    return 0;
}
