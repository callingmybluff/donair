import Axios, { AxiosPromise, Method } from 'axios'
import QS from 'qs'

import config from '../config'
import Logger from './logger'

function _connect(path: string, method: Method, data: object) {
  return Axios({
    method: method,
    url: 'https://api.stripe.com' + path,
    data: QS.stringify(data),
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    auth: {
      username: config.stripe.secret,
      password: '',
    },
  })
    .catch((error) => {
      if (error.response) {
        Logger.error(error.response.data)
        Logger.error(error.response.status)
        Logger.error(error.response.headers)
      } else if (error.request)
        Logger.error(error.request)
      else
        Logger.error(error.message)
      throw Error()
    })
}

export default {
  POST: (path: string, data: object): AxiosPromise => _connect(path, 'post', data),
  GET: (path: string, data: object = {}) => _connect(path, 'get', data),
}
