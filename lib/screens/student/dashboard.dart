// lib/screens/student/student_dashboard.dart
import 'package:flutter/material.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel Estudiante')),
      body: Center(child: Text('Bienvenido, Estudiante')),
    );
  }
}
