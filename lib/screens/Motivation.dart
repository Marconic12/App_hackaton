import 'package:flutter/material.dart';
import 'Log.dart'; 

class MotivationScreen extends StatefulWidget {

  final Map<String, dynamic> userProfileData;

  const MotivationScreen({super.key, required this.userProfileData});

  @override
  State<MotivationScreen> createState() => _MotivationScreenState();
}

class _MotivationScreenState extends State<MotivationScreen> {
  String? _selectedMotivation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Motivación', style: TextStyle(fontWeight: FontWeight.bold)),
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
                '¿Qué te gustaría lograr?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              _buildMotivationOption(
                'Comer y vivir más saludable',
                Icons.apple,
                isSelected: _selectedMotivation == 'Comer y vivir más saludable',
              ),
              const SizedBox(height: 15),
              _buildMotivationOption(
                'Aumentar mi energía y estado de ánimo',
                Icons.bolt,
                isSelected: _selectedMotivation == 'Aumentar mi energía y estado de ánimo',
              ),
              const SizedBox(height: 15),
              _buildMotivationOption(
                'Mantenerme motivado y consistente',
                Icons.run_circle,
                isSelected: _selectedMotivation == 'Mantenerme motivado y consistente',
              ),
              const SizedBox(height: 15),
              _buildMotivationOption(
                'Sentirme mejor con mi cuerpo',
                Icons.sentiment_satisfied,
                isSelected: _selectedMotivation == 'Sentirme mejor con mi cuerpo',
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: _selectedMotivation != null
                    ? () {
                        
                        final updatedData = Map<String, dynamic>.from(widget.userProfileData);
                        
                        
                        updatedData['goal'] = _selectedMotivation;

                        
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AccountCreationOptionScreen(userProfileData: updatedData),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedMotivation != null ? Colors.blueAccent : Colors.grey,
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

  Widget _buildMotivationOption(String value, IconData icon, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMotivation = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
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
              size: 35,
              color: isSelected ? Colors.blueAccent : Colors.black87,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isSelected ? Colors.blueAccent : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}