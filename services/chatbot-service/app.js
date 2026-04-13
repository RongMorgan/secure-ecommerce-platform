const express = require('express');
const axios = require('axios');
const app = express();
app.use(express.json());

app.post('/chat', async (req, res) => {
    const userMsg = req.body.message.toLowerCase();
    
    if (userMsg.includes('inventory') || userMsg.includes('stock')) {
        try {
            const products = await axios.get('http://product-service:80/products');
            const count = products.data.length;
            res.json({ reply: `I scanned the database. We currently have ${count} items in stock.` });
        } catch (err) {
            res.json({ reply: "I'm having trouble accessing the product database right now." });
        }
    } else {
        res.json({ reply: "I am the SECURE_STORE Assistant. Ask me about our 'inventory'!" });
    }
});

app.listen(8080, () => console.log('Chatbot listening on 8080'));
