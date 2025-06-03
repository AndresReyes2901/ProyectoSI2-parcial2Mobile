// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '/../services/auth_service.dart';
import 'package:flutter/material.dart';
import '/../services/auth_service.dart';
import '/../models/user.dart';
import '../teacher/teacher_dashboard.dart';
import '../student/student_dashboard.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  String error = '';

  void login() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final result = await authService.login(username, password);
    if (result != null) {
      final user = Usuario.fromJson(result['user']);

      if (user.rol == 'teacher') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => TeacherDashboard(usuario: user)),
        );
      } else if (user.rol == 'student') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => StudentDashboard(usuario: user)),
        );
      }
    } else {
      setState(() => error = 'Usuario o contraseña incorrectos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: usernameController, decoration: InputDecoration(labelText: 'Usuario')),
            TextField(controller: passwordController, decoration: InputDecoration(labelText: 'Contraseña'), obscureText: true),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: login, child: const Text('Iniciar Sesión')),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(error, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}

//codigo de prueba-inicio sin las API

/*
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuario = TextEditingController();
  final TextEditingController _contrasena = TextEditingController();

  bool _cargando = false;
  String? _error;

  void _iniciarSesion() async {
    setState(() {
      _cargando = true;
      _error = null;
    });

    final rol = await AuthService.login(_usuario.text, _contrasena.text);

    setState(() => _cargando = false);

    if (rol != null) {
      switch (rol) {
        case 'admin':
          Navigator.pushNamed(context, '/admin');
          break;
        case 'teacher':
          Navigator.pushNamed(context, '/teacher');
          break;
        case 'student':
          Navigator.pushNamed(context, '/student');
          break;
      }
    } else {
      setState(() {
        _error = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _usuario,
              decoration: InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: _contrasena,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Contraseña'),
            ),
            SizedBox(height: 20),
            if (_error != null)
              Text(_error!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _cargando ? null : _iniciarSesion,
              child: _cargando
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Iniciar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
*/

