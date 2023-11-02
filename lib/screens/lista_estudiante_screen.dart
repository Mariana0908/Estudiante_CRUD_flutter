import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/provider_estudiante.dart';

class ListaEstudiantesScreen extends StatelessWidget {
  const ListaEstudiantesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListaEstudiantes();
  }
}

class _ListaEstudiantes extends StatelessWidget {
  void mostrarAletarEliminar(
      //modal: muestra encima de la pantalla principal
      BuildContext context,
      EstudiantesProvider estudiantesProvider,
      int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Eliminar!'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Desea eliminar de forma permanente el registro?'),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    estudiantesProvider.borrarEstudianteId(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  void mostarInformacionEstudiante(
      //modal: muestra encima de la pantalla principal
      BuildContext context,
      List estudiantes,
      int index) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Estudiante'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nombre:  ' +
                    estudiantes[index].nombre +
                    '\nDoc. Ident:  ' +
                    estudiantes[index].documentoIdentidad +
                    '\nEdad:  ' +
                    estudiantes[index]
                        .edad), //concateno el texto con los saltos de linea
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Ok'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    EstudiantesProvider estudiantesProvider =
        Provider.of<EstudiantesProvider>(context);

    final estudiantes = estudiantesProvider.estudiantes; //Llamado a la clase

    return ListView.builder(
      itemCount: estudiantes.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.face),
        title: Text(estudiantes[index].nombre),
        subtitle: Text(estudiantes[index].documentoIdentidad),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () => {
                      estudiantesProvider.createOrUpdate = "update",
                      estudiantesProvider
                          .asignarDatosAlEstudiante(estudiantes[index]),
                      Provider.of<ActualOptionProvider>(context, listen: false)
                          .selectedOption = 1
                    },
                icon: Icon(Icons.edit)),
            IconButton(
                onPressed: () => {
                      mostrarAletarEliminar(
                          context, estudiantesProvider, estudiantes[index].id!)
                    },
                icon: Icon(Icons.delete_forever_outlined)),
            IconButton(
                onPressed: () =>
                    {mostarInformacionEstudiante(context, estudiantes, index)},
                icon: Icon(Icons.person)),
          ],
        ),
      ),
    );
  }
}
