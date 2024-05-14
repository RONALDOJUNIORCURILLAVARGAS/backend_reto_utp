
FROM node:18.0.0

# Estableciendo la variable de entorno PORT
ENV PORT=4050
ENV BASE_URL=http://localhost:4050

# Variables de entorno de base de datos
ENV BD_NAME="databaseutp"
ENV BD_USERNAME="root"
ENV BD_PASSWORD="root"
ENV BD_HOST="localhost"
ENV BD_PORT="3306"

ENV SECRET_KEY_JWT="c7&5ux#8pa3ay-kUS2Ok"


WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run tsc
EXPOSE 4050
CMD ["npm", "start"]