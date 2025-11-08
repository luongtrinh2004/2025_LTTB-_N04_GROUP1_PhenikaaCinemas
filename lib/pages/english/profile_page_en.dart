// lib/pages/english/profile_page_en.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/pages/login_page.dart';

// Switch shells
import 'package:flutter_cinema_booking_ui/widgets/app_shell.dart';
import 'package:flutter_cinema_booking_ui/pages/english/app_shell_en.dart';

/// =======================
///  Group data (edit here)
/// =======================
class GroupMember {
  final String mssv, name, roleVi;
  const GroupMember({
    required this.mssv,
    required this.name,
    this.roleVi = 'Thành viên',
  });
}

const String kProjectTitle = 'Movie Ticket Booking App';
const String kGroupCode = '01';
const String kClassName = 'Mobile Programming (N04)';
const List<GroupMember> kMembers = [
  GroupMember(
    mssv: '22010064',
    name: 'Trịnh Phúc Lương',
    roleVi: 'Trưởng nhóm',
  ),
  GroupMember(
    mssv: '22010033',
    name: 'Đặng Thanh Huyền',
    roleVi: 'Thành viên',
  ),
];

String _initialsFromName(String name) {
  final parts = name.trim().split(RegExp(r'\s+'));
  if (parts.isEmpty) return '';
  final first = parts.first.isNotEmpty ? parts.first[0] : '';
  final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
  return (first + last).toUpperCase();
}

String _roleEn(String roleVi) {
  switch (roleVi.trim().toLowerCase()) {
    case 'trưởng nhóm':
    case 'truong nhom':
      return 'Leader';
    case 'thành viên':
    case 'thanh vien':
      return 'Member';
    default:
      return 'Member';
  }
}

class ProfilePageEn extends StatefulWidget {
  const ProfilePageEn({super.key});

  @override
  State<ProfilePageEn> createState() => _ProfilePageEnState();
}

class _ProfilePageEnState extends State<ProfilePageEn> {
  void _switchToVi(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShell()),
      (route) => false,
    );
  }

  void _switchToEn(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const AppShellEn()),
      (route) => false,
    );
  }

  void _logout(BuildContext context) {
    // TODO: clear token/session if needed
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Scaffold(
      appBar: const AppHeader(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
          children: [
            // ===== Header / Hero =====
            const _HeroCardEn(),

            const SizedBox(height: 14),

            // ===== Group Information =====
            _SectionCardEn(
              icon: Icons.groups_rounded,
              title: 'Group',
              trailing: Text('#$kGroupCode', style: t.labelLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _KeyValueRowEn(label: 'Project', value: kProjectTitle),
                  const SizedBox(height: 8),
                  const _KeyValueRowEn(label: 'Class', value: kClassName),
                  const SizedBox(height: 12),
                  Text('Members',
                      style:
                          t.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ...kMembers.map((m) => _MemberTileEn(member: m)),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ===== Settings + Language + Logout =====
            _SectionCardEn(
              icon: Icons.settings_rounded,
              title: 'Settings',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Language',
                      style: t.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: cs.onSurface.withOpacity(.9),
                      )),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _LangButtonEn(
                          label: 'Vietnamese',
                          filled: false, // outlined
                          onTap: () => _switchToVi(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _LangButtonEn(
                          label: 'English',
                          filled: true, // filled (current)
                          onTap: () => _switchToEn(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 46,
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                        backgroundColor: cs.errorContainer,
                        foregroundColor: cs.onErrorContainer,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: () => _logout(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.logout_rounded, size: 18),
                          SizedBox(width: 8),
                          Text('Log out',
                              style: TextStyle(fontWeight: FontWeight.w800)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Center(
              child: Text(
                'v1.0.0 • Movie Ticket Booking UI',
                style: t.bodySmall?.copyWith(color: cs.onSurfaceVariant),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================================
///  Hero Card (project quick facts)
/// =======================================
class _HeroCardEn extends StatelessWidget {
  const _HeroCardEn();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primaryContainer.withOpacity(.85),
            cs.primary.withOpacity(.80)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundColor: cs.onPrimary.withOpacity(.15),
            child:
                Icon(Icons.movie_filter_rounded, color: cs.onPrimary, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Movie Booking',
                    style: t.titleMedium?.copyWith(
                        color: cs.onPrimary, fontWeight: FontWeight.w800)),
                const SizedBox(height: 2),
                Text(
                  'Group $kGroupCode • $kClassName',
                  style: t.bodySmall
                      ?.copyWith(color: cs.onPrimary.withOpacity(.95)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: cs.onPrimary.withOpacity(.12),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: cs.onPrimary.withOpacity(.22)),
            ),
            child: Row(
              children: [
                Icon(Icons.verified_rounded, size: 16, color: cs.onPrimary),
                const SizedBox(width: 6),
                Text('Active',
                    style: t.labelLarge?.copyWith(color: cs.onPrimary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================
///  Group info block
/// =======================================
class _KeyValueRowEn extends StatelessWidget {
  final String label;
  final String value;
  const _KeyValueRowEn({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 84,
          child: Text(
            label,
            style: t.labelLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: cs.onSurface.withOpacity(.76),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value, style: t.bodyLarge)),
      ],
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

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: cs.surfaceVariant.withOpacity(.30),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: cs.outlineVariant.withOpacity(.4)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: cs.primary.withOpacity(.12),
            child: Text(initials,
                style:
                    TextStyle(color: cs.primary, fontWeight: FontWeight.w800)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text('Student ID: ${member.mssv} — ${member.name}',
                overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: cs.primary.withOpacity(.10),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: cs.primary.withOpacity(.35)),
            ),
            child: Text(
              _roleEn(member.roleVi),
              style: TextStyle(
                  color: cs.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .2),
            ),
          ),
        ],
      ),
    );
  }
}

/// =======================================
///  Reusable section card
/// =======================================
class _SectionCardEn extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final Widget? trailing;
  const _SectionCardEn({
    required this.icon,
    required this.title,
    required this.child,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: cs.surfaceVariant.withOpacity(.35),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                _LeadingIconEn(icon: icon),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title,
                      style:
                          t.titleMedium?.copyWith(fontWeight: FontWeight.w800)),
                ),
                if (trailing != null) trailing!,
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

class _LeadingIconEn extends StatelessWidget {
  final IconData icon;
  const _LeadingIconEn({required this.icon});
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return CircleAvatar(
      radius: 18,
      backgroundColor: cs.primary.withOpacity(.12),
      child: Icon(icon, color: cs.primary),
    );
  }
}

/// =======================================
///  Language button
/// =======================================
class _LangButtonEn extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _LangButtonEn({
    required this.label,
    required this.filled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final child = Text(
      label,
      style: const TextStyle(fontWeight: FontWeight.w800, letterSpacing: .3),
    );

    if (filled) {
      return SizedBox(
        height: 44,
        child: FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onTap,
          child: child,
        ),
      );
    }

    return SizedBox(
      height: 44,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.primary.withOpacity(.55)),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
