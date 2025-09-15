import 'package:flutter/material.dart';
import 'dart:async';
import 'package:victor_appl_maro/screens/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _topBarAnimation;
  late Animation<double> _bottomBarAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Animación del logo (0 a 1.5 segundos)
    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Animación de la barra superior (empieza en 1.0s hasta 2.0s)
    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 0.7, curve: Curves.easeInOut),
      ),
    );

    // Animación de la barra inferior (empieza en 1.5s hasta 2.5s)
    _bottomBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.9, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    // Después de 3 segundos, ir a Login
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Scaffold(
            backgroundColor: Color.fromARGB(255, 158, 158, 158),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: RegisterForm(),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 242, 242), // Old Lace
      body: Stack(
        children: [
          // Barra verde menta superior animada
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _topBarAnimation,
              builder: (context, child) {
                return Container(
                  height: 60 * _topBarAnimation.value, // Altura animada
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(152, 251, 152, 1).withOpacity(0.9 * _topBarAnimation.value),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20 * _topBarAnimation.value),
                      bottomRight: Radius.circular(20 * _topBarAnimation.value),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green[200]!.withOpacity(0.5 * _topBarAnimation.value),
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Logo centrado
          Center(
            child: ScaleTransition(
              scale: _logoScaleAnimation,
              child: FadeTransition(
                opacity: _logoFadeAnimation,
                child: Image.asset(
                  "assets/icons/LOGO.png",
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Barra verde menta inferior animada
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _bottomBarAnimation,
              builder: (context, child) {
                return Container(
                  height: 80 * _bottomBarAnimation.value, // Altura animada
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(152, 251, 152, 1).withOpacity(0.9 * _bottomBarAnimation.value),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20 * _bottomBarAnimation.value),
                      topRight: Radius.circular(20 * _bottomBarAnimation.value),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green[200]!.withOpacity(0.5 * _bottomBarAnimation.value),
                        blurRadius: 10,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
