#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define STRING_SIZE 60

typedef struct
{
    char nome[STRING_SIZE];
    char curso[STRING_SIZE];
    char email[STRING_SIZE];
    int ra;
} Aluno;

void setAluno(char *message, char field[STRING_SIZE]);
void readAluno(Aluno aluno);

int main()
{
    Aluno aluno;

    printf("===============================\n");
    printf("===  SISTEMA DO ALUNO 2000  ===\n");
    printf("===============================\n");

    setAluno("Digite o nome do aluno:", aluno.nome);
    setAluno("Digite o curso do aluno:", aluno.curso);
    setAluno("Digite o email do aluno:", aluno.email);
    printf("Digite o RA do aluno: \n");
    scanf("%d", &aluno.ra);

    readAluno(aluno);
    return 0;
}

void setAluno(char *message, char field[STRING_SIZE])
{
    printf("%s \n", message);
    fgets(field, STRING_SIZE, stdin);

    field[strcspn(field, "\n")] = '\0';

    fflush(stdin);
}

void readAluno(Aluno aluno)
{
    printf("\n=== DADOS DO ALUNO ===\n");
    printf("Nome: %s\n", aluno.nome);
    printf("Curso: %s\n", aluno.curso);
    printf("Email: %s\n", aluno.email);
    printf("RA: %d\n", aluno.ra);
}