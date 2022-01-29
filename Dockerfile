FROM node:17

WORKDIR /backend

COPY package.json /backend
COPY yarn.lock /backend

RUN yarn install

COPY . /backend

RUN yarn run build
CMD yarn run start
