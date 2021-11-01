FROM node:16.13.0-alpine3.11
ENV NODE_ENV=production
ADD . /usr/src/app
RUN ls /usr/src/app && \
    cd /usr/src/app && \
    yarn install --prod && \ 
    ls /usr/src/app && \
    rm -rf .yarn_mirror && \
    mv /usr/src/app/node_modules /tmp

FROM node:16.13.0-alpine3.11

ENV NODE_ENV=production
ENV PORT=80
COPY --from=0 /usr/src/app/bin /usr/src/app
COPY --from=0 /tmp/node_modules /usr/src/app/node_modules

CMD ["node", "/usr/src/app/app.js"]
