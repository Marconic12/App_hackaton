
import 'package:app_hackaton/core/app_color.dart';
import 'package:flutter/material.dart';
 


class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.fondito,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              
            ),
          )
        ],
      ),
    );
  }
}