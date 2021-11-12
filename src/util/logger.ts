import pino from 'pino'

let Logger: pino.Logger

if (process.env.NODE_ENV === 'production')
  Logger = pino()
else
  Logger = pino({
    level: 'debug',
    transport: {
      target: 'pino-pretty',
      options: {
        colorize: true
      }
    }
  })
export default Logger;