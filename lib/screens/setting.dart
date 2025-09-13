import 'package:flutter/material.dart';
import 'package:hackaton_fitness/core/app_color.dart';

class Ajustes extends StatefulWidget {
  const Ajustes({super.key});

  @override
  State<Ajustes> createState() => _AjustesState();
}

class _AjustesState extends State<Ajustes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: barra(),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(40),
          height: 1024,
          width: 500,
          decoration: BoxDecoration(
            color: AppColor.secondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(children: [cuadritoUsuario(), contenedorAzul()]),
        ),
      ),
    );
  }

  Container cuadritoUsuario() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColor.fondito,
        borderRadius: BorderRadius.circular(60),
        border: Border.all(color: Colors.black, width: 4),
      ),
      child: fila(),
    );
  }

  Container contenedorAzul() {
    return Container(
      height: 870,
      width: 300,
      decoration: BoxDecoration(
        color: AppColor.fondito,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                side: const BorderSide(color: AppColor.secondary, width: 4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(Icons.person, color: Colors.blueGrey, size: 40),
                  ),

                  SizedBox(width: 10),
                  Text(
                    'Cuenta/Perfil',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: AppColor.secondary, width: 4)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(
                      Icons.question_mark,
                      color: Colors.blueGrey,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Acerca de Nosotros',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: AppColor.secondary, width: 4)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(
                      Icons.notifications_active,
                      color: Colors.blueGrey,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Notificaciones',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: AppColor.secondary, width: 4)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(
                      Icons.privacy_tip,
                      color: Colors.blueGrey,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Privacidad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: AppColor.secondary, width: 4)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(Icons.lock, color: Colors.blueGrey, size: 40),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Seguridad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                 side: const BorderSide(color: AppColor.secondary, width: 4)
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppColor.secondary, width: 4),
                    ),
                    child: Icon(Icons.personal_video, color: Colors.blueGrey, size: 40),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Accesibilidad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            
          ),
        ],
      ),
    );
  }

  Row fila() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            color: AppColor.secondary,
          ),
          child: const Icon(Icons.person, color: Colors.white, size: 30),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Usuario',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Edad: _____',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
                Text(
                  'Peso: ___ kg',
                  style: TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  AppBar barra() {
    return AppBar(
      backgroundColor: Colors.transparent,
      centerTitle: true,
      flexibleSpace: Container(
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.secondary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 6, offset: Offset(0, 3)),
          ],
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Text(
          'Ajustes',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColor.button_primario,
          ),
        ),
      ),
    );
  }
}
