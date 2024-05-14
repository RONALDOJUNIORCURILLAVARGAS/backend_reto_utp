import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
interface JwtPayload {
  usuario: string;
  usuario_id: number;
  rol: string;
  expiresIn: string;
  iat: number;
  exp: number;
}
const validateRol = (req: Request, res: Response, next: NextFunction) => {
  const headerToken = req.headers["authorization"];
  if (headerToken != undefined && headerToken.startsWith("Bearer ")) {
    //Extracción del token
    const bearerToken = headerToken.slice(7);
    try {
      const tokenValidate: JwtPayload = jwt.verify(
        bearerToken,
        process.env.SECRET_KEY_JWT!
      ) as JwtPayload;
      const rol = tokenValidate.rol;
      //Rechazar acceso si no es docente el que envia el token
      if(rol!=='docente') throw new Error();
      next();
    } catch (error) {
      return res.status(400).json({
        success: false,
        msg: "Token Invalido",
      });
    }
  } else {
    return res.status(400).json({
      success: false,
      msg: "Acceso denegado",
    });
  }
};
export default validateRol;
