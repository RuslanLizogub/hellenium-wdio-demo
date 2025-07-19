exports.config = {
    // Указываем тесты
    specs: ['./test/specs/**/*.js'],
    
    // Максимум одновременных тестов
    maxInstances: 1,
    
    // Только Chrome
    capabilities: [{
        browserName: 'chrome',
        'goog:chromeOptions': {
            args: ['--no-sandbox', '--disable-dev-shm-usage']
        }
    }],
    
    // Уровень логирования
    logLevel: 'info',
    
    // Test runner services
    services: [],

    // Healenium Proxy Configuration
    hostname: '127.0.0.1',
    port: 8085,
    protocol: 'http',

    // Framework to use for testing
    framework: 'mocha',
    
    // Репортер
    reporters: ['spec'],
    
    // Настройки Mocha
    mochaOpts: {
        ui: 'bdd',
        timeout: 60000
    },
    
    // Хуки
    onPrepare: function () {
        console.log('🩹 Starting Healenium Demo...');
        console.log('📊 Report: http://localhost:7878/healenium/report/');
    },
    
    after: function () {
        console.log('✅ Demo completed!');
    }
}; 