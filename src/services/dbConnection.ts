
import dotenv from "dotenv";
dotenv.config();
import mysql from 'mysql2/promise';

export async function dbConnection() {
  try {
    const connection = await mysql.createConnection({
      host: process.env.BD_HOST,
      user: process.env.BD_USERNAME,
      password: process.env.BD_PASSWORD,
      database: process.env.BD_NAME,
      port: Number(process.env.BD_PORT),
    });
    console.log('Base de datos conectada ... ');
    return connection;
  } catch (error: any) {
    throw new Error(error);
  }
}
