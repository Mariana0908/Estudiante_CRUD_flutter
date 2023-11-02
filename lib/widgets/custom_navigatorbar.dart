import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:notes_crud_local_app/providers/provider_estudiante.dart';
import 'package:provider/provider.dart';

class MenuUsuario extends StatelessWidget {
  const MenuUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final EstudiantesProvider estudiantesProvider =
        Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          estudiantesProvider.limpiarDatosAlEstudiante();
        }
        actualOptionProvider.selectedOption = i;
      },
      items: const <BottomNavigationBarItem>[
        //Para listar los dos elementos de la barra de navegación (botones)
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded), label: "Listar estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_reaction), label: "Crear un estudiante")
      ],
    );
  }
}
