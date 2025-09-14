import 'package:flutter/material.dart';

class PesoVisualizer extends StatefulWidget {
  const PesoVisualizer({super.key});

  @override
  State<PesoVisualizer> createState() => _PesoVisualizerState();
}

class _PesoVisualizerState extends State<PesoVisualizer> {
  double pesoKg = 68;

  double get pesoLb => pesoKg * 2.20462;

  double get indicadorPosicion {
    const min = 40.0;
    const max = 120.0;
    final clamped = pesoKg.clamp(min, max);
    return (clamped - min) / (max - min);
  }

  String get categoria {
    if (pesoKg <= 50) return 'Infrapeso';
    if (pesoKg <= 70) return 'Saludable';
    if (pesoKg <= 90) return 'Sobrepeso';
    return 'Obesidad';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          value: pesoKg,
          min: 40,
          max: 120,
          divisions: 80,
          label: '${pesoKg.toStringAsFixed(1)} kg',
          onChanged: (value) => setState(() => pesoKg = value),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
            ],
          ),
          child: Column(
            children: [
              const Text('Tu peso actual', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${pesoKg.toStringAsFixed(1)} kg'),
                  Text('${pesoLb.toStringAsFixed(1)} lb'),
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                children: [
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.yellow,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.green,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: indicadorPosicion * MediaQuery.of(context).size.width * 0.7,
                    top: 0,
                    bottom: 0,
                    child: const VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                      width: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  LegendItem(color: Colors.red, label: 'Infrapeso'),
                  LegendItem(color: Colors.yellow, label: 'Saludable'),
                  LegendItem(color: Colors.green, label: 'Sobrepeso'),
                  LegendItem(color: Colors.blue, label: 'Obesidad'),
                ],
              ),
              const SizedBox(height: 8),
              Text('Categoría: $categoria', style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}