import 'package:flutter/material.dart';
import 'package:victor_appl_maro/screens/HeightWeight.dart';

class GenderSelectionScreen extends StatefulWidget {
  final Map<String, dynamic>? userProfileData;

  const GenderSelectionScreen({super.key, this.userProfileData});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen>
    with SingleTickerProviderStateMixin {
  String? _selectedGender;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
    _controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tu Género',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Text(
                  '¿Cuál es tu Género?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black38,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 60),
                _buildGenderOption(
                    'Masculino', Icons.male, Colors.blue.shade800),
                const SizedBox(height: 25),
                _buildGenderOption(
                    'Femenino', Icons.female, Colors.pink.shade800),
                const Spacer(flex: 2),
                ScaleTransition(
                  scale: _animation,
                  child: ElevatedButton(
                    onPressed: _selectedGender != null
                        ? () {
                            // 1️⃣ Traemos los datos acumulados o creamos un mapa nuevo
                            final userProfileData =
                                widget.userProfileData ?? <String, dynamic>{};

                            // 2️⃣ Guardamos el género
                            userProfileData['gender'] = _selectedGender;

                            // 3️⃣ Pasamos a la pantalla de Altura/Peso
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HeightWeightScreen(
                                  userProfileData: userProfileData,
                                ),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedGender != null
                          ? Colors.white
                          : Colors.blue.shade200,
                      foregroundColor: _selectedGender != null
                          ? Colors.blueAccent
                          : Colors.white70,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 8,
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderOption(String gender, IconData icon, Color activeColor) {
    final bool isSelected = _selectedGender == gender;
    return GestureDetector(
      onTap: () => _selectGender(gender),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected
              ? activeColor.withOpacity(0.9)
              : Colors.white.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.grey.shade300,
            width: isSelected ? 4 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? activeColor.withOpacity(0.6) : Colors.black12,
              blurRadius: isSelected ? 15 : 5,
              spreadRadius: isSelected ? 3 : 1,
              offset: Offset(0, isSelected ? 8 : 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 45,
              color: isSelected ? Colors.white : activeColor.withOpacity(0.7),
            ),
            const SizedBox(width: 25),
            Text(
              gender,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
