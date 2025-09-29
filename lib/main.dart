import 'package:flutter/material.dart';
import 'package:victor_appl_maro/core/app_color.dart';
import 'package:victor_appl_maro/screens/home_page.dart';
import 'package:victor_appl_maro/screens/setting.dart'; 
import 'package:victor_appl_maro/screens/launchind.dart';
import 'package:victor_appl_maro/screens/perfil.dart'; 

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        '/main': (context) => const MainScaffold(),
      },
    );
  }
}

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 0;

  // Ahora incluimos Perfil en la lista de páginas
  final List<Widget> _pages = [
    const HomePage(),
    const Ajustes(),
    const Center(child: Text("Favoritos", style: TextStyle(fontSize: 24))),
    const Center(child: Text("Calendario", style: TextStyle(fontSize: 24))),
    const Perfil(), 
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  static const double _customBarHeight = 50.0; // 

  BottomNavigationBarItem _navItem(IconData icon, int index, {double size = 15}) {
    final bool isSelected = _selectedIndex == index;

    return BottomNavigationBarItem(
      icon: SizedBox(
        height: _customBarHeight, 
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isSelected ? Colors.blue : Colors.grey,
              width: 1,
            ),
            color: isSelected ? Colors.blue.withOpacity(0.1) : Colors.transparent,
          ),
          child: Icon(
            icon,
            size: size,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
      ),
      label: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.accentGreen,
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 15,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          _navItem(Icons.home, 0, size: 24), 
          _navItem(Icons.settings, 1, size: 24), 
          _navItem(Icons.calendar_month, 2, size: 24), 
          _navItem(Icons.favorite_border, 3, size: 24), 
          _navItem(Icons.person, 4, size: 24), 
        ],
      ),
    );
  }
}