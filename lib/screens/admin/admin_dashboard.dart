// lib/screens/admin_dashboard.dart
import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel Administrador')),
      body: Center(child: Text('Bienvenido, Administrador')),
    );
  }
}

// lib/screens/teacher_dashboard.dart
class TeacherDashboardPrueba extends StatelessWidget {
  const TeacherDashboardPrueba({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel Profesor')),
      body: Center(child: Text('Bienvenido, Profesor')),
    );
  }
}

// lib/screens/student_dashboard.dart
class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel Alumno')),
      body: Center(child: Text('Bienvenido, Alumno')),
    );
  }
}
