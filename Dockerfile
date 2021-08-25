FROM node:14.17-alpine AS build

WORKDIR /api

COPY src .

RUN npm i && npm run build

FROM node:14.17-alpine

WORKDIR /api

COPY --from=build /api/dist ./dist
COPY src/package* ./

RUN npm ci

ENTRYPOINT [ "npm" ]
CMD [ "start" ]