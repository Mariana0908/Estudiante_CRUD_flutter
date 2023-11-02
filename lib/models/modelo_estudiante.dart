//Crea un modelo para la clase, que permitirá definir las caracteristicas de nuetsros objetos (estudiante).

import 'dart:convert';

Estudiante estudianteFromJson(String str) =>
    Estudiante.fromJson(json.decode(str));

String estudianteToJson(Estudiante data) => json.encode(data.toJson());

class Estudiante {
  int? id;
  String documentoIdentidad;
  String nombre;
  String edad;

  Estudiante({
    this.id,
    required this.documentoIdentidad,
    required this.nombre,
    required this.edad,
  });

  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        id: json["id"],
        documentoIdentidad: json["documentoIdentidad"],
        nombre: json["nombre"],
        edad: json["edad"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "documentoIdentidad": documentoIdentidad,
        "nombre": nombre,
        "edad": edad,
      };
}
