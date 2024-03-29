import {onRequest} from "firebase-functions/v2/https";
import * as admin from 'firebase-admin';
import * as logger from "firebase-functions/logger";
const { defineSecret } = require('firebase-functions/params');
const axios = require('axios');
const openAiKey = defineSecret('openai-key');
const endpoint = process.env.CHAT_URL;
admin.initializeApp();

export const chat = onRequest({ secrets: [openAiKey] },async(req, res) => {
    if (req.method !== 'POST') {
        logger.error('Invalid HTTP Method', req.method);
        res.status(400).send("Not supported");
        return;
    }

    try {
        const authHeader = req.get('Authorization');
        if (!authHeader) {
            throw new Error('Authorization header is not provided')!
        }

        const tokenId = authHeader.split('Bearer ')[1];
        if (!tokenId) {
            throw new Error('Auth token is empty');
        }

        const decodedToken = await admin.auth().verifyIdToken(tokenId);
        logger.info('Chat Requested by ', decodedToken.email);
    } catch(error: any) {
        logger.error('Chat auth', error);
        res.status(403).json({ error: 'Authorization failed, please pass the correct Authentication token in the header'});
    }

    const apiKey = openAiKey.value();
    try {
        const json = req.body;
        logger.info("Chat Payload", json);
        const headers = {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${apiKey}`
        };
        if (json.stream) {
            res.setHeader('Content-Type', 'text/event-stream');
            res.setHeader('Transfer-Encoding', 'chunked');
            res.setHeader('Cache-Control', 'no-cache, must-revalidate');
            res.setHeader('Connection', 'close');
            const response = await axios.post(endpoint, json, {
                headers,
                responseType: 'stream'
            });
            response.data.pipe(res)
        } else {
            const response = await axios.post(endpoint, json, {
                headers
            });
            res.status(response.status).json(response.data);
        }
    } catch(error: any) {
        logger.error('Chat Error', error.message);
        res.status(400).json({
            error: error.message
        });
    }
});
