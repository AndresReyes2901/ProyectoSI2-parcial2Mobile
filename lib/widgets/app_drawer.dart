// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class AppDrawer extends StatelessWidget {
  final Usuario usuario;
  final String selectedRoute;
  final Function(String ruta) onNavigate;

  const AppDrawer({
    super.key,
    required this.usuario,
    required this.selectedRoute,
    required this.onNavigate,
  });

  Widget buildDrawerItem({
    required IconData icon,
    required String label,
    required String route,
  }) {
    final bool isSelected = selectedRoute == route;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => onNavigate(route),
        child: Container(
          decoration: isSelected
              ? BoxDecoration(
            color: Color(0xFF7E59C0), // morado seleccionado
            borderRadius: BorderRadius.circular(12),
          )
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(icon, color: isSelected ? Colors.white : Colors.black),
              SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final esProfesor = usuario.rol == 'teacher';
    return Drawer(
      backgroundColor: Color(0xFF52BC8B), // fondo verde claro
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFF52BC8B),
            ),
            accountName: Text(usuario.username, style: TextStyle(color: Colors.black)),
            accountEmail: Text(usuario.rol == 'teacher' ? 'Profesor' : 'Alumno', style: TextStyle(color: Colors.black)),
            //icono del avatar en el sidebar
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 35, color: Colors.black),
            ),
          ),
          buildDrawerItem(
            icon: Icons.dashboard,
            label: 'Dashboard',
            route: '/dashboard',
          ),
          if (usuario.rol=='teacher') ...[
            //buildDrawerItem(icon: Icons.people, label: 'Estudiantes', route: '/estudiantes'),
            //buildDrawerItem(icon: Icons.book, label: 'Materias', route: '/materias'),
            //buildDrawerItem(icon: Icons.class_, label: 'Cursos', route: '/cursos'),
            buildDrawerItem(icon: Icons.grade, label: 'Registro de Notas', route: '/notas'),
            buildDrawerItem(icon: Icons.event_available, label: 'Asistencias', route: '/asistencias'),
            buildDrawerItem(icon: Icons.record_voice_over, label: 'Participaciones', route: '/participaciones'),
            buildDrawerItem(icon: Icons.analytics, label: 'Predicciones IA', route: '/predicciones'),
          ],
          // Items para estudiante
          if (usuario.rol=='student') ...[
            buildDrawerItem(icon: Icons.dashboard, label: 'Dashboard', route: '/student/dashboard'),
          ],
          Spacer(),
          Divider(color: Colors.black54),
          buildDrawerItem(icon: Icons.settings, label: 'Configuración', route: '/configuracion'),
        ],
      ),
    );
  }
}
