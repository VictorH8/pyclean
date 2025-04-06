#!/bin/bash

GREEN='\033[1;32m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

echo -e "${CYAN}🔍 Iniciando a limpeza de arquivos desnecessários...${RESET}"
sleep 1

limpar() {
    tipo=$1
    padrao=$2
    mensagem=$3
    acao=$4

    if [[ $tipo == "d" ]]; then
        resultado=$(find . -type d -name "$padrao")
    else
        resultado=$(find . -type f -name "$padrao")
    fi

    if [[ -n "$resultado" ]]; then
        echo -e "${YELLOW}$mensagem${RESET}"
        eval "$acao"
    fi
}

limpar "d" "__pycache__" "🧹 Removendo pastas __pycache__..." 'find . -type d -name "__pycache__" -exec rm -rf {} +'
limpar "f" "*.pyc"        "🧹 Removendo arquivos .pyc..."      'find . -type f -name "*.pyc" -exec rm -f {} +'
limpar "f" "*.pyo"        "🧹 Removendo arquivos .pyo..."      'find . -type f -name "*.pyo" -exec rm -f {} +'

limpar "d" ".pytest_cache" "🧼 Removendo cache do pytest..."   'find . -type d -name ".pytest_cache" -exec rm -rf {} +'
limpar "d" ".mypy_cache"   "🧼 Removendo cache do mypy..."     'find . -type d -name ".mypy_cache" -exec rm -rf {} +'

limpar "f" ".coverage"     "📉 Removendo arquivo de cobertura..." 'find . -type f -name ".coverage" -exec rm -f {} +'

limpar "d" "*.egg-info"    "📦 Removendo pastas *.egg-info..." 'find . -type d -name "*.egg-info" -exec rm -rf {} +'
limpar "d" "dist"          "📦 Removendo pasta dist..."        'find . -type d -name "dist" -exec rm -rf {} +'
limpar "d" "build"         "📦 Removendo pasta build..."       'find . -type d -name "build" -exec rm -rf {} +'

limpar "f" "*.log"         "🗑️ Removendo arquivos .log..."     'find . -type f -name "*.log" -exec rm -f {} +'

echo -e "${GREEN}✅ Limpeza concluída com sucesso!${RESET}"
