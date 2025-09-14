import 'package:app_hackaton/components/home/peso_imc.dart';
import 'package:app_hackaton/core/app_color.dart';
import 'package:flutter/material.dart';
import 'package:app_hackaton/components/app_bar.dart';
import 'package:app_hackaton/components/home/consejos_wid.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: const Color.fromRGBO(151, 217, 233, 1),
      body: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _CirclesBgPainter())),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20), // margen arriba opcional
                Align(
                  alignment: const Alignment(0, -0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 200),
                      boton_central(),
                      const SizedBox(height: 8),
                      texto(),
                      const SizedBox(height: 500),
                      PesoVisualizer(),
                      const SizedBox(height: 50),
                      ConsejosDiariosWidget(),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton boton_central() {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.button_primario,
        foregroundColor: AppColor.secondary,
        elevation: 4,
        shape: const CircleBorder(),
      ),
      child: Image.asset('assets/icons/icono_camara.png',
      width: 150,
      height: 150,
      fit: BoxFit.fill,
      ),
    );
  }

  Text texto() {
    return const Text(
      'Escanea tu comida!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  CustomAppBar appBar() {
    return CustomAppBar(
      centerTitle: true,
      title: Text(
        'MaRo',
        style: TextStyle(
          color: const Color.fromARGB(216, 0, 0, 0),
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.button_primario,
      leading: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button_primario,
          shape: CircleBorder(),
          padding: EdgeInsets.only(bottom: 6),
        ),
        child: Image.asset('assets/icons/perfil.png',width: 60,
      height: 60,
      fit: BoxFit.fill,)
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.button_primario,
            shape: CircleBorder()
          ),
          child: Image.asset('assets/icons/boton_escaner.png',width: 60,
      height: 60,
      fit: BoxFit.cover,)
        ),
      ],
    );
  }
}

// 🎨 Painter para el fondo con un círculo extra en la esquina sup. derecha
class _CirclesBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = const Color(0xFFA2D3DF);
    canvas.drawRect(Offset.zero & size, base);

    // Originales
    final c1 = Paint()..color = const Color(0xFFB9DAE3);
    canvas.drawCircle(
      Offset(size.width * -0.1, size.height * 0.12),
      size.width * 0.38,
      c1,
    );

    final c2 = Paint()..color = Colors.white.withOpacity(0.06);
    canvas.drawCircle(
      Offset(size.width * 0.85, size.height * 0.22),
      size.width * 0.26,
      c2,
    );

    final c3 = Paint()..color = AppColor.button_primario.withOpacity(0.08);
    canvas.drawCircle(
      Offset(size.width * 0.22, size.height * 0.78),
      size.width * 0.42,
      c3,
    );

    // ➕ Círculo extra grande en esquina superior derecha
    final cExtra = Paint()..color = const Color(0xFFB9DAE3);
    canvas.drawCircle(Offset(size.width, 0), size.height * 0.5, cExtra);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
