import 'package:flutter/material.dart';
import 'package:notes_crud_local_app/providers/actual_option_provider.dart';
import 'package:provider/provider.dart';

import '../providers/provider_estudiante.dart';

class CrearEstudiantesScreen extends StatelessWidget {
  const CrearEstudiantesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CreateForm();
  }
}

class _CreateForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EstudiantesProvider estudiantesProvider =
        Provider.of<EstudiantesProvider>(context);
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: estudiantesProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            initialValue: estudiantesProvider.documentoIdentidad,
            decoration: const InputDecoration(
                hintText:
                    'Digite el documento de identidad', //Pista o placeholder
                labelText: 'Documento de identidad',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) =>
                estudiantesProvider.documentoIdentidad = value,
            validator: (value) {
              return value != ''
                  ? null
                  : 'ingrese su documento de identidad, no puede estar vacío';
            },
          ),
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.text,
            initialValue: estudiantesProvider.nombre,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Digite su nombre', //pista o placeholder
              labelText: 'Nombre',
            ),
            onChanged: (value) => estudiantesProvider.nombre = value,
            validator: (value) {
              return (value != null)
                  ? null
                  : 'ingrese su nombre, no puede estar vacío';
            },
          ),
          TextFormField(
            autocorrect: false,
            initialValue: estudiantesProvider.edad,
            // keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Digite su edad', //pista o placeholder
              labelText: 'Edad',
            ),
            onChanged: (value) => estudiantesProvider.edad = value,
            validator: (value) {
              return (value != null)
                  ? null
                  : 'ingrese su edad, no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.blue,
            onPressed: estudiantesProvider.isLoading
                ? null
                : () {
                    //Quitar teclado al terminar
                    FocusScope.of(context).unfocus();

                    if (!estudiantesProvider.isValidForm()) return;

                    if (estudiantesProvider.createOrUpdate == 'create') {
                      estudiantesProvider.agregarEstudiante();
                    } else {
                      estudiantesProvider.actualizarEstudiante();
                    }
                    estudiantesProvider.limpiarDatosAlEstudiante();
                    estudiantesProvider.isLoading = false;
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  estudiantesProvider.isLoading ? 'Espere' : 'Ingresar',
                  style: const TextStyle(color: Colors.white),
                )),
          )
        ],
      ),
    );
  }
}
