import 'package:flutter/material.dart';

class RegistroNotasScreen extends StatefulWidget {
  const RegistroNotasScreen({Key? key}) : super(key: key);

  @override
  _RegistroNotasScreenState createState() => _RegistroNotasScreenState();
}

class _RegistroNotasScreenState extends State<RegistroNotasScreen> {
  // Lista de estudiantes con sus notas
  List<Map<String, dynamic>> estudiantes = [
    {'nombre': 'Juan Pérez', 'nota': 85},
    {'nombre': 'María López', 'nota': 90},
    {'nombre': 'Carlos Sánchez', 'nota': 78},
    {'nombre': 'Ana Gómez', 'nota': 92},
  ];

  // Controladores para las notas editables
  List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con las notas actuales
    _controllers = estudiantes
        .map((e) => TextEditingController(text: e['nota'].toString()))
        .toList();
  }

  @override
  void dispose() {
    // Liberar los controladores al salir de la pantalla
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Función para guardar las notas editadas
  void _guardarNotas() {
    for (int i = 0; i < estudiantes.length; i++) {
      final notaTexto = _controllers[i].text;
      final nota = int.tryParse(notaTexto);
      if (nota != null) {
        estudiantes[i]['nota'] = nota;
      }
    }
    // Aquí puedes agregar la lógica para enviar los datos al backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Notas guardadas exitosamente')),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Notas'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('Estudiante')),
            DataColumn(label: Text('Nota')),
          ],
          rows: List<DataRow>.generate(
            estudiantes.length,
                (index) => DataRow(
              cells: [
                DataCell(Text(estudiantes[index]['nombre'])),
                DataCell(
                  SizedBox(
                    width: 60,
                    child: TextField(
                      controller: _controllers[index],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _guardarNotas,
        child: Icon(Icons.save),
        tooltip: 'Guardar Notas',
      ),
    );
  }
}
