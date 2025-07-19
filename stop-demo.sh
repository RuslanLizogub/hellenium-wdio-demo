#!/bin/bash

echo "🛑 Stopping Healenium Demo Environment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Stop Healenium infrastructure
print_status "Stopping Healenium infrastructure..."
if docker compose down; then
    print_success "Healenium infrastructure stopped"
else
    print_warning "Some containers might still be running"
fi

# Stop demo website
print_status "Stopping demo website..."
cd demo-website
if docker compose down; then
    print_success "Demo website stopped"
else
    print_warning "Demo website containers might still be running"
fi
cd ..

# Remove orphaned containers
print_status "Cleaning up orphaned containers..."
docker container prune -f > /dev/null 2>&1

# Remove unused networks
print_status "Cleaning up unused networks..."
docker network prune -f > /dev/null 2>&1

print_success "🎉 Demo environment stopped successfully!"
echo ""
echo "💡 To start again, run:"
echo "   ./start-demo.sh" 