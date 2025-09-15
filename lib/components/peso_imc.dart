import 'package:flutter/material.dart';

class PesoVisualizer extends StatefulWidget {
  const PesoVisualizer({super.key});

  @override
  State<PesoVisualizer> createState() => _PesoVisualizerState();
}

class _PesoVisualizerState extends State<PesoVisualizer> {
  double pesoKg = 68;
  double alturaM = 1.70;

  final List<Map<String, dynamic>> historial = [];

  double get pesoLb => pesoKg * 2.20462;
  double get imc => pesoKg / (alturaM * alturaM);

  String get categoria {
    if (imc < 18.5) return 'Infrapeso';
    if (imc < 25) return 'Saludable';
    if (imc < 30) return 'Sobrepeso';
    return 'Obesidad';
  }

  Color get categoriaColor {
    if (imc < 18.5) return Colors.red;
    if (imc < 25) return Colors.green;
    if (imc < 30) return Colors.orange;
    return Colors.blue;
  }

  void guardarRegistro() {
    setState(() {
      historial.add({
        'peso': pesoKg,
        'altura': alturaM,
        'imc': imc,
        'categoria': categoria,
        'fecha': DateTime.now(),
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Registro guardado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Peso: ${pesoKg.toStringAsFixed(1)} kg",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: pesoKg,
          min: 40,
          max: 150,
          divisions: 110,
          label: '${pesoKg.toStringAsFixed(1)} kg',
          onChanged: (value) => setState(() => pesoKg = value),
        ),
        Text("Altura: ${alturaM.toStringAsFixed(2)} m",
            style: const TextStyle(fontWeight: FontWeight.bold)),
        Slider(
          value: alturaM,
          min: 1.40,
          max: 2.10,
          divisions: 70,
          label: '${alturaM.toStringAsFixed(2)} m',
          onChanged: (value) => setState(() => alturaM = value),
        ),
        const SizedBox(height: 16),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              const Text('Resultados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Peso: ${pesoKg.toStringAsFixed(1)} kg'),
                  Text('${pesoLb.toStringAsFixed(1)} lb'),
                ],
              ),
              const SizedBox(height: 8),
              Text('Altura: ${alturaM.toStringAsFixed(2)} m'),
              const SizedBox(height: 16),
              Text('IMC: ${imc.toStringAsFixed(1)}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Categoría: $categoria',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: categoriaColor)),
              const SizedBox(height: 16),

              // ✅ Botón para guardar el registro
              ElevatedButton.icon(
                onPressed: guardarRegistro,
                icon: const Icon(Icons.save),
                label: const Text("Guardar Registro"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade600,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ✅ Historial de registros guardados
        if (historial.isNotEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Historial de registros:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ...historial.reversed.map((registro) => ListTile(
                    leading: const Icon(Icons.check_circle, color: Colors.green),
                    title: Text(
                        'Peso: ${registro['peso'].toStringAsFixed(1)} kg, Altura: ${registro['altura'].toStringAsFixed(2)} m'),
                    subtitle: Text(
                        'IMC: ${registro['imc'].toStringAsFixed(1)} (${registro['categoria']}) - ${registro['fecha'].toString().split(".")[0]}'),
                  )),
            ],
          ),

        const SizedBox(height: 20),
      ],
    );
  }
}
