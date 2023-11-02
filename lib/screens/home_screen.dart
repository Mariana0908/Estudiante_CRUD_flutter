import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/provider_estudiante.dart';
import 'package:notes_crud_local_app/screens/crear_estudiante_screen.dart';
import 'package:notes_crud_local_app/screens/lista_estudiante_screen.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../widgets/custom_navigatorbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Base de datos - Estudiantes")),
        ),
        body: _HomeScreenBody(),
        bottomNavigationBar: const MenuUsuario());
  }
}

class _HomeScreenBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);

    int selectedOption = actualOptionProvider.selectedOption;

    switch (selectedOption) {
      case 0:
        return const ListaEstudiantesScreen();
      case 1:
        return const CrearEstudiantesScreen();
      default:
        return const ListaEstudiantesScreen();
    }
  }
}
