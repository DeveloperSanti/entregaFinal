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
