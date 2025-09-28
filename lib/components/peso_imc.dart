import 'package:flutter/material.dart';

class PesoVisualizer extends StatefulWidget {
  final Map<String, dynamic> userProfileData;

  const PesoVisualizer({
    super.key,
    required this.userProfileData,
  });

  @override
  State<PesoVisualizer> createState() => _PesoVisualizerState();
}

class _PesoVisualizerState extends State<PesoVisualizer> {
  late double pesoKg;
  late double alturaM;

  final List<Map<String, dynamic>> historial = [];

  @override
  void initState() {
    super.initState();
    final int weightInt = widget.userProfileData['weight'] ?? 0;
    pesoKg = weightInt.toDouble();

    final int heightCm = widget.userProfileData['height'] ?? 1;
    alturaM = heightCm / 100.0;
  }

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
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Peso
            Text("Peso: ${pesoKg.toStringAsFixed(1)} kg",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: pesoKg,
              min: 30,
              max: 200,
              divisions: 170,
              label: "${pesoKg.toStringAsFixed(1)} kg",
              onChanged: (value) => setState(() => pesoKg = value),
            ),

            // Altura
            Text("Altura: ${alturaM.toStringAsFixed(2)} m",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: alturaM,
              min: 1.2,
              max: 2.2,
              divisions: 100,
              label: "${(alturaM * 100).toStringAsFixed(0)} cm",
              onChanged: (value) => setState(() => alturaM = value),
            ),

            const SizedBox(height: 16),

            // IMC
            Text('IMC: ${imc.toStringAsFixed(1)}',
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Categoría: $categoria',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: categoriaColor)),

            const SizedBox(height: 16),

            // Botón de guardar
            ElevatedButton.icon(
              onPressed: guardarRegistro,
              icon: const Icon(Icons.save),
              label: const Text("Guardar registro"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
            ),

            const SizedBox(height: 20),

            // Historial
            if (historial.isNotEmpty) ...[
              const Text("Historial de registros:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: historial.length,
                itemBuilder: (context, index) {
                  final registro = historial[index];
                  return ListTile(
                    leading: const Icon(Icons.fitness_center),
                    title: Text(
                        "Peso: ${registro['peso'].toStringAsFixed(1)} kg | Altura: ${registro['altura'].toStringAsFixed(2)} m"),
                    subtitle: Text(
                        "IMC: ${registro['imc'].toStringAsFixed(1)} - ${registro['categoria']}"),
                    trailing: Text(
                      "${registro['fecha'].hour}:${registro['fecha'].minute.toString().padLeft(2, '0')}",
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
