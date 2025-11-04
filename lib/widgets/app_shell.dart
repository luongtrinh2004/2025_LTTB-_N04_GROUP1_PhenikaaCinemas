import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/tickets_page.dart';
import '../pages/profile_page.dart';
import '../pages/hot_movies_page.dart'; // <-- trang Hot UI
// import '../widgets/app_header.dart'; // unused

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _index = 0;

  // Đặt Hot ở CUỐI CÙNG
  final _pages = const [
    HomePage(),
    HotMoviesPage(), 
    TicketsPage(),
    ProfilePage(),
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFFF7A00).withOpacity(.12),
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Trang Chủ',
          ),
           NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            selectedIcon: Icon(Icons.local_fire_department),
            label: 'Hot', // <-- cuối
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Vé',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
         
        ],
      ),
    );
  }
}
