// lib/services/auth_service.dart
class AuthService {
  static Future<String?> login(String username, String password) async {
    // Simular llamada a API
    await Future.delayed(Duration(seconds: 2));

    // Datos simulados
    if (username == 'admin' && password == 'admin123') return 'admin';
    if (username == 'profesor' && password == 'prof123') return 'teacher';
    if (username == 'alumno' && password == 'alum123') return 'student';

    return null; // Error de autenticación
  }
}
