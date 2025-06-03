// lib/screens/student/student_dashboard.dart
import 'package:flutter/material.dart';

// lib/screens/student/student_dashboard.dart
//import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';

class StudentDashboard extends StatelessWidget {
  final Usuario usuario = Usuario(username: 'Carlos', rol: 'student');

  StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Estudiante')),
      drawer: AppDrawer(
        usuario: usuario,
        selectedRoute: '/student/dashboard',
        onNavigate: (ruta) {
          Navigator.pop(context);
          Navigator.pushNamed(context, ruta);
        },
      ),
      body: const Center(
        child: Text('Bienvenido, Estudiante'),
      ),
    );
  }
}

