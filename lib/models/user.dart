// lib/models/user.dart
class Usuario {
  final String username;
  final String rol;

  Usuario({required this.username, required this.rol});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      username: json['username'],
      rol: json['rol'],
    );
  }
}

/*
class Usuario {
  final String username;
  final String rol;

  Usuario({required this.username, required this.rol});
}
*/