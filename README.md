# 🩹 Healenium WebDriverIO Demo

A complete demonstration of Healenium self-healing automation with WebDriverIO, featuring a custom demo website for testing.

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Node.js (v20 or higher)
- Git

### Step-by-Step Setup

#### 1. Clone and Setup
```bash
git clone <repository-url>
cd hellenium-wdio-demo
npm install
```

#### 2. Start Everything (One Command)
```bash
./start-demo.sh
```

This script will:
- Start the demo website (http://localhost:8080)
- Start Healenium infrastructure (backend, proxy, Selenium Grid)
- Install dependencies
- Show you all available URLs

#### 3. Run Tests
```bash
npm test
```

#### 4. Stop Everything
```bash
./stop-demo.sh
```

## 📋 What's Included

### 🌐 Demo Website
- **URL**: http://localhost:8080
- **Two-page application**: Login form → Welcome page
- **Editable**: You can modify HTML to test self-healing
- **Docker-based**: Easy to rebuild and deploy

#### Website Structure
**Login Page (`/`)**:
- Username field: `name="username"` (JavaScript uses this)
- Password field: `name="password"` (JavaScript uses this)
- Login button: `type="submit"`
- Form: `id="loginForm"`

**Welcome Page (`/welcome.html`)**:
- Welcome message: `h1` with text "Welcome!"
- Success message: `div` with class "success-message"
- User info section: `div` with class "user-info"
- Username display: `span` with `id="displayUsername"`
- Back button: `a` with class "back-button"

### 🩹 Healenium Infrastructure
- **Backend**: http://localhost:7878
- **Reports**: http://localhost:7878/healenium/report/
- **Selenium Hub**: http://localhost:4444
- **VNC Browser**: http://localhost:7900 (password: 123456)

## 🧪 Testing Self-Healing

### Step 1: Run Tests with Correct Selectors
```bash
npm test
```

### Step 2: Modify Website Elements
Edit `demo-website/index.html` or `demo-website/welcome.html`:
- Change element IDs
- Modify CSS classes
- Update text content
- Add/remove elements

### Step 3: Redeploy Website
```bash
./redeploy-website.sh
```

### Step 4: Run Tests Again
```bash
npm test
```

**Healenium should automatically heal broken selectors!**

## 📁 Project Structure

```
hellenium-wdio-demo/
├── demo-website/           # Custom demo website
│   ├── index.html         # Login page
│   ├── welcome.html       # Welcome page
│   ├── Dockerfile         # Website container
│   ├── nginx.conf         # Web server config
│   └── docker-compose.yml # Website orchestration
├── test/
│   └── specs/
│       └── demo-website-test.spec.js  # Comprehensive test
├── docker-compose.yml     # Healenium infrastructure
├── wdio.conf.js          # WebDriverIO configuration
├── package.json          # Dependencies
├── start-demo.sh         # Start everything
├── stop-demo.sh          # Stop everything
├── redeploy-website.sh   # Redeploy website after changes
└── README.md             # This file
```

## 🔧 Manual Setup (Alternative)

If you prefer manual setup instead of using scripts:

### 1. Start Demo Website
```bash
cd demo-website
docker compose up -d --build
cd ..
```

### 2. Start Healenium Infrastructure
```bash
docker compose up -d
```

### 3. Install Dependencies
```bash
npm install
```

### 4. Run Tests
```bash
npm test
```

## 🎯 Test Scenarios

### Basic Login Test
- Navigate to login page
- Fill username and password
- Click login button
- Verify welcome page

### Self-Healing Test
- Use broken selectors (typos, wrong classes)
- Healenium automatically finds correct elements
- Tests pass despite selector changes

## 📊 Monitoring

### Live Browser View
- **VNC**: http://localhost:7900 (password: 123456)
- **Browser**: http://localhost:4444

### Healenium Reports
- **Main Report**: http://localhost:7878/healenium/report/
- **Selectors**: http://localhost:7878/healenium/selectors/

### Container Logs
```bash
# Demo website
docker logs healenium-demo-website

# Healenium backend
docker logs healenium

# Selenium Hub
docker logs selenium-hub
```

## 🛠️ Development

### Modify Website
1. Edit files in `demo-website/`
2. Run: `./redeploy-website.sh`
3. Test changes

### Add New Tests
1. Create new `.spec.js` file in `test/specs/`
2. Use broken selectors to test healing
3. Run: `npm test`

### Customize Healenium
- Edit `docker-compose.yml` for infrastructure changes
- Modify `wdio.conf.js` for WebDriverIO settings

### Demo Website Docker Commands
```bash
# Build demo website image
cd demo-website
docker build -t healenium-demo-website .

# Run demo website only
docker compose up -d

# Stop demo website
docker compose down

# View demo website logs
docker logs healenium-demo-website

# Clean rebuild demo website
docker compose down
docker system prune -f
docker compose up -d --build
cd ..
```

## 🔍 Troubleshooting

### Port Conflicts
If ports are busy, modify in respective `docker-compose.yml`:
```yaml
ports:
  - "8081:80"  # Change port number
```

### Container Issues
```bash
# Check container status
docker ps

# View logs
docker logs <container-name>

# Restart specific service
docker compose restart <service-name>
```

### Test Failures
1. Check if website is accessible: http://localhost:8080
2. Verify Healenium is running: http://localhost:7878
3. Check VNC for browser issues: http://localhost:7900

### Cache Issues
If you see old content after changes:
- Press Cmd+Shift+R (Mac) or Ctrl+Shift+R (Windows)
- Or open DevTools (F12) → right-click refresh → 'Empty Cache and Hard Reload'

## 📚 Learn More

- [Healenium Documentation](https://healenium.io/)
- [WebDriverIO Documentation](https://webdriver.io/)
- [Selenium Grid](https://www.selenium.dev/documentation/grid/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

---

**Happy Testing! 🧪✨**
