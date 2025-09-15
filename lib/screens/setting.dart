import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 10),
          children: [
            // Encabezado Ajustes
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/apple.png", height: 24),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Text(
                      "Ajustes",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset("assets/icons/apple.png", height: 24),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Caja principal con CustomPainter
            Center(
              child: CustomPaint(
                painter: RedBoxPainter(),
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // Usuario
                      ListTile(
                        leading:
                            const Icon(Icons.person, color: Colors.red, size: 35),
                        title: const Text("Usuario",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text("Edad: ___   Peso: ___ kg"),
                      ),
                      const Divider(),

                      // Opciones
                      _buildOpcion(Icons.person, "Cuenta/Perfil"),
                      _buildOpcion(Icons.info_outline, "Acerca de Nosotros"),
                      _buildOpcion(Icons.notifications, "Notificaciones"),
                      _buildOpcion(Icons.privacy_tip, "Privacidad"),
                      _buildOpcion(Icons.lock, "Seguridad"),
                      _buildOpcion(Icons.accessibility, "Accesibilidad"),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pie con manzana y firma
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/apple.png", height: 24),
                  const SizedBox(width: 20),
                  const Text(
                    "MaRo",
                    style: TextStyle(
                      fontFamily: "Cursive",
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Image.asset("assets/icons/apple.png", height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget auxiliar para las opciones
  Widget _buildOpcion(IconData icono, String texto) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: ListTile(
        leading: Icon(icono, color: Colors.black87),
        title: Text(
          texto,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        onTap: () {},
      ),
    );
  }
}

/// Painter para el rectángulo rojo con sombra
class RedBoxPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(25),
    );

    // Sombra
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);

    canvas.drawRRect(rect.shift(const Offset(5, 5)), shadowPaint);

    // Caja roja
    final paint = Paint()..color = Colors.red;
    canvas.drawRRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
