import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'WeeklyWorkout.dart'; 

class PhysicalConditionScreen extends StatefulWidget {
  final Map<String, dynamic> userProfileData;

  const PhysicalConditionScreen({super.key, required this.userProfileData});

  @override
  State<PhysicalConditionScreen> createState() => _PhysicalConditionScreenState();
}

class _PhysicalConditionScreenState extends State<PhysicalConditionScreen> {
  
  final List<String> _commonConditions = [
    'Obesidad / Sobrepeso',
    'Diabetes Tipo 2',
    'Problemas de Tiroides',
    'Colesterol Alto',
    'Hipertensión',
    'Ninguna'
  ];

  final Set<String> _selectedConditions = {'Ninguna'}; 
  final TextEditingController _otherConditionController = TextEditingController();
  bool get _isConditionSelected => 
    _selectedConditions.isNotEmpty || _otherConditionController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _otherConditionController.dispose();
    super.dispose();
  }

  void _toggleCondition(String condition) {
    setState(() {
      if (condition == 'Ninguna') {
        if (_selectedConditions.contains('Ninguna')) {
          _selectedConditions.remove('Ninguna');
        } else {
          _selectedConditions.clear();
          _selectedConditions.add('Ninguna');
        }
      } else {
        _selectedConditions.remove('Ninguna');
        if (_selectedConditions.contains(condition)) {
          _selectedConditions.remove(condition);
        } else {
          _selectedConditions.add(condition);
        }
      }
    });
  }

  void _navigateToNextScreen() {

    final List<String> finalConditions = List.from(_selectedConditions);
    final String otherCondition = _otherConditionController.text.trim();

    if (otherCondition.isNotEmpty) {
      finalConditions.add('Otro: $otherCondition');
    }

  
    final updatedData = Map<String, dynamic>.from(widget.userProfileData);
    updatedData['physicalConditions'] = finalConditions;

 
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WeeklyWorkoutsScreen(userProfileData: updatedData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Condición Física', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: FadeInRight( 
        duration: const Duration(milliseconds: 700),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Título Principal
              ZoomIn(
                duration: const Duration(milliseconds: 600),
                child: const Text(
                  '¿Tienes alguna condición médica o lesión?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeIn(
                delay: const Duration(milliseconds: 300),
                child: const Text(
                  'Esto nos ayudará a personalizar tus entrenamientos y a garantizar tu seguridad.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
              
              const SizedBox(height: 40),

          
              Pulse(
                duration: const Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 500),
                infinite: false,
                child: Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  alignment: WrapAlignment.center,
                  children: _commonConditions.map((condition) {
                    final isSelected = _selectedConditions.contains(condition);
                    return ActionChip(
                      avatar: isSelected
                          ? const Icon(Icons.check_circle, color: Colors.white)
                          : null,
                      label: Text(condition, style: TextStyle(
                        color: isSelected && condition != 'Ninguna' ? Colors.white : (isSelected && condition == 'Ninguna' ? Colors.white : Colors.blueAccent),
                        fontWeight: FontWeight.w600,
                      )),
                      backgroundColor: isSelected ? Colors.blueAccent : Colors.white, // Color de fondo diferente para deseleccionado
                      shape: StadiumBorder(
                        side: BorderSide(
                          color: isSelected ? Colors.blueAccent : Colors.blueAccent.shade200,
                          width: 1.5,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      onPressed: () => _toggleCondition(condition),
                    );
                  }).toList(),
                ),
              ),
              
              const SizedBox(height: 50),

             
              SlideInLeft(
                delay: const Duration(milliseconds: 700),
                child: TextField(
                  controller: _otherConditionController,
                  maxLines: 2,
                  onChanged: (value) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: 'Escribe otra condición médica o lesión',
                    alignLabelWithHint: true,
                    hintText: 'Ej: Ciática, Fibromialgia, etc.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.blueAccent.shade200, width: 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.blueAccent, width: 2.5),
                    ),
                    prefixIcon: const Icon(Icons.medical_services, color: Colors.blueAccent),
                  ),
                ),
              ),
              
              const SizedBox(height: 60),

            
              BounceInUp(
                delay: const Duration(milliseconds: 900),
                child: ElevatedButton(
                  onPressed: _isConditionSelected ? _navigateToNextScreen : null, 
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    elevation: 5,
                  ),
                  child: const Text('Guardar y Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}