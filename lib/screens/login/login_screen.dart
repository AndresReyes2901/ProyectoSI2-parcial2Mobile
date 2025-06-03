// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import '/../services/auth_service.dart';

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
