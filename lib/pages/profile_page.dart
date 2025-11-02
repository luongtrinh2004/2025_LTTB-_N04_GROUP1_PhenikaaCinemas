import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        right: _AccountButton(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          ListTile(
            leading:
                CircleAvatar(child: Icon(Icons.person)),
            title: Text('Tên người dùng'),
            subtitle: Text('you@example.com'),
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.settings),
              title: Text('Cài đặt')),
          ListTile(
              leading: Icon(Icons.receipt_long),
              title: Text('Lịch sử đặt vé')),
          ListTile(
              leading: Icon(Icons.logout),
              title: Text('Đăng xuất')),
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
        PopupMenuItem(
            value: 'profile', child: Text('Hồ sơ')),
        PopupMenuItem(
            value: 'tickets', child: Text('Vé của tôi')),
        PopupMenuItem(
            value: 'logout', child: Text('Đăng xuất')),
      ],
      offset: const Offset(0, kToolbarHeight),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(
              radius: 18,
              child: Icon(Icons.person, size: 20)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
