import DotEnv from 'dotenv'
import { createHttpTerminator } from 'http-terminator'

import App from './app'
import Logger from './util/logger'

DotEnv.config()

process.on('unhandledRejection', (err) => {
  throw err;
});

Logger.debug('blaaaa')
Logger.fatal({
  NAMEE: 'maybeeee',
  lastname: 'useful'
})

const server = App.listen(process.env.PORT || 3000, () => {
  Logger.info(
    `started server on :${process.env.PORT || 3000} in ${process.env.NODE_ENV
    } mode`
  );
});

const httpTerminator = createHttpTerminator({ server });

const shutdownSignals = ['SIGTERM', 'SIGINT'];

shutdownSignals.forEach((signal) =>
  process.on(signal, async () => {
    Logger.info(`${signal} received, closing gracefully ...`);
    await httpTerminator.terminate();
  })
);

