import { Request, Response } from 'express';
import validateRol from '../../middlewares/validateRol';

describe('validateRol middleware', () => {
  let req: Partial<Request>;
  let res: Partial<Response>;
  let next: jest.Mock;

  beforeEach(() => {
    req = {
      headers: {      },
    };
    res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };
    next = jest.fn();
  });

 


  it('debería devolver 400 si no se proporciona ningún token', () => {
    delete req.headers!.authorization;
    validateRol(req as Request, res as Response, next);
    expect(res.status).toHaveBeenCalledWith(400);
    expect(res.json).toHaveBeenCalledWith({
      success: false,
      msg: 'Acceso denegado',
    });
    expect(next).not.toHaveBeenCalled();
  });

  it('debería devolver 400 si el token no se proporciona en formato Bearer', () => {
    req.headers!.authorization = 'InvalidFormat validToken';
    validateRol(req as Request, res as Response, next);
    expect(res.status).toHaveBeenCalledWith(400);
    expect(res.json).toHaveBeenCalledWith({
      success: false,
      msg: 'Acceso denegado',
    });
    expect(next).not.toHaveBeenCalled();
  });
});