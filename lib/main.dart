import 'package:flutter/material.dart';
import 'package:students_api_crud_app/providers/actual_option_provider.dart';
import 'package:students_api_crud_app/screens/home_screen.dart';
import 'package:students_api_crud_app/services/students_service.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ActualOptionProvider()),
          ChangeNotifierProvider(create: (_) => StudentsService())
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Estudiantes',
            initialRoute: "main",
            routes: {'main': (_) => const HomeScreen()}));
  }
}
