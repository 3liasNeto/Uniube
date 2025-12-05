#include <stdio.h>
#include <stdlib.h>

int main(){
    char exit;
    int option; 

    while(1){
        printf("Escolha uma opcao: ");
        scanf(" %d", &option);

        printf("Executando a opcao %d\n", option);
        printf("Deseja sair? (S/N): ");
        scanf(" %c", &exit);

        if(exit == 's' || exit == 'S'){
            printf("Encerrando.\n");
            break;
        }
    }
}