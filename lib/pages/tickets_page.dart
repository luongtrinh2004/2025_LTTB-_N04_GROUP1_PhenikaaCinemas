import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        right: _AccountButton(),
      ),
      body: const Center(
        child: Text('Vé của tôi (placeholder)'),
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
