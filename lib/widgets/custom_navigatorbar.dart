import 'package:flutter/material.dart';
import 'package:students_api_crud_app/models/student_model.dart';
import 'package:students_api_crud_app/services/students_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context);
    final StudentsService studentService = Provider.of(context, listen: false);
    final currentIndex = actualOptionProvider.selectedOption;

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int i) {
        if (i == 1) {
          studentService.selectedStudent = Student(title: '', description: '');
        }
        actualOptionProvider.selectedOption = i;
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.list), label: "Listar Estudiantes"),
        BottomNavigationBarItem(
            icon: Icon(Icons.post_add_rounded), label: "Crear Estudiante")
      ],
    );
  }
}
