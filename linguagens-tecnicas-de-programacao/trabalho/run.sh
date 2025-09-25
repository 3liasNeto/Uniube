#!/bin/bash

echo "=== Compilando arquivos ==="
for i in {14..40}; do
    if [ -f "$i.c" ]; then
        echo "Compilando $i.c..."
        gcc "$i.c" -o "$i"
        if [ $? -eq 0 ]; then
            echo "✓ $i.c compilado com sucesso"
        else
            echo "✗ Erro ao compilar $i.c"
        fi
    else
        echo "Arquivo $i.c não encontrado"
    fi
done

echo -e "\n=== Executando programas ==="
for i in {14..40}; do
    if [ -f "$i" ] && [ -x "$i" ]; then
        echo "=== Executando $i ==="
        ./"$i"
        echo
    fi
done