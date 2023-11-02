import 'package:flutter/material.dart';

import '../models/modelo_estudiante.dart';
import 'db_provider.dart';

class EstudiantesProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String createOrUpdate = 'create';
  int? id;
  String documentoIdentidad = '';
  String nombre = '';
  String edad = '';

  bool _isLoading = false;
  List<Estudiante> estudiantes = [];

  bool get isLoading => _isLoading;

  set isLoading(bool opc) {
    _isLoading = opc;
  }

  bool isValidForm() {
    print(formKey.currentState?.validate());

    return formKey.currentState?.validate() ?? false;
  }

  agregarEstudiante() async {
    final Estudiante estudiante = Estudiante(
        documentoIdentidad: documentoIdentidad, nombre: nombre, edad: edad);
    print(estudiante);

    final id = await DBProvider.db.nuevoEstudiante(estudiante);

    estudiante.id = id;

    estudiantes.add(estudiante);

    notifyListeners();
  }

  cargarEstudiantes() async {
    final List<Estudiante> estudiantes =
        await DBProvider.db.obtenerTodosLosEstudiantes();
    //operador Spreed
    this.estudiantes = [...estudiantes];
    notifyListeners();
  }

  actualizarEstudiante() async {
    final estudiante = Estudiante(
        id: id,
        documentoIdentidad: documentoIdentidad,
        nombre: nombre,
        edad: edad);
    final res = await DBProvider.db.actualizarEstudiante(estudiante);
    print("Id actualizado: $res");
    cargarEstudiantes();
  }

  borrarEstudianteId(int id) async {
    final res = await DBProvider.db.eliminarEstudianteId(id);
    print("Estudiante borrado: $res");
    cargarEstudiantes();
  }

  asignarDatosAlEstudiante(Estudiante estudiante) {
    id = estudiante.id;
    documentoIdentidad = estudiante.documentoIdentidad;
    nombre = estudiante.nombre;
    edad = estudiante.edad;
  }

  limpiarDatosAlEstudiante() {
    id = null;
    documentoIdentidad = '';
    nombre = '';
    edad = '';
    createOrUpdate = 'create';
  }
}
