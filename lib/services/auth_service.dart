// lib/services/auth_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = 'https://backendaisi2-production.up.railway.app/api';

  Future<Map<String, dynamic>?> login(String username, String password) async {
    final url = Uri.parse('$baseUrl/auth/login');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      print('Código de estado: ${response.statusCode}');
      print('Cuerpo de la respuesta: ${response.body}');

      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Espera JSON con token, user, rol, etc.
      } else {
        return null;
      }
    } catch (e) {
      print('Error en la solicitud de login: $e');
      return null;
    }
  }
}
