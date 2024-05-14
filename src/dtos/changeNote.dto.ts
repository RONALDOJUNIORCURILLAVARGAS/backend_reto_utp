import {  IsInt } from "class-validator"

export class changeNoteDto {
    @IsInt()
    user_id :number;
    @IsInt()
    nota_nueva: number;
    @IsInt()
    nota_id: number;
    constructor( user_id: number, nota_nueva: number,nota_id: number) {
        this.user_id = user_id;
        this.nota_nueva = nota_nueva;
        this.nota_id = nota_id;
      }
}
