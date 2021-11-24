import { createHttpTerminator } from 'http-terminator'
import { Server } from 'http'

import App from './app'
import Logger from './util/logger'
import Config from './config'
import DB from './db/model'

process.on('unhandledRejection', (err) => {
  throw err;
});


async function appStart(): Promise<Server> {
  return new Promise((resolve) => {
    const server = App.listen(Config.port, () => {
      Logger.info(
        `started server on :${Config.port} in ${Config.env} mode`
      );
      resolve(server)
    });
  })
}

DB.connect()
  .catch((e) => {
    Logger.debug(e)
    Logger.error('Error connecting to DB')
    process.exit(1)
  })
  .then(() => DB.verify())
  .catch((e) => {
    Logger.debug(e)
    Logger.error('Error adding to DB')
    process.exit(1)
  })
  .then(() => appStart())
  .catch((e) => {
    Logger.debug(e)
    Logger.error('Error starting the application')
    process.exit(1)
  })
  .then((server: Server) => {
    const httpTerminator = createHttpTerminator({ server });

    const shutdownSignals = ['SIGTERM', 'SIGINT'];

    shutdownSignals.forEach((signal) =>
      process.on(signal, async () => {
        Logger.info(`${signal} received, closing gracefully ...`)
        await DB.endConnection()
        await httpTerminator.terminate()
      })
    );
  })
