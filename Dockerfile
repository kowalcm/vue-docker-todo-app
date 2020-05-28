FROM node:12.13.0-alpine

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

COPY package.json /app/package.json
RUN npm install
RUN npm install @vue/cli@4.3.1 -g

EXPOSE 8080
CMD ["npm", "run", "serve"]