import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart'; 
import 'WeeklyWorkout.dart'; 

class AgeSelectionScreen extends StatefulWidget {
  final Map<String, dynamic> userProfileData;

  const AgeSelectionScreen({super.key, required this.userProfileData});

  @override
  State<AgeSelectionScreen> createState() => _AgeSelectionScreenState();
}

class _AgeSelectionScreenState extends State<AgeSelectionScreen> {
  int? _selectedAge; // 
  final List<int> _ages = List.generate(83, (index) => 1 + index);

  // Helper para verificar si la edad ha sido seleccionada
  bool get _isAgeSelected => _selectedAge != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Edad', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent, 
        foregroundColor: Colors.white,
      ),
      body: FadeInUp( // Animación de entrada para toda la pantalla
        duration: const Duration(milliseconds: 600),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pulse( // Animación para el texto principal
                duration: const Duration(milliseconds: 1000),
                infinite: false, // Pulso continuo
                child: const Text(
                  '¿Cuántos años tienes?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              BounceInDown( // Animación para el selector de edad
                duration: const Duration(milliseconds: 800),
                child: Container(
                  width: 150,
                  height: 220,
                  decoration: BoxDecoration(
                    color: Colors.deepOrange.shade50,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: _selectedAge == null ? Colors.redAccent : Colors.blueAccent,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 60,
                    perspective: 0.007,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _selectedAge = _ages[index];
                      });
                    },
                    // Centra en la edad inicial (por ejemplo, 30 años)
                    controller: FixedExtentScrollController(
                      initialItem: _ages.indexOf(30) > -1 ? _ages.indexOf(30) : 0,
                    ),
                    childDelegate: ListWheelChildBuilderDelegate(
                      childCount: _ages.length,
                      builder: (context, index) {
                        final age = _ages[index];
                        final isSelected = age == _selectedAge;

                        return Center(
                          child: AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: isSelected ? 40 : 25,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected ? Colors.blueAccent : Colors.black54,
                            ),
                            child: Text('$age años'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Mensaje de advertencia si no se ha seleccionado nada
              if (_selectedAge == null)
                SlideInLeft( // Animación para el mensaje de advertencia
                  duration: const Duration(milliseconds: 500),
                  child: const Padding(
                    padding: EdgeInsets.only(top: 15.0),
                    child: Text(
                      '¡Por favor, selecciona tu edad!',
                      style: TextStyle(color: Colors.redAccent, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(height: 60),
              ZoomIn( // Animación para el botón
                duration: const Duration(milliseconds: 700),
                child: ElevatedButton(
                  onPressed: _isAgeSelected
                      ? () {
                          // Solo avanza si la edad ha sido seleccionada
                          final updatedData = Map<String, dynamic>.from(widget.userProfileData);
                          updatedData['age'] = _selectedAge!;

                          // Navega a la siguiente pantalla (por ejemplo, WeeklyWorkoutsScreen)
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WeeklyWorkoutsScreen(userProfileData: updatedData)),
                          );
                        }
                      : null, // Deshabilita el botón si la edad no está seleccionada
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Continuar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}