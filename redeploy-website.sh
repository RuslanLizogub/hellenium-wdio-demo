#!/bin/bash

echo "🔄 Redeploying Demo Website..."

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

# Step 1: Stop and remove demo website containers
print_status "Stopping demo website containers..."
cd demo-website
if docker compose down; then
    print_success "Demo website containers stopped"
else
    print_warning "Some containers might still be running"
fi

# Step 2: Remove old images
print_status "Removing old demo website images..."
if docker rmi demo-website-demo-website 2>/dev/null; then
    print_success "Old image removed"
else
    print_warning "No old image to remove"
fi

# Step 3: Clean up any dangling images
print_status "Cleaning up dangling images..."
docker image prune -f > /dev/null 2>&1

# Step 4: Rebuild and start demo website
print_status "Building and starting demo website..."
if docker compose up -d --build; then
    print_success "Demo website redeployed successfully"
else
    print_error "Failed to redeploy demo website"
    exit 1
fi
cd ..

# Step 5: Wait for website to be ready
print_status "Waiting for website to be ready..."
sleep 5

# Step 6: Check if website is accessible and clear cache
print_status "Checking website accessibility and clearing cache..."
if curl -s http://localhost:8080 > /dev/null; then
    print_success "Demo website is accessible at http://localhost:8080"
    
    # Force clear cache by making a request with no-cache headers
    print_status "Clearing browser cache..."
    curl -H "Cache-Control: no-cache, no-store, must-revalidate" \
         -H "Pragma: no-cache" \
         -H "Expires: 0" \
         -s http://localhost:8080 > /dev/null
    
    # Verify the current title
    current_title=$(curl -H "Cache-Control: no-cache" -s http://localhost:8080 | grep -o '<title>[^<]*</title>' | sed 's/<title>\(.*\)<\/title>/\1/')
    print_success "Current page title: '$current_title'"
    
else
    print_warning "Website might not be ready yet, please wait a moment"
fi

echo ""
print_success "🎉 Demo website redeployed successfully!"
echo ""
echo "📋 Available URLs:"
echo "   🌐 Demo Website:     http://localhost:8080"
echo "   🩹 Healenium Report: http://localhost:7878/healenium/report/"
echo "   📊 VNC Browser:      http://localhost:7900 (password: 123456)"
echo ""
echo "🧪 Run tests with:"
echo "   npm test"
echo ""
echo "💡 To make changes:"
echo "   1. Edit files in demo-website/"
echo "   2. Run: ./redeploy-website.sh"
echo "   3. Run: npm test"
echo ""
echo "🔄 If you still see old content in browser:"
echo "   - Press Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)"
echo "   - Or open DevTools (F12) → right-click refresh → 'Empty Cache and Hard Reload'" 