import dotenv from "dotenv";
import Server from "./models/server";

//Configuracion .env
dotenv.config();


//Inicialización de server
const server = new Server();
server.listen();
