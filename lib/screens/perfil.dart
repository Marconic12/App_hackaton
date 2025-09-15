import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  // Controladores de perfil
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _conditionsController = TextEditingController();

  // Sexo
  String gender = "F";

  // Estado de actividad
  String activityLevel = "Atleta";

  // Objetivo
  String goal = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.fondito,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Encabezado Perfil
              _sectionHeader("Mi perfil", "assets/icons/perfil.png"),

              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                padding: const EdgeInsets.all(20),
                decoration: _boxDecoration(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField("Nombre", _nameController),
                    _buildTextField("Edad", _ageController, isNumber: true),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Text("Sexo: "),
                        Checkbox(
                          value: gender == "M",
                          onChanged: (_) {
                            setState(() => gender = "M");
                          },
                        ),
                        const Text("M"),
                        Checkbox(
                          value: gender == "F",
                          onChanged: (_) {
                            setState(() => gender = "F");
                          },
                        ),
                        const Text("F"),
                      ],
                    ),
                    _buildTextField("Correo", _emailController),
                    _buildTextField(
                        "Enfermedades/Condiciones", _conditionsController),
                  ],
                ),
              ),

              // Estado de Actividad Física
              _sectionHeader("Estado de actividad Física", "assets/images/runner.png"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: _boxDecoration(),
                child: Column(
                  children: [
                    _buildRadioOption("Sedentario"),
                    _buildRadioOption("Actividad ligera"),
                    _buildRadioOption("Moderado"),
                    _buildRadioOption("Atleta"),
                  ],
                ),
              ),

              // Objetivo
              _sectionHeader("Objetivo", "assets/images/target.png"),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding: const EdgeInsets.all(12),
                decoration: _boxDecoration(),
                child: Column(
                  children: [
                    _buildGoalOption("Déficit"),
                    _buildGoalOption("Aumento"),
                    _buildGoalOption("Mantenimiento"),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "MaRo",
                  style: TextStyle(
                    fontFamily: "Cursive",
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Widgets reutilizables ------------

  Widget _sectionHeader(String title, String assetIcon) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetIcon, height: 24, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isNumber = false}) {
    return TextField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildRadioOption(String value) {
    return CheckboxListTile(
      title: Text(value),
      value: activityLevel == value,
      onChanged: (_) {
        setState(() {
          activityLevel = value;
        });
      },
    );
  }

  Widget _buildGoalOption(String value) {
    return CheckboxListTile(
      title: Text(value),
      value: goal == value,
      onChanged: (_) {
        setState(() {
          goal = value;
        });
      },
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 1,
          blurRadius: 5,
        ),
      ],
    );
  }
}
