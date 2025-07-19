#!/bin/bash

echo "🩹 Starting Healenium Demo Environment..."

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

# Check if Docker is running
if ! docker info > /dev/null 2>&1; then
    print_error "Docker is not running. Please start Docker first."
    exit 1
fi

# Step 1: Build and start demo website
print_status "Building and starting demo website..."
cd demo-website
if docker compose up -d --build; then
    print_success "Demo website started at http://localhost:8080"
else
    print_error "Failed to start demo website"
    exit 1
fi
cd ..

# Step 2: Start Healenium infrastructure
print_status "Starting Healenium infrastructure..."
if docker compose up -d; then
    print_success "Healenium infrastructure started"
else
    print_error "Failed to start Healenium infrastructure"
    exit 1
fi

# Wait for services to be ready
print_status "Waiting for services to be ready..."
sleep 10

# Check if services are running
print_status "Checking service status..."

# Check demo website
if curl -s http://localhost:8080 > /dev/null; then
    print_success "Demo website is accessible"
else
    print_warning "Demo website might not be ready yet"
fi

# Check Healenium backend
if curl -s http://localhost:7878 > /dev/null; then
    print_success "Healenium backend is accessible"
else
    print_warning "Healenium backend might not be ready yet"
fi

# Check Selenium Hub
if curl -s http://localhost:4444 > /dev/null; then
    print_success "Selenium Hub is accessible"
else
    print_warning "Selenium Hub might not be ready yet"
fi

echo ""
print_success "🎉 Demo environment is ready!"
echo ""
echo "📋 Available URLs:"
echo "   🌐 Demo Website:     http://localhost:8080"
echo "   🩹 Healenium Report: http://localhost:7878/healenium/report/"
echo "   🔧 Selenium Hub:     http://localhost:4444"
echo "   📊 VNC Browser:      http://localhost:7900 (password: 123456)"
echo ""
echo "🧪 Run tests with:"
echo "   npm test"
echo ""
echo "🛑 Stop everything with:"
echo "   ./stop-demo.sh" 