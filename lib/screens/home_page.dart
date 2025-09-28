import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';
import 'package:victor_appl_maro/components/app_bar.dart';
import 'package:victor_appl_maro/components/peso_imc.dart';
import 'package:victor_appl_maro/components/consejos_wild.dart';
import 'package:victor_appl_maro/components/chat_bot.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> _userProfileData = {
    'weight': 70,
    'height': 170,
  };
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const SizedBox.shrink(),
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/boton perfil.png',
            height: 48,
            width: 48,
          ),
          tooltip: 'Perfil',
        ),
        actions: [
          IconButton(
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            },
            icon: Image.asset(
              'assets/icons/boton de chatbot.png',
              height: 48,
              width: 48,
            ),
            tooltip: 'Chatbot',
          ),
          const SizedBox(width: 10),
        ],
      ),
      backgroundColor: AppColor.background, 
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            _ScanButtonSection(),
            const SizedBox(height: 30),
            PesoVisualizer(userProfileData: _userProfileData),
            const SizedBox(height: 30),
            const ConsejosDiariosWidget(),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
  
  Widget _ScanButtonSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/boton escaner.png',
                height: 80, 
                width: 80,
              ),
              const SizedBox(height: 4),
              const Text(
                'Escanea\naqui',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}