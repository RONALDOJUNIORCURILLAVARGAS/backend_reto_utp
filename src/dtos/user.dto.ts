
import { IsString, IsEmail } from 'class-validator';

export class LoginUserDto{
  @IsString()
  user: string;
  @IsString()
  password: string;
  constructor( user: string, password: string) {
    this.user = user;
    this.password = password;
  }
}
