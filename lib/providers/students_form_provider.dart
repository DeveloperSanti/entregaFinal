import 'package:flutter/material.dart';

import '../models/student_model.dart';

class StudentsFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Student student;

  StudentsFormProvider(this.student);

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
