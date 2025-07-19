exports.config = {
    // Test specifications
    specs: ['./test/specs/**/*.js'],
    
    // Maximum number of simultaneous tests
    maxInstances: 1,
    
    // Chrome browser only
    capabilities: [{
        browserName: 'chrome',
        'goog:chromeOptions': {
            args: ['--no-sandbox', '--disable-dev-shm-usage']
        }
    }],
    
    // Log level
    logLevel: 'info',
    
    // Test runner services
    services: [],

    // Healenium Proxy Configuration
    hostname: '127.0.0.1',
    port: 8085,
    protocol: 'http',

    // Framework to use for testing
    framework: 'mocha',
    
    // Reporter
    reporters: ['spec'],
    
    // Mocha options
    mochaOpts: {
        ui: 'bdd',
        timeout: 60000
    },
    
    // Hooks
    onPrepare: function () {
        console.log('🩹 Starting Healenium Demo...');
        console.log('📊 Report: http://localhost:7878/healenium/report/');
    },
    
    after: function () {
        console.log('✅ Demo completed!');
    }
}; 