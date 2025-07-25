#!/bin/bash

# Script de inicialização para o Railway

echo "🚀 Iniciando Pixer API no Railway..."

# Verificar se o .env existe, se não, criar baseado no .env.example
if [ ! -f ".env" ]; then
    echo "📝 Criando arquivo .env..."
    cp .env.example .env
fi

# Gerar chave da aplicação se não existir
if ! grep -q "APP_KEY=base64:" .env; then
    echo "🔑 Gerando chave da aplicação..."
    php artisan key:generate --no-interaction
fi

# Limpar caches
echo "🧹 Limpando caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Executar migrations
echo "🗄️ Executando migrations..."
php artisan migrate --force

# Iniciar servidor
echo "🌐 Iniciando servidor..."
php artisan serve --host=0.0.0.0 --port=$PORT
