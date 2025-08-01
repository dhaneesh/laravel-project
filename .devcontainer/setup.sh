#!/bin/bash
set -e

echo "🔧 Installing Laravel..."

# Install Composer globally if needed (Codespace image already has it)
composer self-update

# Create new Laravel project
laravel new laravel-app --dev --force

cd laravel-app

# Set up environment
cp .env.example .env
php artisan key:generate

# Set database config (already uses MySQL with default root/password)
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/' .env

# Install JS dependencies
npm install && npm run build

# Run database migrations (optional)
php artisan migrate || true

# Start Laravel server
php artisan serve --host=0.0.0.0 --port=8000
