import MySQL from 'mysql'

import config from '../config';

const connection = MySQL.createConnection({
  host     : config.db.host,
  user     : config.db.username,
  password : config.db.password,
  database : config.db.name,
  port: config.db.port,
  ssl: {
    rejectUnauthorized: false,
  },
});

async function query(queryString: string): Promise<boolean> {
  return new Promise((resolve, reject) => {
    connection.query(queryString, (err) => {
      if (err)
        reject(err)
      else
        resolve(true)
    })
  })
}

async function querySequential(queryStrings: string[]): Promise<boolean> {
  queryStrings.forEach(async (queryString) => {
    try {
      await query(queryString)
    }
    catch (e) {
      return e
    }
  })
  return true
}

export default {
  connect: async function (): Promise<boolean> {
    return new Promise((resolve, reject) => {
      connection.connect(err => {
        if (err)
          reject(err)
        else
          resolve(true)
      })
    })
  },
  endConnection: async () => {
    return new Promise((resolve, reject) => {
      connection.end((err) => {
        if (err)
          reject(err)
        else
          resolve(err)
      })
    })
  },
  verify: async (): Promise<boolean> => {
    return querySequential([
      //Maintain the order please. Repsect the foreign keys
      `CREATE TABLE IF NOT EXISTS bill {
        ID INT PRIMARY KEY AUTO_INCREMENT,
        AMOUNT DECIMAL(10, 4) NOT NULL,
        DATE_TIME DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
      }`,
      `CREATE TABLE IF NOT EXISTS outcome {
        ID INT PRIMARY KEY AUTO_INCREMENT,
        APP VARCHAR(255) NOT NULL,
        PERCENTAGE DECIMAL(10, 4) NOT NULL,
        BILL INT NOT NULL FOREIGN KEY REFERENCES bill(ID)
      }`,
    ])
  },
  addToDB: async (app: string, amount: number) => {
    // connection.query('INSERT INTO ')
  }
}