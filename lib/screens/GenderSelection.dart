import 'package:flutter/material.dart';
import 'heightWeight.dart'; // Importamos la nueva pantalla

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elige tu género', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Selecciona tu género',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Esto se usará para calibrar tu plan.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildGenderCard(
                    context,
                    label: 'Femenino',
                    icon: Icons.female,
                    genderValue: 'Femenino',
                    color: Colors.pink.shade100,
                    isSelected: _selectedGender == 'Femenino',
                  ),
                  _buildGenderCard(
                    context,
                    label: 'Masculino',
                    icon: Icons.male,
                    genderValue: 'Masculino',
                    color: Colors.blue.shade100,
                    isSelected: _selectedGender == 'Masculino',
                  ),
                ],
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _selectedGender != null
                    ? () {
                        // Navegación a la nueva pantalla
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HeightWeightScreen()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedGender != null ? Colors.blueAccent : Colors.grey,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Continuar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard(
    BuildContext context, {
    required String label,
    required IconData icon,
    required String genderValue,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = genderValue;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        width: MediaQuery.of(context).size.width * 0.38,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.8) : color,
          borderRadius: BorderRadius.circular(15.0),
          border: isSelected ? Border.all(color: Colors.blueAccent, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.blueAccent.withOpacity(0.6) : Colors.grey.withOpacity(0.4),
              spreadRadius: isSelected ? 4 : 2,
              blurRadius: isSelected ? 10 : 5,
              offset: isSelected ? const Offset(0, 5) : const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 70,
              color: isSelected ? Colors.white : Colors.black87,
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
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