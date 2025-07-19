describe('Healenium Demo Website Test', () => {
    it('should login and verify welcome page', async () => {
        console.log('🩹 Starting Demo Website Test...');
        
        // Navigate to demo website
        // Use host.docker.internal to access host machine from Docker container
        await browser.url('http://host.docker.internal:8080');
        await browser.pause(10000);
        
        // Wait for page to load - check for any Healenium title
        await browser.waitUntil(async () => {
            const title = await browser.getTitle();
            return title.includes('Healenium');
        }, { timeout: 10000 });
        
        // Fill login form
        const usernameField = await $('#username');
        const passwordField = await $('#password');
        const loginButton = await $('button[type="submit"]');
        
        await usernameField.setValue('testuser');
        await passwordField.setValue('testpass');
        await browser.pause(3000);
        
        // Click login button
        await loginButton.click();
        await browser.pause(3000);
        
        // Verify we're on welcome page
        await browser.waitUntil(async () => {
            const title = await browser.getTitle();
            return title.includes('Welcome');
        }, { timeout: 10000 });
        
        // Verify welcome elements
        const welcomeMessage = await $('h1*=Welcome');
        const successMessage = await $('.success-message');
        const userInfo = await $('.user-info');
        const backButton = await $('.back-button');
        
        await expect(welcomeMessage).toBeDisplayed();
        await expect(successMessage).toBeDisplayed();
        await expect(userInfo).toBeDisplayed();
        await expect(backButton).toBeDisplayed();
        
        // Verify username is displayed
        const usernameDisplay = await $('#displayUsername');
        await expect(usernameDisplay).toHaveText('testuser');
        await browser.pause(3000);
        
        console.log('✅ Demo website test completed!');
    });
}); 