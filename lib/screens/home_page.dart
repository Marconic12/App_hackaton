import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';
import 'package:victor_appl_maro/components/app_bar.dart';
import 'package:victor_appl_maro/components/peso_imc.dart';
import 'package:victor_appl_maro/components/consejos_wild.dart';
import 'package:victor_appl_maro/components/chat_bot.dart';
import 'package:victor_appl_maro/screens/perfil.dart';


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
  final double iconSize1 = 100;
  final double buttonAreaSize1 = 110;  
  final double iconSize = 60;
  final double buttonAreaSize = 70; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: AppColor.background,
        elevation: 0,
        title: const SizedBox.shrink(),
        

        leading: SizedBox( 
          width: buttonAreaSize1,
          height: buttonAreaSize1,
          child: IconButton(
            padding: EdgeInsets.zero, 
            onPressed:() {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Perfil()   ),
            );  
            },          
            icon: Image.asset(
              'assets/icons/boton perfil.png',
              height: iconSize1, 
              width: iconSize1,
            ),
            tooltip: 'Perfil',
          ),
        ),
        
        actions: [
          SizedBox(
            width: buttonAreaSize,
            height: buttonAreaSize,
            child: IconButton(
              padding: EdgeInsets.zero, 
              onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              icon: Image.asset(
                'assets/icons/boton de chatbot.png',
                height: iconSize, 
                width: iconSize,
              ),
              tooltip: 'Chatbot',
            ),
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