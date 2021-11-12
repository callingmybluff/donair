import express from 'express'
import Pino from 'pino-http'

import Logger from './util/logger'
import Donation from './donation/cDonation'

const app = express();

app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(Pino(Logger))

app.use('/api/donation', Donation)

export default app;