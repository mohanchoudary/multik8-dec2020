FROM node:alpine as builder
WORKDIR '/app'
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html



FROM node:12.13-alpine As development

WORKDIR /usr/src/app

COPY package.json ./
RUN npm install --only=production
COPY . .
RUN npm run build

FROM nginx:1.16.0-alpine

RUN rm /etc/nginx/conf.d/default.conf
COPY /nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=development /usr/src/app/dist /usr/share/nginx/html

EXPOSE 3000