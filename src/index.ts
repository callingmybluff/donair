import { createHttpTerminator } from 'http-terminator'

import App from './app'
import Logger from './util/logger'
import Config from './config'

process.on('unhandledRejection', (err) => {
  throw err;
});

const server = App.listen(Config.port, () => {
  Logger.info(
    `started server on :${Config.port} in ${Config.env} mode`
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

