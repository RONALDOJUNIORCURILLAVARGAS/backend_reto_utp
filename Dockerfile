
FROM node:18.0.0

WORKDIR /app
COPY package*.json ./

RUN npm install


COPY . .
RUN npm run tsc
EXPOSE 4050
CMD ["npm", "start"]