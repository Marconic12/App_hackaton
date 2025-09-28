import 'package:flutter/material.dart';
// Importamos AppColor para usar los colores de la paleta
import 'package:victor_appl_maro/core/app_color.dart';

/// Widget de consejos diarios con el diseño de doble tarjeta.
/// Ahora contiene el consejo específico de moderar azúcares.
/// Simula el archivo 'package:victor_appl_maro/components/consejos_wild.dart'
class ConsejosDiariosWidget extends StatelessWidget {
  const ConsejosDiariosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.darkGreen.withOpacity(0.9), // Color verde oscuro de fondo
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Botón Consejos Diarios (Tarjeta Izquierda - Color claro)
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColor.accentGreen.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Consejos Diarios',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkGreen,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Text(
                  'Modera el consumo de azúcares añadidos y\nalimentos ultraprocesados.', 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14, // Ajustado para que el texto quepa bien
                    color: Colors.black87,
                    fontWeight: FontWeight.w600, 
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
