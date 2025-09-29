import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';
class _LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const _LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 10, color: Colors.black54),
        ),
      ],
    );
  }
}

class _GreenBadge extends StatelessWidget {
  final String text;
  const _GreenBadge({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.accentGreen,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColor.darkGreen,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
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
    // Inicialización de la lógica del usuario
    final int weightInt = widget.userProfileData['weight'] ?? 70;
    pesoKg = weightInt.toDouble();

    final int heightCm = widget.userProfileData['height'] ?? 170;
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
    // Usamos AppColor para los colores principales del diseño
    if (imc < 18.5) return AppColor.redStatus;
    if (imc < 25) return AppColor.accentGreen;
    if (imc < 30) return Colors.orange;
    return AppColor.redStatus;
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        clipBehavior: Clip.none, // Permite que el badge sobresalga
        alignment: Alignment.topCenter,
        children: [
          // Tarjeta Blanca Principal (Diseño de la imagen)
          Container(
            margin: const EdgeInsets.only(top: 35), // Margen para el badge
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                
                // 1. Pesos KG/LB (Dinámico)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      '${pesoKg.toStringAsFixed(1)} kg',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${pesoLb.toStringAsFixed(1)} lb',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 2. Indicador de Estado (Diseño de la imagen con IMC dinámico)
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: categoriaColor,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          categoria, 
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          'IMC: ${imc.toStringAsFixed(1)}', 
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _LegendItem(color: AppColor.redStatus, text: 'Infrapeso'),
                    _LegendItem(color: AppColor.accentGreen, text: 'Saludable'),
                    _LegendItem(color: Colors.orange, text: 'Sobrepeso'),
                    _LegendItem(color: AppColor.redStatus, text: 'Obesidad'),
                  ],
                ),
                const Divider(height: 25, color: Colors.grey),


                Text(
                  "Peso: ${pesoKg.toStringAsFixed(1)} kg",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: pesoKg,
                  min: 30,
                  max: 200,
                  divisions: 170,
                  label: "${pesoKg.toStringAsFixed(1)} kg",
                  onChanged: (value) => setState(() => pesoKg = value),
                  activeColor: AppColor.accentGreen,
                ),

                Text(
                  "Altura: ${(alturaM * 100).toStringAsFixed(0)} cm (${alturaM.toStringAsFixed(2)} m)",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
                Slider(
                  value: alturaM,
                  min: 1.2,
                  max: 2.2,
                  divisions: 100,
                  label: "${(alturaM * 100).toStringAsFixed(0)} cm",
                  onChanged: (value) => setState(() => alturaM = value),
                  activeColor: AppColor.accentGreen,
                ),

                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: guardarRegistro,
                  icon: const Icon(Icons.save),
                  label: const Text("Guardar registro"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.darkGreen, 
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 20),
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
                        leading: Icon(Icons.fitness_center, color: AppColor.darkGreen),
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

          const Positioned(
            top: 0,
            child: _GreenBadge(text: 'peso actual'),
          ),
        ],
      ),
    );
  }
}