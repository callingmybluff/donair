import Express from 'express'
import config from '../config'

export default {
  verify: function (req: Express.Request, res: Express.Response, next: Express.NextFunction) {
    if (req.headers.authorization !== config.apiKey)
      res.sendStatus(401)
    else
      next()
  }
}