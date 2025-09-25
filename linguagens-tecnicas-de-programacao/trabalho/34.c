#include <stdio.h>

int main() {
    int age;
    printf("Idade: ");
    scanf("%d", &age);

    if(age < 18){
        printf("Menor de idade\n");
    } else if (age >= 18 && age < 65){
        printf("Adulto\n");
    } else {
        printf("Idoso\n");
    }
    
    return 0;
}