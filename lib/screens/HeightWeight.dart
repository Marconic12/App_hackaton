import 'package:flutter/material.dart';
import 'Age.dart'; 

class HeightWeightScreen extends StatefulWidget {
  
  final Map<String, dynamic> userProfileData;

  const HeightWeightScreen({super.key, required this.userProfileData});

  @override
  State<HeightWeightScreen> createState() => _HeightWeightScreenState();
}

class _HeightWeightScreenState extends State<HeightWeightScreen> {
  int? _selectedHeight; 
  int? _selectedWeight;

  final List<int> _heights = List.generate(101, (index) => 130 + index); 
  final List<int> _weights = List.generate(201, (index) => 30 + index); 

  @override
  void initState() {
    super.initState();
    _selectedHeight = null; 
    _selectedWeight = null; 
  }

  bool get _isFormValid => _selectedHeight != null && _selectedWeight != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Altura y Peso', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '¿Cuál es tu peso y altura?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPicker('Altura', _heights, _selectedHeight, (index) {
                  setState(() {
                    _selectedHeight = _heights[index];
                  });
                }, 'cm',
                initialIndex: _selectedHeight == null ? _heights.indexOf(170) : _heights.indexOf(_selectedHeight!)), 

                _buildPicker('Peso', _weights, _selectedWeight, (index) {
                  setState(() {
                    _selectedWeight = _weights[index];
                  });
                }, 'kg',
                initialIndex: _selectedWeight == null ? _weights.indexOf(70) : _weights.indexOf(_selectedWeight!)), 
              ],
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: _isFormValid
                  ? () {
                      final updatedData = Map<String, dynamic>.from(widget.userProfileData);

                      updatedData['height'] = _selectedHeight!; 
                      updatedData['weight'] = _selectedWeight!; 
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AgeSelectionScreen(userProfileData: updatedData)),
                      );
                    }
                  : null, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                disabledBackgroundColor: Colors.grey.shade400, 
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
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
    );
  }

  Widget _buildPicker(String label, List<int> values, int? selectedValue,
      Function(int) onSelectedItemChanged, String unit, {required int initialIndex}) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          width: 120,
          height: 200,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: selectedValue == null ? Colors.redAccent : Colors.blueAccent, 
              width: 2
            ),
          ),
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onSelectedItemChanged,
            controller: FixedExtentScrollController(initialItem: initialIndex), 
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: values.length,
              builder: (context, index) {
                final value = values[index];
                final isSelected = value == selectedValue; 

                return Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      fontSize: isSelected ? 30 : 20,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.blueAccent : Colors.black54,
                    ),
                    child: Text('$value $unit'),
                  ),
                );
              },
            ),
          ),
        ),
        if (selectedValue == null) 
          const Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Text(
              'Selecciona un valor',
              style: TextStyle(color: Colors.redAccent, fontSize: 12),
            ),
          ),
      ],
    );
  }
}