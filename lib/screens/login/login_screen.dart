// lib/screens/login/login_screen.dart

import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../models/user.dart';
import '../teacher/teacher_dashboard.dart';
import '../student/student_dashboard.dart' as student;
import '../admin/admin_dashboard.dart'; // Si tienes un dashboard de admin

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
  bool isLoading = false;

  void login() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      error = '';
      isLoading = true;
    });

    final result = await authService.login(username, password);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (result != null && result.containsKey('user')) {
      final user = Usuario.fromJson(result['user']);

      switch (user.rol) {
        case 'admin':
          //Navigator.pushReplacement(
            //context,
            //MaterialPageRoute(builder: (_) => AdminDashboard(usuario: user)),
          //);
          break;
        case 'teacher':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => TeacherDashboard(usuario: user)),
          );
          break;
        case 'student':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => student.StudentDashboard(usuario: user)),
          );
          break;
        default:
          setState(() => error = 'Rol no reconocido: ${user.rol}');
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
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: login,
              child: const Text('Iniciar Sesión'),
            ),
            if (error.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
