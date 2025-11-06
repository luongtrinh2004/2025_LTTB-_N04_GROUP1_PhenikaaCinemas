// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/pages/login_page.dart';

// Dùng shell để chuyển ngôn ngữ toàn app
import 'package:flutter_cinema_booking_ui/widgets/app_shell.dart';
import 'package:flutter_cinema_booking_ui/pages/english/app_shell_en.dart';

/// =======================
///  Data nhóm (chỉnh ở đây)
/// =======================
class GroupMember {
  final String mssv, name, role;
  const GroupMember({
    required this.mssv,
    required this.name,
    this.role = 'Thành viên',
  });
}

const String kProjectTitle = 'App đặt vé xem phim';
const String kGroupCode = '01';
const String kClassName =
    'Lập trình cho thiết bị di động (N04)';
const List<GroupMember> kMembers = [
  GroupMember(
    mssv: '22010064',
    name: 'Trịnh Phúc Lương',
    role: 'Trưởng nhóm',
  ),
  GroupMember(
    mssv: '22010033',
    name: 'Đặng Thanh Huyền',
    role: 'Thành viên',
  ),
];

String _initialsFromName(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '';
  final first =
      parts.first.isNotEmpty ? parts.first[0] : '';
  final last = parts.length > 1 && parts.last.isNotEmpty
      ? parts.last[0]
      : '';
  return (first + last).toUpperCase();
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _goToVietnamese(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShell()),
      (route) => false,
    );
  }

  void _goToEnglish(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShellEn()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtle = Theme.of(context)
        .colorScheme
        .onSurface
        .withOpacity(.7);

    return Scaffold(
      appBar: const AppHeader(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ListTile(
            leading:
                CircleAvatar(child: Icon(Icons.person)),
            title: Text('Tên người dùng'),
            subtitle: Text('you@example.com'),
          ),
          const Divider(),

          // ===== Cài đặt =====
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Cài đặt'),
          ),

          // ===== Ngôn ngữ =====
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Ngôn ngữ',
                style:
                    TextStyle(fontWeight: FontWeight.w600)),
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

          // ===== Thông tin nhóm (card mới) =====
          const SizedBox(height: 8),
          const GroupInfoCard(),
          const Divider(),

          // ===== Khác =====
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Lịch sử đặt vé'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => const AppShell(
                        initialIndex: 2)), // tab Vé
                (route) => false,
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Đăng xuất'),
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =======================================
///  Card “Thông tin nhóm” — gọn, dễ đọc
/// =======================================
class GroupInfoCard extends StatelessWidget {
  const GroupInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: cs.surfaceVariant.withOpacity(.35),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor:
                      cs.primary.withOpacity(.12),
                  child: Icon(Icons.groups_rounded,
                      color: cs.primary),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text('Thông tin nhóm',
                          style: t.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700)),
                      Text('Dự án học phần',
                          style: t.bodySmall?.copyWith(
                              color: cs.onSurface
                                  .withOpacity(.6))),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),

            // project
            const SizedBox(height: 8),
            Text('Tên đề tài',
                style: t.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(kProjectTitle, style: t.bodyLarge),

            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _MetaChip(
                    icon: Icons.confirmation_number,
                    label: 'Mã nhóm: $kGroupCode'),
                _MetaChip(
                    icon: Icons.school,
                    label: 'Lớp: $kClassName'),
              ],
            ),

            // members
            const SizedBox(height: 14),
            Text('Thành viên',
                style: t.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            ...kMembers.map((m) => _MemberTile(member: m)),
          ],
        ),
      ),
    );
  }
}

class _MetaChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChip(
      {required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: cs.surface.withOpacity(.85),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

class _MemberTile extends StatelessWidget {
  final GroupMember member;
  const _MemberTile({required this.member});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final initials = _initialsFromName(member.name);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: cs.primary.withOpacity(.12),
            child: Text(initials,
                style: TextStyle(
                    color: cs.primary,
                    fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
                  'MSSV: ${member.mssv} — ${member.name}')),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                  color: cs.primary.withOpacity(.35)),
            ),
            child: Text(
              member.role,
              style: TextStyle(
                color: cs.primary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
