import 'package:flutter/material.dart';
import 'package:victor_appl_maro/components/app_bar.dart';
import 'package:victor_appl_maro/components/consejos_wild.dart';
import 'package:victor_appl_maro/components/peso_imc.dart';
import 'package:victor_appl_maro/core/app_color.dart';
import 'package:victor_appl_maro/components/chat_bot.dart';
import 'package:victor_appl_maro/screens/HeightWeight.dart'; // Importa la pantalla de altura y peso

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Mapa para almacenar los datos del usuario
  Map<String, dynamic> _userProfileData = {
    'weight': 70,  // valor por defecto
    
    'height': 170, // valor por defecto
  };

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
                const SizedBox(height: 20),
                Align(
                  alignment: const Alignment(0, -0.1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 200),
                      botonCentral(),
                      const SizedBox(height: 8),
                      textoCentral(),
                      const SizedBox(height: 50),

                      // PesoVisualizer ahora usa los datos dinámicos
                      PesoVisualizer(userProfileData: _userProfileData),

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.button_primario,
        child: const Icon(Icons.chat, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatScreen()),
          );
        },
        tooltip: 'Ir al Chatbot',
      ),
    );
  }

  /// Botón central de escaneo (ahora abre HeightWeightScreen)
  ElevatedButton botonCentral() {
    return ElevatedButton(
      onPressed: () async {
        // Abrimos la pantalla HeightWeight y esperamos el resultado
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => HeightWeightScreen(userProfileData: _userProfileData),
          ),
        );

        // Si hay resultado, actualizamos el estado
        if (result != null && result is Map<String, dynamic>) {
          setState(() {
            _userProfileData = result;
          });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.button_primario,
        elevation: 4,
        shape: const CircleBorder(),
      ),
      child: Image.asset(
        'assets/icons/icono_camara.png',
        width: 150,
        height: 150,
      ),
    );
  }

  /// Texto debajo del botón central
  Text textoCentral() {
    return const Text(
      'Escanea tu comida!',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
      ),
    );
  }

  /// AppBar personalizado
  CustomAppBar appBar() {
    return CustomAppBar(
      centerTitle: true,
      title: const Text(
        'MaRo',
        style: TextStyle(
          color: Color.fromARGB(216, 0, 0, 0),
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColor.button_primario,
      leading: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.button_primario,
          shape: const CircleBorder(),
          padding: const EdgeInsets.only(bottom: 6),
        ),
        child: Image.asset(
          'assets/icons/perfil.png',
          width: 60,
          height: 60,
          fit: BoxFit.fill,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.button_primario,
            shape: const CircleBorder(),
          ),
          child: Image.asset(
            'assets/icons/boton_escaner.png',
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}

class _CirclesBgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final base = Paint()..color = const Color(0xFFA2D3DF);
    canvas.drawRect(Offset.zero & size, base);

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

    final cExtra = Paint()..color = const Color(0xFFB9DAE3);
    canvas.drawCircle(Offset(size.width, 0), size.height * 0.5, cExtra);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
