FROM node:17

WORKDIR /backend
ARG API_KEY
ARG DB_USERNAME
ARG DB_PASSWORD
ARG DB_PORT
ARG DB_HOST
ARG DB_DIALECT
ARG STRIPE_PUBKEY
ARG STRIPE_SECRET

COPY package.json /backend
COPY yarn.lock /backend

RUN yarn install

COPY . /backend

RUN yarn run build
CMD yarn run start
