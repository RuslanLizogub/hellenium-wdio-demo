describe('Simple Healenium Demo', () => {
    it('should search Google and show self-healing', async () => {
        console.log('🩹 Starting Healenium Demo...');
        
        // Go to Google
        await browser.url('https://www.google.com');
        await browser.pause(10000);
        
        // Handle cookie popup if exists
        try {
            const acceptBtn = await $('button*=Accept');
            if (await acceptBtn.isDisplayed()) {
                await acceptBtn.click();
            }
        } catch (e) {
            // No cookies popup
        }
        
        // Find search box (Healenium will heal if this breaks)
        const searchBox = await $('[name="q"]');
        await searchBox.setValue('Healenium demo');
        await browser.pause(10000);
        
        // Press Enter
        await browser.keys('Enter');
        
        // Wait for results
        await browser.waitUntil(async () => {
            const title = await browser.getTitle();
            return title.includes('Healenium');
        }, { timeout: 10000 });
        
        console.log('✅ Test completed! Check healing report at http://localhost:7878/healenium/report/');
    });
}); 