import express, { Application } from "express";
import userRoutes from "../routes/user";
import noteChangesRoutes from "../routes/noteChange";
import cors from "cors";
import multer from "multer";
import { diskStorage } from "multer";



class Server {
  private app: Application;
  private port: string;
  //Asignación de rutas
  private apiPaths = {
    usuarios: "/api/usuarios",
    noteChanges: "/api/noteChanges",
  };

  constructor() {
    this.app = express();
    this.port = process.env.PORT || "4001";
    this.middlewares();
    this.routes();
  }
  
  middlewares() {
    const storage = diskStorage({
      destination: function (req, file, cb) {
        cb(null, "public/uploads/");
      },
      filename: function (req, file, cb) {
        cb(null, file.originalname);
      },
    });
    const upload = multer({
      storage: storage,
      limits: {
        fileSize: 10 * 1024 * 1024, // 10 MB
      },
    });
    //Configuracion Multer como middleware
    this.app.use(upload.single("file"));

    //Configuracion CORS
    this.app.use(cors());

    this.app.use(express.json());

    //Carpeta publica
    this.app.use(express.static("public"));
  }
  routes() {
    this.app.use(this.apiPaths.usuarios, userRoutes);
    this.app.use(this.apiPaths.noteChanges, noteChangesRoutes);
  }

  listen() {
    this.app.listen(this.port, () => {
      console.log(`Servidor iniciado en puerto ${this.port}`);
    });
  }
}
export default Server;
