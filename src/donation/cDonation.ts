import Express from 'express'

import Model from './mDonation'

const router = Express.Router()

router.post('/', async (req: Express.Request, res: Express.Response) => {
  await Model.generatePayment(314)
  res.status(201).json()
})
router.get('/', (req: Express.Request, res: Express.Response) => {
  res.status(200).send('donation is here')
})

export default router