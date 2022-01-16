import Express from 'express'
import Joi from 'joi'
import Logger from '../util/logger'

import { generatePayment } from '../controllers/donation'

const router = Express.Router()

router.post('/', async (req: Express.Request, res: Express.Response) => {
  const requestSchema = Joi.object({
    amount: Joi.number().required(),
    apps: Joi.array().items(
      Joi.object({
        app: Joi.string().required(),
        percentage: Joi.number().max(100).min(0).precision(2).required(),
      })
    ).required(),
  })
  const { error } = requestSchema.validate(req.body);
  if (error) {
    Logger.error(`Invalid request body ${error}`)
    res.status(500).send(error)
  } else
    res.status(201).send(await generatePayment(req.body))
})
router.get('/', (req: Express.Request, res: Express.Response) => {
  res.status(200).send('donation is here')
})

export default router