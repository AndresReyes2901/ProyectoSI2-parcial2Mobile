// lib/screens/student/student_dashboard.dart
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';

class StudentDashboard extends StatelessWidget {
  final Usuario usuario;

  const StudentDashboard({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Estudiante')),
      drawer: AppDrawer(
        usuario: usuario,
        selectedRoute: '/student/dashboard',
        onNavigate: (ruta) {
          Navigator.pop(context); // Cierra el drawer
          Navigator.pushNamed(context, ruta); // Navega a la ruta seleccionada
        },
      ),
      body: Center(
        child: Text('Bienvenido, ${usuario.username}'),
      ),
    );
  }
}
