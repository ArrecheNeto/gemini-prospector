#!/bin/bash
# Prospector de Sites — inicia o dashboard (Mac). Duplo clique para abrir.
cd "$(dirname "$0")"
if command -v python3 >/dev/null 2>&1; then
  python3 dashboard-server.py
else
  echo "Python 3 nao encontrado. Instale em https://www.python.org/downloads/ (ou: brew install python3) e tente de novo."
  read -p "Pressione Enter para fechar..."
fi
