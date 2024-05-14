
# Backend Reto-UTP


## Descripcion del proyecto
Este es la aplicacion backend de un sistema de registro de solicitudes de cambio de notas




## Requerimientos
1. Nodejs v18.20.2
2. Mysql 8.1
3. Typescript 5.0
4. Docker



## Instalación de dependencias
***

```
$ npm install
```
## Ejecucion por container

```
$ docker build -t app-utp-backend .
$ docker compose up
```

## Conexion de Base de datos Mysql en caso falle en docker la conexion
 Por defecto estas son las configuraciones que tiene para conectarse:
 - BD_USERNAME="root"
 - BD_PASSWORD=""
 - BD_HOST="localhost"
 - BD_PORT=3306

## Creacion de Base de datos en caso falle en docker las conexion
```
$ CREATE DATABASE databaseutp;
$ USE databaseutp;
```
Luego importar el query que es el archivo "database.sql " y ejecutarlo.

## Desplegar aplicacion
```
$ npm run tsc
$ npm run start
```






## Ejecucion de pruebas
***
```
$ npx jest
```