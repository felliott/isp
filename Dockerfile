FROM node:carbon

RUN mkdir -p /code
COPY . /code
COPY .env /code/.env

RUN rm -rf /code/lib/.git

RUN yarn global add bower

WORKDIR /code
RUN yarn install --pure-lockfile --no-cache --network-concurrency 1 && bower install --allow-root

WORKDIR /code/lib/exp-player
RUN yarn --pure-lockfile --no-cache --network-concurrency 1 && bower install --allow-root

WORKDIR /code/lib/exp-models
RUN yarn --pure-lockfile --no-cache --network-concurrency 1 && bower install --allow-root

WORKDIR /code

CMD ["./node_modules/.bin/ember", "serve"]
