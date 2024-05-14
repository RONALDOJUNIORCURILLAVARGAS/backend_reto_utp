import { Request, Response } from "express";
import { LoginUserDto } from "../dtos";
import { isArray, validate } from "class-validator";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { dbConnection } from "../services/dbConnection";
import { RowDataPacket } from "mysql2";

export const loginUser = async (req: Request, res: Response) => {
  const { body } = req;
  try {
    const { user, password } = body;
    const loginUserDto = new LoginUserDto(user, password);
    //Validar tipo de datos en la entrada
    const errors = await validate(loginUserDto);

    if (errors.length) {
      return res.status(400).json({
        success: false,
        msg: "Campos errados",
      });
    }
    const connection = await dbConnection();
    const [rows] = await connection.execute<RowDataPacket[]>(
      `SELECT *
      FROM UsuarioRolVista
      WHERE usuario_alias = ?`,
      [user]
    );
    await connection.end();
    const existeUser = isArray(rows) && rows.length > 0 ? rows[0] : null;
    if (!existeUser) {
      return res.status(400).json({
        success: false,
        msg: "No existe un usuario con el alias : " + user,
      });
    }
    const {
      usuario_id,
      usuario_nombres,
      usuario_alias,
      usuario_clave,
      usuario_apellidos,
      rol_nombre,
    } = existeUser;

    const resultCompare = await bcrypt.compare(password, usuario_clave || "");
    //Error Login
    if (!resultCompare) {
      return res.status(200).json({
        success: false,
        msg: "Usuario y/o contraseña incorrecta",
      });
    }
    //GENERAR TOKEN
    const token = jwt.sign(
      {
        usuario: usuario_alias,
        usuario_id: usuario_id,
        rol: rol_nombre,
        expiresIn: "60d",
      },
      process.env.SECRET_KEY_JWT!,
      {
        expiresIn: "60d",
      }
    );

    res.json({
      success: true,
      msg: "Ëxito de login",
      data: {
        user_firstname: usuario_nombres,
        user_lastname: usuario_apellidos,
        user_id: usuario_id,
        user_rol: rol_nombre,
        user_token: token,
      },
    });
  } catch (error) {
    res.status(400).json({
      success: false,
      msg: "consulte al administrador",
    });
  }
};
