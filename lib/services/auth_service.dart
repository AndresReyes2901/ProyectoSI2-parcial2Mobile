// lib/services/auth_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://backendaisi2-production.up.railway.app/api';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // incluye token, usuario, rol, etc.
    } else {
      return null; // o lanzar una excepción personalizada
    }
  }
}

/*
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
*/