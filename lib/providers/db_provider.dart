//Crea mi base de datos
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

import '../models/modelo_estudiante.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory =
        await getApplicationDocumentsDirectory(); //dirección BD

    final path = join(documentsDirectory.path, 'EstudiantesDB.db');
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) => {},
      onCreate: (db, version) async {
        await db.execute('''

        CREATE TABLE estudiantes(
          id INTEGER PRIMARY KEY,
          documentoIdentidad TEXT,
          nombre TEXT,
          edad TEXT
        )

''');
      },
    );
  }

  Future<int> nuevoEstudianteRaw(Estudiante estudiante) async {
    final int? id = estudiante.id;
    final String documentoIdentidad = estudiante.documentoIdentidad;
    final String nombre = estudiante.nombre;
    final String edad = estudiante.edad;

    final db = await database;

    final int res = await db.rawInsert('''

      INSERT INTO estudiantes (id, documentoIdentidad, nombre, edad) VALUES ($id, "$documentoIdentidad", "$nombre", "$edad")

''');
    print(res);
    return res;
  }

  Future<int> nuevoEstudiante(Estudiante estudiante) async {
    final db = await database;

    final int res = await db.insert("estudiantes", estudiante.toJson());

    return res;
  }

  Future<Estudiante?> obtenerEstudianteId(int id) async {
    final Database db = await database;

    //usando Query para construir la consulta, con where y argumentos posicionales (whereArgs)
    final res = await db.query('estudiantes', where: 'id = ?', whereArgs: [id]);
    print(res);

    return res.isNotEmpty
        ? Estudiante.fromJson(res.first)
        : null; //si trae datos que los vuela json
  }

  Future<List<Estudiante>> obtenerTodosLosEstudiantes() async {
    final Database? db = await database;
    final res = await db!.query('estudiantes');
    return res.isNotEmpty
        ? res
            .map((n) => Estudiante.fromJson(n))
            .toList() //para hacer una lista con los datos que traiga
        : [];
  }

  Future<int> actualizarEstudiante(Estudiante estudiante) async {
    final Database db = await database;
    final res = await db.update('estudiantes', estudiante.toJson(),
        where: 'id = ?', whereArgs: [estudiante.id]);
    return res;
  }

  Future<int> eliminarEstudianteId(int id) async {
    final Database db = await database;
    final int res =
        await db.delete('estudiantes', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
