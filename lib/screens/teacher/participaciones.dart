import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Participacion {
  final String estudiante;
  final String fecha;
  final int cantidad;

  Participacion({
    required this.estudiante,
    required this.fecha,
    required this.cantidad,
  });

  factory Participacion.fromJson(Map<String, dynamic> json) {
    return Participacion(
      estudiante: json['estudiante'] ?? '',
      fecha: json['fecha'] ?? '',
      cantidad: json['cantidad'] ?? 0,
    );
  }
}

class ParticipacionesScreen extends StatefulWidget {
  const ParticipacionesScreen({super.key});

  @override
  State<ParticipacionesScreen> createState() => _ParticipacionesScreenState();
}

class _ParticipacionesScreenState extends State<ParticipacionesScreen> {
  List<Participacion> _participaciones = [];
  List<Participacion> _filtradas = [];
  bool _cargando = true;

  String _busquedaEstudiante = '';
  DateTime? _fechaSeleccionada;

  final String apiUrl = 'http://localhost:3000/participaciones'; // Cambia al endpoint real

  @override
  void initState() {
    super.initState();
    _cargarParticipaciones();
  }

  Future<void> _cargarParticipaciones() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List;
        setState(() {
          _participaciones = data.map((p) => Participacion.fromJson(p)).toList();
          _filtradas = List.from(_participaciones);
          _cargando = false;
        });
      } else {
        throw Exception('Error al cargar participaciones');
      }
    } catch (e) {
      setState(() => _cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _filtrar() {
    setState(() {
      _filtradas = _participaciones.where((p) {
        final coincideEstudiante = p.estudiante.toLowerCase().contains(_busquedaEstudiante.toLowerCase());
        final coincideFecha = _fechaSeleccionada == null ||
            p.fecha.startsWith(_fechaSeleccionada!.toIso8601String().substring(0, 10));
        return coincideEstudiante && coincideFecha;
      }).toList();
    });
  }

  Future<void> _seleccionarFecha() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _fechaSeleccionada ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _fechaSeleccionada = picked;
        _filtrar();
      });
    }
  }

  void _limpiarFecha() {
    setState(() {
      _fechaSeleccionada = null;
      _filtrar();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fechaTexto = _fechaSeleccionada != null
        ? '${_fechaSeleccionada!.year}-${_fechaSeleccionada!.month.toString().padLeft(2, '0')}-${_fechaSeleccionada!.day.toString().padLeft(2, '0')}'
        : 'Seleccionar fecha';

    return Scaffold(
      appBar: AppBar(title: const Text('Participaciones')),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Buscar por estudiante',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (valor) {
                    _busquedaEstudiante = valor;
                    _filtrar();
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _seleccionarFecha,
                        icon: const Icon(Icons.date_range),
                        label: Text(fechaTexto),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_fechaSeleccionada != null)
                      IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: 'Quitar filtro de fecha',
                        onPressed: _limpiarFecha,
                      ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: _filtradas.isEmpty
                ? const Center(child: Text('No se encontraron participaciones.'))
                : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _filtradas.length,
              itemBuilder: (context, index) {
                final p = _filtradas[index];
                return Card(
                  elevation: 2,
                  child: ListTile(
                    title: Text(p.estudiante, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Fecha: ${p.fecha}'),
                    trailing: Text('${p.cantidad} veces', style: const TextStyle(color: Colors.green)),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
