import 'package:flutter/material.dart';

class AsistenciaScreen extends StatefulWidget {
  const AsistenciaScreen({Key? key}) : super(key: key);

  @override
  State<AsistenciaScreen> createState() => _AsistenciaScreenState();
}

class _AsistenciaScreenState extends State<AsistenciaScreen> {
  List<Map<String, dynamic>> estudiantes = [
    {'nombre': 'Juan Pérez', 'asistio': true},
    {'nombre': 'María López', 'asistio': false},
    {'nombre': 'Carlos Sánchez', 'asistio': true},
    {'nombre': 'Ana Gómez', 'asistio': false},
  ];

  void _guardarAsistencia() {
    // Aquí puedes agregar la lógica para enviar al backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Asistencia guardada correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Asistencia'),
      ),
      body: ListView.builder(
        itemCount: estudiantes.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: Text(estudiantes[index]['nombre']),
            value: estudiantes[index]['asistio'],
            onChanged: (bool? value) {
              setState(() {
                estudiantes[index]['asistio'] = value ?? false;
              });
            },
            activeColor: Colors.green,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guardarAsistencia,
        child: const Icon(Icons.save),
        tooltip: 'Guardar asistencia',
      ),
    );
  }
}
