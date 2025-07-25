#!/bin/bash

echo "🚀 Iniciando Pixer API localmente..."

# Verificar se o .env existe
if [ ! -f ".env" ]; then
    echo "📝 Criando arquivo .env..."
    cp .env.example .env
fi

# Instalar dependências do Composer (ignorando requisitos de plataforma)
echo "📦 Instalando dependências do Composer..."
composer install --ignore-platform-reqs

# Instalar dependências do Node.js
echo "📦 Instalando dependências do Node.js..."
npm install

# Build dos assets
echo "🔨 Build dos assets..."
NODE_OPTIONS='--openssl-legacy-provider' npm run production

# Gerar chave da aplicação
echo "🔑 Gerando chave da aplicação..."
php artisan key:generate

# Limpar caches
echo "🧹 Limpando caches..."
php artisan cache:clear
php artisan config:clear
php artisan route:clear
php artisan view:clear

# Executar migrations (se necessário)
echo "🗄️ Executando migrations..."
php artisan migrate --force

# Iniciar servidor
echo "🌐 Iniciando servidor..."
php artisan serve --host=0.0.0.0 --port=8000
