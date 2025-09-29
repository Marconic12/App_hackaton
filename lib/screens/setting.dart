import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
   
    const Color colorFondoAzulClaro = Color(0xFF87CEEB); 
    const Color colorCajaVerdeClaro = Color(0xFFC8E6C9); 
    const Color colorBotonVerde = Color(0xFFA5D6A7);
    const Color colorGrisOscuro = Color(0xFF424242); 

    return Scaffold(
 
      backgroundColor: colorFondoAzulClaro,
      body: Center(
        child: Container(
          width: 320, 
          margin: const EdgeInsets.only(top: 80, bottom: 20),
          decoration: BoxDecoration(
            color: colorCajaVerdeClaro,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: [
              Transform.translate(
                offset: const Offset(0, -10), 
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    "Ajustes",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    _buildOpcion(Icons.person, "Cuenta/Perfil", colorBotonVerde),
                    _buildOpcion(Icons.info_outline, "Acerca de Nosotros", colorBotonVerde),
                    _buildOpcion(Icons.notifications, "Notificaciones", colorBotonVerde),
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        _buildOpcion(Icons.lock, "Privacidad", colorBotonVerde),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.settings,
                            size: 60,
                            color: colorGrisOscuro.withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                    _buildOpcion(Icons.security, "Seguridad", colorBotonVerde, iconColor: Colors.black87),
                    _buildOpcion(Icons.accessibility, "Accesibilidad", colorBotonVerde),
                    const SizedBox(height: 10), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpcion(IconData icono, String texto, Color colorFondo, {Color iconColor = Colors.black87}) {  
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        height: 55, 
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: colorFondo,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icono,
              color: iconColor,
              size: 24,
            ),
            const SizedBox(width: 15),
            Text(
              texto,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}