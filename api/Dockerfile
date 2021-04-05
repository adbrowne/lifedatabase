FROM node:14.16.0-alpine3.12 AS builder
WORKDIR /usr/src/app
COPY package*.json ./
RUN yarn install
COPY tsconfig*.json ./
COPY src src
COPY build-protos.sh ./
RUN yarn run tsc

FROM node:14.16.0-alpine3.12
ENV NODE_ENV=production

ENV PORT=9000
WORKDIR /usr/src/app

COPY package*.json ./
RUN yarn install
COPY --from=builder /usr/src/app/dist/ .

ENTRYPOINT [ "node", "/usr/src/app/index.js" ]