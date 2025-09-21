import 'package:flutter/material.dart';
import 'package:victor_appl_maro/screens/Motivation.dart';

class GoalScreen extends StatefulWidget {

  final Map<String, dynamic> userProfileData;

  const GoalScreen({super.key, required this.userProfileData});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  String? _selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Objetivo', style: TextStyle(fontWeight: FontWeight.bold)),
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
                '¿Cuál es tu objetivo?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              _buildGoalOption('Perder peso', Icons.trending_down, isSelected: _selectedGoal == 'Perder peso'),
              const SizedBox(height: 20),
              _buildGoalOption('Mantener', Icons.balance, isSelected: _selectedGoal == 'Mantener'),
              const SizedBox(height: 20),
              _buildGoalOption('Ganar peso', Icons.trending_up, isSelected: _selectedGoal == 'Ganar peso'),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _selectedGoal != null
                    ? () {
                      
                        final updatedData = Map<String, dynamic>.from(widget.userProfileData);

                        
                        updatedData['goal'] = _selectedGoal;

                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MotivationScreen(userProfileData: updatedData),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedGoal != null ? Colors.blueAccent : Colors.grey,
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

  Widget _buildGoalOption(String value, IconData icon, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGoal = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? Colors.blueAccent : Colors.black87,
            ),
            const SizedBox(width: 20),            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blueAccent : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}