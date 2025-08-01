#!/bin/bash
set -e

echo "🔧 Installing Laravel..."

# Create Laravel app using Composer if not already present
if [ ! -d "laravel-app" ]; then
    composer create-project laravel/laravel laravel-app
fi

cd laravel-app

# Set up environment
cp -n .env.example .env
php artisan key:generate

# Update DB password in .env (MySQL from Codespaces features)
sed -i 's/DB_PASSWORD=.*/DB_PASSWORD=password/' .env

# Install Node dependencies and build frontend
npm install && npm run build

# Run migrations (optional)
php artisan migrate || true

# Start Laravel development server
php artisan serve --host=0.0.0.0 --port=8000
