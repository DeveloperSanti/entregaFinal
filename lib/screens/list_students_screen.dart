import 'package:flutter/material.dart';
import 'package:students_api_crud_app/services/students_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';

class ListStudentsScreen extends StatelessWidget {
  const ListStudentsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ListStudents();
  }
}

class _ListStudents extends StatelessWidget {
  void displayDialog(
      BuildContext context, StudentsService studentService, String id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            elevation: 5,
            title: const Text('Alerta!'),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(10)),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('¿Quiere eliminar el registro?'),
                SizedBox(height: 10),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar')),
              TextButton(
                  onPressed: () {
                    studentService.deleteStudentById(id);
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  void showDeleteByIdDialog(Map<String, dynamic>? userData, String? uid) {
  TextEditingController _documentController = TextEditingController();

  if (userData == null) {
    print('ERROR: Datos del usuario son nulos.');
    return;
  }

  String user = userData['user'] ?? '';
  String document = userData['document']?.toString() ?? '';

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Eliminar por Documento'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Ingresa la ID del Estudiante (DOCUMENTO):'),
            TextField(
              controller: _documentController,
              decoration: InputDecoration(hintText: 'Número de Documento'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              String enteredDocument = _documentController.text.trim();
              if (enteredDocument.isNotEmpty) {
                print('Debug: Documento ingresado: $enteredDocument');
                print('Debug: Documento del usuario: $document');
                if (enteredDocument == document) {
                  print('Debug: Documentos coinciden, eliminando usuario...');
                  await deletePeople2(user ?? '', uid ?? '');
                  Navigator.pop(context);
                  setState(() {});
                  print('Debug: Usuario eliminado correctamente.');

                  // Muestra una alerta de éxito
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Éxito'),
                        content: Text('Usuario eliminado correctamente.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  print('ERROR: El documento ingresado no coincide.');

                  // Muestra una alerta de error
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text('Los datos ingresados no coinciden.'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Aceptar'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: const Text('Eliminar'),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    StudentsService studentService = Provider.of<StudentsService>(context);
    final students = studentService.students;

    return ListView.builder(
      itemCount: students.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.student),
        title: Text(students[index].title),
        subtitle: Text(students[index].id.toString()),
        trailing: PopupMenuButton(
          onSelected: (int i) {
            if (i == 0) {
              studentService.selectedStudent = students[index];
              Provider.of<ActualOptionProvider>(context, listen: false)
                  .selectedOption = 1;
              return;
            }

            displayDialog(context, studentService, students[index].id!);
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 0, child: Text('Actualizar')),
            const PopupMenuItem(value: 1, child: Text('Eliminar'))
          ],
        ),
      ),
    );
  }
}
