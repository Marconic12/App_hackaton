import 'package:flutter/material.dart';
import 'package:hackaton_fitness/core/app_color.dart';

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