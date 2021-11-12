import Express from 'express'

import Model from './mDonation'

const router = Express.Router()

router.post('/', (req: Express.Request, res: Express.Response) => {
  Model.post()
  res.status(201).json()
})
router.get('/', (req: Express.Request, res: Express.Response) => {
  res.status(200).send('donation is here')
})

export default router