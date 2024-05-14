import { Router } from "express";
import { getCourseAndEvaluations, getFilters, sendChangeNote } from "../controllers/noteChange";
import validateRol from "../middlewares/validateRol";


const router = Router();
router.get('/filters',validateRol,getFilters)
router.get('/techaerinformation/:id',validateRol,getCourseAndEvaluations)
router.post('/sendChangeNotes',validateRol,sendChangeNote)

export default router;
