import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccountScreen extends StatefulWidget {
  final Map<String, dynamic> userProfileData;

  const CreateAccountScreen({super.key, required this.userProfileData});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _saveUserData() async {
    // 1. VALIDACIÓN: Comprobar que los campos de la cuenta no estén vacíos.
    if (_usernameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      
      final prefs = await SharedPreferences.getInstance();

      // Datos de la cuenta
      await prefs.setString('user_name', _usernameController.text);
      await prefs.setString('user_email', _emailController.text);
      // **Nota de seguridad:** Guardar contraseñas en SharedPreferences no es seguro.
      // Considera usar FlutterSecureStorage o un servicio de autenticación.
      await prefs.setString('user_password', _passwordController.text);

      // Datos del perfil (del flujo Onboarding)
      if (widget.userProfileData.containsKey('gender')) {
        await prefs.setString('user_gender', widget.userProfileData['gender']);
      }
      // Los datos numéricos deben convertirse al tipo correcto (int/double)
      if (widget.userProfileData.containsKey('height')) {
        await prefs.setInt('user_height', widget.userProfileData['height'] as int);
      }
      if (widget.userProfileData.containsKey('weight')) {
        await prefs.setInt('user_weight', widget.userProfileData['weight'] as int);
      }
      if (widget.userProfileData.containsKey('age')) {
        await prefs.setInt('user_age', widget.userProfileData['age'] as int);
      }
      if (widget.userProfileData.containsKey('activity_level')) {
        await prefs.setString('user_activity_level', widget.userProfileData['activity_level']);
      }
      if (widget.userProfileData.containsKey('goal')) {
        await prefs.setString('user_goal', widget.userProfileData['goal']);
      }
      if (widget.userProfileData.containsKey('motivation')) {
        await prefs.setString('user_motivation', widget.userProfileData['motivation']);
      }

      // Redirigir al Home o Dashboard
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/main', // Asegúrate de que esta ruta esté definida en tu `MaterialApp`
        (Route<dynamic> route) => false,
      );
    } else {
      // Mostrar SnackBar si la validación falla
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos para crear la cuenta.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crear cuenta"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "Nombre de usuario"),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Correo electrónico"),
              keyboardType: TextInputType.emailAddress, // Mejor práctica para correos
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveUserData,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text("Guardar cuenta"),
            )
          ],
        ),
      ),
    );
  }
}