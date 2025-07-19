# Healenium + WebDriverIO Demo

Minimal demonstration of **Healenium** integration with **WebDriverIO** for automatic locator self-healing in tests.

## What is Healenium?

Healenium is a self-healing library for Selenium that automatically fixes broken locators using machine learning. When an element is not found, Healenium analyzes the DOM and finds the most suitable replacement.

**Key Feature:** When a locator breaks, Healenium automatically suggests and applies alternative locators, making tests more resilient to UI changes.

## How Healenium Integration Works

Healenium uses a **proxy approach** for WebDriverIO:

1. **WebDriverIO** connects to **hlm-proxy** (port 8085) instead of Selenium Grid directly
2. **hlm-proxy** forwards requests to **Selenium Grid** (port 4444)
3. **hlm-proxy** intercepts element-finding operations and triggers healing when needed
4. **healenium-backend** (port 7878) processes healing logic using ML
5. **selector-imitator** (port 8000) converts healed locators to convenient format

```
WebDriverIO Test → hlm-proxy:8085 → Selenium Grid:4444 → Chrome Browser
                       ↓
                  Healenium Backend:7878 ← → selector-imitator:8000
                       ↓
                  PostgreSQL Database
```

## Requirements

- **Node.js v22.17.1 LTS** (recommended)
- **Docker Desktop**

## Quick Start

### 1. Install Node.js

```bash
# Install Node.js v22.17.1 LTS
nvm install 22.17.1
nvm use 22.17.1
```

### 2. Install Dependencies

```bash
npm install
```

### 3. Start Healenium Infrastructure

```bash
# Start Docker containers
docker compose up -d

# Check container status
docker compose ps
```

**Verify all containers are running:**
- ✅ `hlm-proxy` on port 8085 (key component!)
- ✅ `healenium` backend on port 7878
- ✅ `selector-imitator` on port 8000
- ✅ `selenium-hub` on port 4444
- ✅ `node-chrome` connected to hub
- ✅ `postgres-db` on port 5432

### 4. Run Tests

```bash
npm test
```

## Key Configuration

### WebDriverIO Configuration (wdio.conf.js)

```javascript
// Connect to Healenium proxy instead of Selenium Grid directly
services: [],
hostname: '127.0.0.1',
port: 8085,           // hlm-proxy port (NOT 4444!)
protocol: 'http',
```

### Docker Infrastructure

The setup includes:
- **hlm-proxy:2.1.6** - Proxy between WebDriverIO and Selenium
- **healenium/hlm-backend:3.4.8** - Self-healing logic
- **healenium/hlm-selector-imitator:1.6** - Locator conversion
- **selenium/hub:latest** - Selenium Grid Hub
- **selenium/node-chrome:latest** - Chrome browser node
- **postgres:15.5-alpine** - Database for healing data

## Healenium Reports

- **Report URL**: http://localhost:7878/healenium/report/
- **Backend API**: http://localhost:7878/healenium/
- View healing statistics and successful/failed healing attempts

## Test Example

```javascript
describe('Simple Healenium Demo', () => {
    it('should search Google and show self-healing', async () => {
        await browser.url('https://www.google.com');
        
        // This locator will be auto-healed if it breaks
        const searchBox = await $('[name="q"]');
        await searchBox.setValue('Healenium demo');
        await browser.keys('Enter');
        
        // Healenium will track and heal any broken locators
        await browser.waitUntil(async () => {
            const title = await browser.getTitle();
            return title.includes('Healenium');
        });
    });
});
```

## How to Test Self-Healing

1. Run test successfully first time
2. Change a locator in the test to break it
3. Run test again - Healenium should heal it automatically
4. Check healing report at http://localhost:7878/healenium/report/

## Troubleshooting

**Issue**: Tests fail with connection errors
- **Solution**: Ensure all Docker containers are running (`docker compose ps`)
- Check hlm-proxy is accessible: `curl http://localhost:8085`

**Issue**: Healing not working
- **Solution**: Verify WebDriverIO connects to port 8085 (hlm-proxy), not 4444
- Check logs: `docker logs hlm-proxy`

## Architecture

```
[WebDriverIO Test] 
       ↓ (port 8085)
[hlm-proxy] ←→ [healenium-backend] ←→ [postgres-db]
       ↓                ↓
[selenium-hub] ←→ [selector-imitator]
       ↓
[node-chrome]
```

**The key difference from regular Selenium:** WebDriverIO connects to **hlm-proxy:8085** instead of **selenium-hub:4444** directly. This allows Healenium to intercept and heal broken locators transparently.

## Official Documentation

- [Healenium GitHub](https://github.com/healenium/healenium)
- [Healenium Docs](https://healenium.io/)
- [WebDriverIO Integration Example](https://github.com/healenium/healenium-example-webdriverio)
