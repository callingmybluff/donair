import express from 'express'
import Pino from 'pino-http'

import Logger from './util/logger'

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(Pino(Logger));

app.get('/api/health', (req, res) => res.send({ message: 'OK' }));

export default app;