// lib/widgets/app_drawer.dart
import 'package:flutter/material.dart';
import '../models/user.dart';

class AppDrawer extends StatelessWidget {
  final Usuario usuario;
  final Function(String ruta) onNavigate;

  const AppDrawer({
    super.key,
    required this.usuario,
    required this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final esProfesor = usuario.rol == 'teacher';

    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(usuario.username),
            accountEmail: Text(usuario.rol == 'teacher' ? 'Profesor' : 'Alumno'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 35),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Inicio'),
            onTap: () => onNavigate('/dashboard'),
          ),
          if (esProfesor) ...[
            ListTile(
              leading: Icon(Icons.grade),
              title: Text('Registro de notas'),
              onTap: () => onNavigate('/notas'),
            ),
            ListTile(
              leading: Icon(Icons.event_available),
              title: Text('Asistencias'),
              onTap: () => onNavigate('/asistencias'),
            ),
            ListTile(
              leading: Icon(Icons.record_voice_over),
              title: Text('Participaciones'),
              onTap: () => onNavigate('/participaciones'),
            ),
            ListTile(
              leading: Icon(Icons.analytics),
              title: Text('Predicciones IA'),
              onTap: () => onNavigate('/predicciones'),
            ),
          ],
          Spacer(),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuración'),
            onTap: () => onNavigate('/configuracion'),
          ),
        ],
      ),
    );
  }
}
