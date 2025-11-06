import 'package:flutter/material.dart';

// English pages
import 'package:flutter_cinema_booking_ui/pages/english/home_page_en.dart';

// Fallback (reuse VN pages until EN versions are ready)
import 'package:flutter_cinema_booking_ui/pages/english/hot_movies_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tickets_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/profile_page_en.dart';

/// AppShellEn: bottom nav cho giao diện tiếng Anh
/// - Nếu sau này bạn có Hot/Tickets/Profile bản EN, chỉ cần đổi import & pages.
class AppShellEn extends StatefulWidget {
  const AppShellEn({super.key, this.initialIndex = 0});

  /// Cho phép mở trực tiếp tab nào đó (vd: 2 = Tickets)
  final int initialIndex;

  @override
  State<AppShellEn> createState() => _AppShellEnState();
}

class _AppShellEnState extends State<AppShellEn> {
  late int _index;

  // TODO: Khi có các trang EN tương ứng, thay:
  // - HotMoviesPage  -> HotMoviesPageEn()
  // - TicketsPage    -> TicketsPageEn()
  // - ProfilePage    -> ProfilePageEn()
  final _pages = const [
    HomePageEn(),
    HotMoviesPageEn(),   // TODO: replace with HotMoviesPageEn()
    TicketsPageEn(),     // TODO: replace with TicketsPageEn()
    ProfilePageEn(),     // TODO: replace with ProfilePageEn()
  ];

  @override
  void initState() {
    super.initState();
    _index = (widget.initialIndex >= 0 && widget.initialIndex < _pages.length)
        ? widget.initialIndex
        : 0;
  }

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
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_outlined),
            selectedIcon: Icon(Icons.local_fire_department),
            label: 'Hot',
          ),
          NavigationDestination(
            icon: Icon(Icons.confirmation_number_outlined),
            selectedIcon: Icon(Icons.confirmation_number),
            label: 'Tickets',
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
