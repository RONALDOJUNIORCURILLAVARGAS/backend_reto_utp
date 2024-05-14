export interface SearchingFilters {
  alumno_nombres: string;
  alumno_apellidos: string;
  alumno_codigo: string;
  nota_valor: number;
  tipo_evaluacion_id: number;
  tipo_evaluacion_nombre: string;
  estado_solicitud_id: number | null;
  solicitud_id: number | null;
  nota_id: number;
}

export interface CoordinatorSearch {
  usuario_id: number;
  usuario_nombres: string;
  usuario_alias: string;
  usuario_clave: string;
  usuario_fecha_creacion: Date;
  usuario_fecha_actualizacion: Date;
  rol_id: number;
  usuario_apellidos: string;
}
