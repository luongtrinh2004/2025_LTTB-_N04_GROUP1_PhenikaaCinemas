import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// 👉 Dùng shell thay vì trang Home riêng lẻ
import 'package:flutter_cinema_booking_ui/widgets/app_shell.dart';
import 'package:flutter_cinema_booking_ui/pages/english/app_shell_en.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _goToVietnamese(BuildContext context) {
    // Về shell tiếng Việt
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShell()),
      (route) => false,
    );
  }

  void _goToEnglish(BuildContext context) {
    // Sang shell tiếng Anh
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShellEn()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Tên người dùng'),
            subtitle: Text('you@example.com'),
          ),
          const Divider(),

          // ===== Cài đặt =====
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
          ),

          // ===== Ngôn ngữ (ở dưới Cài đặt) =====
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text(
              'Ngôn ngữ',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('VIE (Tiếng Việt)'),
            onTap: () => _goToVietnamese(context),
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('ENG (English)'),
            onTap: () => _goToEnglish(context),
          ),

          const Divider(),
          const ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Lịch sử đặt vé'),
          ),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }
}

class _AccountButton extends StatelessWidget {
  const _AccountButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {/* TODO: điều hướng theo v */},
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'profile', child: Text('Hồ sơ')),
        PopupMenuItem(value: 'tickets', child: Text('Vé của tôi')),
        PopupMenuItem(value: 'logout', child: Text('Đăng xuất')),
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
