#!/bin/bash

echo "=== Compilando arquivos ==="
for i in {28..44}; do
    if [ -f "$i.cpp" ]; then
        echo "Compilando $i.cpp..."
        g++ "$i.cpp" -o "$i"
        if [ $? -eq 0 ]; then
            echo "✓ $i.cpp compilado com sucesso"
        else
            echo "✗ Erro ao compilar $i.cpp"
        fi
    else
        echo "Arquivo $i.cpp não encontrado"
    fi
done

echo -e "\n=== Executando programas ==="
for i in {28..44}; do
    if [ -f "$i" ] && [ -x "$i" ]; then
        echo "=== Executando $i ==="
        ./"$i"
        echo
    fi
done