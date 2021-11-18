import Express from 'express'
import Joi from 'joi'
import Logger from '../util/logger'

import Model from './mDonation'

const router = Express.Router()

router.post('/', async (req: Express.Request, res: Express.Response) => {
  const requestSchema = Joi.object()
    .keys({
      amount: Joi.number().required(),
    })
  const { error } = requestSchema.validate(req.body);
  if (error) {
    Logger.error(`Invalid request body ${error}`)
    res.status(500).send(error)
  } else
    res.status(201).send(await Model.generatePayment(req.body.amount))
})
router.get('/', (req: Express.Request, res: Express.Response) => {
  res.status(200).send('donation is here')
})

export default router