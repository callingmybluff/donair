import Joi from 'joi'
import DotEnv from 'dotenv'

import Logger from './util/logger'

DotEnv.config();

const schema = Joi.object()
  .keys({
    NODE_ENV: Joi.string()
      .valid("development", "test", "production")
      .default("development"),
    PORT: Joi.number().port().default(3000),
    DONAIR_API_KEY: Joi.string().required(),
    STRIPE_PUBKEY: Joi.string().regex(/^pk_test_[a-zA-Z0-9]+$/).required(),
    STRIPE_SECRET: Joi.string().regex(/^sk_test_[a-zA-Z0-9]+$/).required(),
    DB_NAME: Joi.string().required(),
    DB_PORT: Joi.number().port().required(),
    DB_USERNAME: Joi.string().required(),
    DB_PASSWORD: Joi.string().required(),
    DB_HOST: Joi.string().required(),
    DB_DIALECT: Joi.string().required(),
  })
  .unknown();

function validateConfig(schema: Joi.Schema) {
  const { value, error } = schema.validate(process.env);
  if (error) {
    Logger.error(`Invalid environment: ${error.message}`);
  }
  return value;
}

const env = validateConfig(schema)
Logger.warn(env)
export default {
  env: env.NODE_ENV as "development" | "test" | "production",
  port: env.PORT as number,
  apiKey: env.DONAIR_API_KEY,
  stripe: {
    publisherKey: env.STRIPE_PUBKEY as string,
    secret: env.STRIPE_SECRET as string,
  },
  db: {
    name: env.DB_NAME,
    host: env.DB_HOST,
    port: env.DB_PORT,
    username: env.DB_USERNAME,
    password: env.DB_PASSWORD,
    dialect: env.DB_DIALECT,
  }
}
