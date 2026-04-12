const express = require('express');
const Redis = require('ioredis');
const app = express();
app.use(express.json());
const redis = new Redis({ host: process.env.REDIS_HOST || 'localhost' });
app.get('/health', (req, res) => res.json({ status: 'healthy', service: 'cart' }));
app.listen(8080, () => console.log('Cart service on 8080'));
