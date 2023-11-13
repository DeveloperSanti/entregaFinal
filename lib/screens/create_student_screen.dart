import 'package:flutter/material.dart';
import 'package:students_api_crud_app/services/students_service.dart';
import 'package:provider/provider.dart';

import '../providers/actual_option_provider.dart';
import '../providers/students_form_provider.dart';

class CreateStudentScreen extends StatelessWidget {
  const CreateStudentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StudentsService studentService = Provider.of(context);

    return ChangeNotifierProvider(
        create: (_) => StudentsFormProvider(studentService.selectedStudent),
        child: _CreateForm(studentService: studentService));
  }
}

class _CreateForm extends StatelessWidget {
  final StudentsService studentService;

  const _CreateForm({required this.studentService});

  @override
  Widget build(BuildContext context) {
    final StudentsFormProvider studentsFormProvider =
        Provider.of<StudentsFormProvider>(context);

    final student = studentsFormProvider.student;

    final ActualOptionProvider actualOptionProvider =
        Provider.of<ActualOptionProvider>(context, listen: false);
    return Form(
      key: studentsFormProvider.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            initialValue: student.title,
            decoration: const InputDecoration(
                hintText: 'Construir Apps',
                labelText: 'Titulo',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 8)),
            onChanged: (value) => studentsFormProvider.student.title = value,
            validator: (value) {
              return value != '' ? null : 'El campo no debe estar vacío';
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            maxLines: 10,
            autocorrect: false,
            initialValue: student.description,
            decoration: const InputDecoration(
              hintText: 'Aprender sobre Backend',
              labelText: 'Descripción',
            ),
            onChanged: (value) => student.description = value,
            validator: (value) {
              return (value != null) ? null : 'El campo no puede estar vacío';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            disabledColor: Colors.grey,
            elevation: 0,
            color: Colors.deepPurple,
            onPressed: studentService.isSaving
                ? null
                : () async {
                    FocusScope.of(context).unfocus();

                    if (!studentsFormProvider.isValidForm()) return;
                    await studentService
                        .createOrUpdate(studentsFormProvider.student);
                    actualOptionProvider.selectedOption = 0;
                  },
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  studentService.isLoading ? 'Esperar' : 'Ingresar',
                  style: const TextStyle(color: Colors.blue),
                )),
          )
        ],
      ),
    );
  }
}
