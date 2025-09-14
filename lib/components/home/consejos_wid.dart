import 'package:flutter/material.dart';

class ConsejosDiariosWidget extends StatelessWidget {
  const ConsejosDiariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Título con fondo azul y pines
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.push_pin, color: Colors.red),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Consejos Diarios',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.push_pin, color: Colors.red),
              ],
            ),
            const SizedBox(height: 8),
            // Cartel rojo con texto
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'Modera el consumo de azúcares añadidos y\nalimentos ultraprocesados.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                // Simulación de ganchos
                Positioned(
                  left: 0,
                  top: -8,
                  child: Icon(Icons.circle_outlined,
                      color: Colors.grey.shade700, size: 20),
                ),
                Positioned(
                  right: 0,
                  top: -8,
                  child: Icon(Icons.circle_outlined,
                      color: Colors.grey.shade700, size: 20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
