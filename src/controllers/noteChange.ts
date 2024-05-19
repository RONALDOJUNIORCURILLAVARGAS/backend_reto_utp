import { Request, Response } from "express";
import { dbConnection } from "../services/dbConnection";
import { RowDataPacket } from "mysql2";
import { SearchingFilters } from "../types/filters/SearchFilters";
import { changeNoteDto } from "../dtos";
import { validate } from "class-validator";


export const getFilters = async (req: Request, res: Response) => {
  try {
    const connection = await dbConnection();
    const { course, type_evaluation } = req.query;
    const [rows] = await connection.execute<RowDataPacket[]>(
      `CALL FiltroAlumnosDocente(?,?)`,
      [type_evaluation, course]
    );
    await connection.end();
    const students = rows[0].map((student: SearchingFilters) => {
      return {
        estado_solicitud_id: student.estado_solicitud_id == 1 ? true : false,
        alumno_nombres: student.alumno_nombres,
        alumno_apellidos: student.alumno_apellidos,
        alumno_codigo: student.alumno_codigo,
        nota_valor: student.nota_valor,
        tipo_evaluacion_id: student.tipo_evaluacion_id,
        tipo_evaluacion_nombre: student.tipo_evaluacion_nombre,
        solicitud_id: student.solicitud_id,
        nota_id: student.nota_id,
      };
    });

    res.status(200).json({ success: true, data: students });
  } catch (error) {
    return res.status(404).json({
      success: false,
      msg: "Consulte al administrador",
    });
  }
};

export const getCourseAndEvaluations = async (req: Request, res: Response) => {
  try {
    const { id } = req.params;
    const connection = await dbConnection();
    const [rows] = await connection.execute(`select * from tipo_evaluacion`);
    const typesEvaluation = rows;
    const [course] = await connection.execute<RowDataPacket[]>(
      `CALL ObtenerCursosPorUsuarioYRol(?, ?)`,
      [id, 1] //1:Rol Docente
    );
    await connection.end();

    const listCourse = course[0];
    res.status(200).json({
      success: true,
      data: {
        typesEvaluation,
        courses: listCourse,
      },
    });
  } catch (error) {
    return res.status(404).json({
      success: false,
      msg: "Consulte al administrador",
    });
  }
};

export const sendChangeNote = async (req: Request, res: Response) => {
  try {
    const { user_id, nota_id, nota_nueva } = req.body;
    if (!user_id || !nota_id || !nota_nueva || !req.file) {
      return res.status(404).json({
        success: false,
        msg: "Campos vacios",
      });
    }

    const loginUserDto = new changeNoteDto(
      Number(user_id),
      Number(nota_nueva),
      Number(nota_id)
    );
    //Validar tipo de datos en la entrada
    const errors = await validate(loginUserDto);
    if (errors.length) {
      return res.status(400).json({
        success: false,
        msg: "Campos errados",
      });
    }

    const urlImage = `${process.env.BASE_URL}/uploads/${req.file?.filename}`;
  
    const connection = await dbConnection();
    const [listCoordinador] = await connection.execute<RowDataPacket[]>(
      `select * from BuscarCoordinadorVista`
    );
    const coordinador = listCoordinador[0].usuario_id;
    const [rows] = await connection.execute<RowDataPacket[]>(`CALL InsertarSolicitud(?,?,?,?,?)`, [
      Number(user_id),Number(coordinador),Number(nota_nueva),urlImage,Number(nota_id)
    ]);
    
    await connection.end();
    res.status(200).json({
      success: true,
      data: {
        msg:"Registros actualizados"
      },
    });
  } catch (error:any) {
    return res.status(404).json({
      success: false,
      msg: "Consulte al administrador",
    });
  }
};
