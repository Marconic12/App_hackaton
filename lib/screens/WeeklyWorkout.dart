import 'package:flutter/material.dart';
import 'Goal.dart'; // ¡Importamos la nueva pantalla!

class WeeklyWorkoutsScreen extends StatefulWidget {
  const WeeklyWorkoutsScreen({super.key});

  @override
  State<WeeklyWorkoutsScreen> createState() => _WeeklyWorkoutsScreenState();
}

class _WeeklyWorkoutsScreenState extends State<WeeklyWorkoutsScreen> {
  String? _selectedWorkouts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Entrenamientos', style: TextStyle(fontWeight: FontWeight.bold)),
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
                '¿Cuántos entrenamientos haces por semana?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              _buildWorkoutOption('0-2', 'Principiante', isSelected: _selectedWorkouts == '0-2'),
              const SizedBox(height: 20),
              _buildWorkoutOption('3-5', 'Intermedio', isSelected: _selectedWorkouts == '3-5'),
              const SizedBox(height: 20),
              _buildWorkoutOption('6+', 'Avanzado', isSelected: _selectedWorkouts == '6+'),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _selectedWorkouts != null
                    ? () {
                        // Navegación a la nueva pantalla de objetivo
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GoalScreen()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedWorkouts != null ? Colors.blueAccent : Colors.grey,
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

  Widget _buildWorkoutOption(String value, String subtitle, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedWorkouts = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blueAccent.withOpacity(0.2) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? Colors.blueAccent : Colors.grey.shade300,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected ? Colors.blueAccent.withOpacity(0.4) : Colors.transparent,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$value',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.blueAccent : Colors.black87,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected ? Colors.blueAccent : Colors.black54,
                  ),
                ),
              ],
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected ? Colors.blueAccent : Colors.grey,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }
}