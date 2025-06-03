import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';
import 'screens/admin/admin_dashboard.dart' as admin;
import 'screens/teacher/teacher_dashboard.dart';
import 'screens/student/student_dashboard.dart' as student;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aula Inteligente',
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginScreen(),
        '/admin': (_) => const admin.AdminDashboard(),
        // Estas rutas no usan usuario, así que se usan para pruebas (no producción)
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}
