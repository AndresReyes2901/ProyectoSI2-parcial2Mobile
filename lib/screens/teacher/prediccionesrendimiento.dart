import 'package:flutter/material.dart';

class PrediccionesRendimientoScreen extends StatefulWidget {
  const PrediccionesRendimientoScreen({Key? key}) : super(key: key);

  @override
  State<PrediccionesRendimientoScreen> createState() => _PrediccionesRendimientoScreenState();
}

class _PrediccionesRendimientoScreenState extends State<PrediccionesRendimientoScreen> {
  // Simulamos los datos que normalmente vendrían del backend
  final List<Map<String, dynamic>> predicciones = [
    {'nombre': 'Juan Pérez', 'probabilidad': 0.85},
    {'nombre': 'María López', 'probabilidad': 0.72},
    {'nombre': 'Carlos Sánchez', 'probabilidad': 0.63},
    {'nombre': 'Ana Gómez', 'probabilidad': 0.91},
  ];

  String getEtiqueta(double probabilidad) {
    if (probabilidad >= 0.8) return "Alto";
    if (probabilidad >= 0.5) return "Medio";
    return "Bajo";
  }

  Color getColor(double probabilidad) {
    if (probabilidad >= 0.8) return Colors.green;
    if (probabilidad >= 0.5) return Colors.orange;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predicciones de Rendimiento"),
      ),
      body: ListView.builder(
        itemCount: predicciones.length,
        itemBuilder: (context, index) {
          final pred = predicciones[index];
          final etiqueta = getEtiqueta(pred['probabilidad']);
          final color = getColor(pred['probabilidad']);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: color,
                child: Text(
                  (pred['probabilidad'] * 100).toInt().toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(pred['nombre']),
              subtitle: Text('Probabilidad de éxito: ${(pred['probabilidad'] * 100).toStringAsFixed(2)}%'),
              trailing: Text(
                etiqueta,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
