// lib/screens/teacher/dashboard.dart (ejemplo)
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';

class TeacherDashboard extends StatelessWidget {
  final Usuario usuario = Usuario(username: 'Carlos', rol: 'teacher');

  TeacherDashboard({super.key});

  void navegar(BuildContext context, String ruta) {
    Navigator.pop(context); // cerrar el drawer
    Navigator.pushNamed(context, ruta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Panel Profesor')),
      drawer: AppDrawer(
        usuario: usuario,
        onNavigate: (ruta) => navegar(context, ruta),
      ),
      body: Center(child: Text('Bienvenido, Profesor')),
    );
  }
}
