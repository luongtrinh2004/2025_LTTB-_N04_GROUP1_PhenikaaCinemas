import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

import 'package:flutter_cinema_booking_ui/widgets/app_shell.dart';
import 'package:flutter_cinema_booking_ui/pages/english/app_shell_en.dart';

class ProfilePageEn extends StatelessWidget {
  const ProfilePageEn({super.key});

  void _goToEnglish(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShellEn()),
      (route) => false,
    );
  }

  void _goToVietnamese(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 👇 chỉ hiển thị logo
      appBar: const AppHeader(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('User name'),
            subtitle: Text('you@example.com'),
          ),
          const Divider(),
          const ListTile(leading: Icon(Icons.settings), title: Text('Settings')),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Language', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('ENG (English)'),
            onTap: () => _goToEnglish(context),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('VIE (Tiếng Việt)'),
            onTap: () => _goToVietnamese(context),
          ),
          const Divider(),
          const ListTile(leading: Icon(Icons.receipt_long), title: Text('Booking history')),
          const ListTile(leading: Icon(Icons.logout), title: Text('Log out')),
        ],
      ),
    );
  }
}

class _AccountButtonEn extends StatelessWidget {
  const _AccountButtonEn();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'logout') {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        } else if (v == 'profile') {
          // already here
        } else if (v == 'tickets') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Go to My tickets')));
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'profile', child: Text('Profile')),
        PopupMenuItem(value: 'tickets', child: Text('My tickets')),
        PopupMenuItem(value: 'logout', child: Text('Log out')),
      ],
      offset: const Offset(0, kToolbarHeight),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(radius: 18, child: Icon(Icons.person, size: 20)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
