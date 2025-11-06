// lib/pages/english/profile_page_en.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// Switch whole app shell
import 'package:flutter_cinema_booking_ui/widgets/app_shell.dart'; // Vietnamese shell
import 'package:flutter_cinema_booking_ui/pages/english/app_shell_en.dart'; // English shell

/// =======================
///  Group data (edit here)
/// =======================
class GroupMember {
  final String mssv, name, role; // mssv = student ID
  const GroupMember({
    required this.mssv,
    required this.name,
    this.role = 'Member',
  });
}

const String kProjectTitleEn = 'Movie Ticket Booking App';
const String kGroupCodeEn = '01';
const String kClassNameEn = 'Mobile Programming (N04)';

const List<GroupMember> kMembersEn = [
  GroupMember(
    mssv: '22010064',
    name: 'Trịnh Phúc Lương',
    role: 'Leader',
  ),
  GroupMember(
    mssv: '22010033',
    name: 'Đặng Thanh Huyền',
    role: 'Member',
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

class ProfilePageEn extends StatelessWidget {
  const ProfilePageEn({super.key});

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
            title: Text('User name'),
            subtitle: Text('you@example.com'),
          ),
          const Divider(),

          // ===== Settings =====
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),

          // ===== Language =====
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Text('Language',
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

          // ===== Group info (new card) =====
          const SizedBox(height: 8),
          const GroupInfoCardEn(),
          const Divider(),

          // ===== Others =====
          const ListTile(
            leading: Icon(Icons.receipt_long),
            title: Text('Booking history'),
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Log out'),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Log out (demo)')),
              );
            },
          ),
        ],
      ),
    );
  }
}

/// =======================================
///  Group Info Card — compact & readable
/// =======================================
class GroupInfoCardEn extends StatelessWidget {
  const GroupInfoCardEn({super.key});

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
                      Text('Group information',
                          style: t.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700)),
                      Text('Course project',
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

            // project title
            const SizedBox(height: 8),
            Text('Project title',
                style: t.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(kProjectTitleEn, style: t.bodyLarge),

            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: const [
                _MetaChipEn(
                    icon: Icons.confirmation_number,
                    label: 'Group code: $kGroupCodeEn'),
                _MetaChipEn(
                    icon: Icons.school,
                    label: 'Class: $kClassNameEn'),
              ],
            ),

            // members
            const SizedBox(height: 14),
            Text('Members',
                style: t.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 6),
            ...kMembersEn
                .map((m) => _MemberTileEn(member: m)),
          ],
        ),
      ),
    );
  }
}

class _MetaChipEn extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetaChipEn(
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

class _MemberTileEn extends StatelessWidget {
  final GroupMember member;
  const _MemberTileEn({required this.member});
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
            child: Text(
              initials,
              style: TextStyle(
                  color: cs.primary,
                  fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
              child: Text(
                  'Student ID: ${member.mssv} — ${member.name}')),
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
              member.role, // "Leader" or "Member"
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
