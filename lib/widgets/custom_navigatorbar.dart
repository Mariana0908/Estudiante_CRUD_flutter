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
      //Current Index, para determinar el botón que debe marcarse
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          estudiantesProvider.limpiarDatosAlEstudiante();
        }
        actualOptionProvider.selectedOption = i;
      },
      //Items
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded), label: "Lista de estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.add_reaction), label: "Crear un estudiante")
      ],
    );
  }
}
