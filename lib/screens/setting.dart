import 'package:flutter/material.dart';

class Ajustes extends StatelessWidget {
  const Ajustes({super.key});

  @override
  Widget build(BuildContext context) {
    // Definición de colores base del diseño
    const Color colorFondoAzulClaro = Color(0xFF87CEEB); // Un azul más vívido para el fondo
    const Color colorCajaVerdeClaro = Color(0xFFC8E6C9); // Verde muy claro para la caja principal
    const Color colorBotonVerde = Color(0xFFA5D6A7); // Verde claro ligeramente más oscuro para los botones
    const Color colorGrisOscuro = Color(0xFF424242); // Gris oscuro para el icono de engranaje

    return Scaffold(
      // El fondo exterior es el color azul vibrante
      backgroundColor: colorFondoAzulClaro,
      body: Center(
        child: Container(
          // Contenedor principal para la caja verde
          width: 320, // Ancho fijo para simular el cuerpo del teléfono/app
          margin: const EdgeInsets.only(top: 80, bottom: 20),
          decoration: BoxDecoration(
            color: colorCajaVerdeClaro,
            borderRadius: BorderRadius.circular(20),
            // Se puede omitir la sombra para simplificar o añadir una sutil
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
            mainAxisSize: MainAxisSize.min, // Ajusta el tamaño al contenido
            children: [
              // Encabezado "Ajustes"
              Transform.translate(
                offset: const Offset(0, -10), // Mueve el encabezado hacia arriba
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

              // Lista de Opciones
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    _buildOpcion(Icons.person, "Cuenta/Perfil", colorBotonVerde),
                    _buildOpcion(Icons.info_outline, "Acerca de Nosotros", colorBotonVerde),
                    _buildOpcion(Icons.notifications, "Notificaciones", colorBotonVerde),
                    // Uso de Stack para colocar el engranaje junto a "Privacidad"
                    Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        _buildOpcion(Icons.lock, "Privacidad", colorBotonVerde),
                        // Ícono de Engranaje (solo junto a Privacidad/Seguridad en la imagen)
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
                    const SizedBox(height: 10), // Espacio al final
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget auxiliar para las opciones de la lista
  Widget _buildOpcion(IconData icono, String texto, Color colorFondo, {Color iconColor = Colors.black87}) {
    // Utiliza un `GestureDetector` dentro de un `Container` para replicar mejor el estilo de botón.
    return GestureDetector(
      onTap: () {
        // Lógica de navegación o acción del botón
      },
      child: Container(
        height: 55, // Altura fija para botones uniformes
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: colorFondo,
          borderRadius: BorderRadius.circular(10), // Bordes menos redondeados que el encabezado
        ),
        child: Row(
          children: [
            // El icono para "Cuenta/Perfil" en la imagen parece un icono de persona con una silueta más simple
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