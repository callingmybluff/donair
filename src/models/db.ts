import { Sequelize } from 'sequelize'

import config from '../config'
import Logger from '../util/logger';

console.log(config.db)

const connection = new Sequelize(config.db.name, config.db.username, config.db.password, {
  host: config.db.host,
  port: config.db.port,
  dialect: config.db.dialect,
  logging: Logger.debug.bind(Logger),
});

export default {
  getConnection: function (): Sequelize {
    return connection
  },
  connect: async function () {
    return connection.authenticate()
  },
  endConnection: async function () {
    return connection.close()
  },
  addToDB: async (app: string, amount: number) => {
    // connection.query('INSERT INTO ')
  }
}