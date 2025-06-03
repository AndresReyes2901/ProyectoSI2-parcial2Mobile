// lib/screens/teacher/dashboard.dart (ejemplo)
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';
// lib/screens/teacher/dashboard.dart
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';
import 'registro_notas.dart';
import 'asistencia.dart';
import 'participaciones.dart';
import 'prediccionesrendimiento.dart';
import 'package:flutter/material.dart';
import '../../models/user.dart';
import '../../widgets/app_drawer.dart';

class TeacherDashboard extends StatelessWidget {
  final Usuario usuario;

  const TeacherDashboard({Key? key, required this.usuario}) : super(key: key);

  void navegar(BuildContext context, String ruta) {
    Navigator.pop(context); // cerrar el drawer
    Navigator.pushNamed(context, ruta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Profesor')),
      drawer: AppDrawer(
        usuario: usuario,
        selectedRoute: '/dashboard',
        onNavigate: (ruta) {
          Navigator.pop(context);
          Navigator.pushNamed(context, ruta);
        },
      ),
      body: Center(child: Text('Bienvenido, ${usuario.username}')),
    );
  }
}

/*
class TeacherDashboard extends StatefulWidget {
  const TeacherDashboard({super.key});

  @override
  State<TeacherDashboard> createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  final Usuario usuario = Usuario(username: 'Carlos', rol: 'teacher');

  String _selectedRoute = '/dashboard';

  void _navegar(String ruta) {
    setState(() {
      _selectedRoute = ruta;
    });
  }

  Widget _getSelectedScreen() {
    switch (_selectedRoute) {
      case '/notas':
        return const RegistroNotasScreen();
      case '/asistencias':
        return const AsistenciaScreen();
      case '/participaciones':
        return const ParticipacionesScreen();
      case '/predicciones':
        return const PrediccionesRendimientoScreen();
      default:
        return const Center(child: Text('Bienvenido, Profesor'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Panel Profesor')),
      drawer: AppDrawer(
        usuario: usuario,
        selectedRoute: _selectedRoute,
        onNavigate: _navegar,
      ),
      body: _getSelectedScreen(),
    );
  }
}
*/
