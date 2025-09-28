import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  // Inicializamos las variables con valores por defecto
  String _name = 'No especificado';
  String _age = 'No especificado';
  String _email = 'No especificado';
  String _conditions = 'No especificado'; // String para mostrar la lista
  String _gender = 'No especificado';
  String _activityLevel = 'No especificado';
  String _goal = 'No especificado';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _name = prefs.getString('user_name') ?? 'No especificado';
      _age = prefs.getInt('user_age')?.toString() ?? 'No especificado';
      _email = prefs.getString('user_email') ?? 'No especificado';

      // ✅ Recuperamos la lista de condiciones correctamente
      final conditionsList = prefs.getStringList('user_physical_conditions');
      _conditions = conditionsList != null && conditionsList.isNotEmpty
          ? conditionsList.join(', ')
          : 'Ninguna / No especificado';

      _gender = prefs.getString('user_gender') ?? 'No especificado';
      _activityLevel = prefs.getString('user_activity_level') ?? 'No especificado';
      _goal = prefs.getString('user_goal') ?? 'No especificado';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildGreenTitleBox("Información Personal"),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/icons/perfil.png', height: 80, width: 80),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoField(
                                    title: "Nombre",
                                    value: _name,
                                    icon: Icons.badge_outlined),
                                _buildInfoField(
                                    title: "Correo Electrónico",
                                    value: _email,
                                    icon: Icons.email_outlined),
                                _buildInfoField(
                                    title: "Edad",
                                    value: _age,
                                    icon: Icons.cake_outlined),
                                _buildInfoField(
                                    title: "Sexo",
                                    value: _gender,
                                    icon: Icons.wc_outlined),
                                _buildInfoField(
                                    title: "Condiciones de Salud",
                                    value: _conditions,
                                    icon: Icons.medical_services_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildGreenTitleBox("Estado Físico"),
                      const SizedBox(height: 30),
                      _buildSectionWithAsset(
                        assetPath: 'assets/icons/runner.png',
                        children: [
                          _buildInfoField(
                              title: "Nivel de Actividad",
                              value: _activityLevel,
                              icon: Icons.run_circle_outlined),
                        ],
                      ),
                      const SizedBox(height: 20),

                      _buildGreenTitleBox("Objetivo"),
                      const SizedBox(height: 30),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/icons/Diana.png', height: 80, width: 80),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfoField(
                                    title: "Objetivo",
                                    value: _goal,
                                    icon: Icons.track_changes_outlined),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Center(
                child: Text(
                  "MaRo",
                  style: TextStyle(
                    fontFamily: "Cursive",
                    fontSize: 24,
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

  Widget _buildGreenTitleBox(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColor.accentGreen,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSectionWithAsset({
    required String assetPath,
    required List<Widget> children,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
        const SizedBox(width: 16),
        Image.asset(assetPath, height: 80, width: 80),
      ],
    );
  }

  Widget _buildInfoField(
      {required String title, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
