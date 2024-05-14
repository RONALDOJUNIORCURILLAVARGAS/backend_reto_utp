export interface FindUser {
  usuario_id?: number;
  usuario_nombres?: string;
  usuario_apellidos?: string;
  usuario_alias?: string;
  usuario_clave?: string;
  usuario_fecha_creacion?: Date;
  usuario_fecha_actualizacion?: Date;
  rol_id?: number;
}
export type SearchFindUser = FindUser | null;

