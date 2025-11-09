// lib/pages/profile_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/pages/login_page.dart';

// Shell chuyển ngôn ngữ
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

const String kProjectTitle = 'PhenikaaCinemas - Ứng dụng đặt vé xem phimm';
const String kGroupCode = '01';
const String kClassName = 'Lập trình cho thiết bị di động (N04)';
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
  final first = parts.first.isNotEmpty ? parts.first[0] : '';
  final last = parts.length > 1 && parts.last.isNotEmpty ? parts.last[0] : '';
  return (first + last).toUpperCase();
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    // TODO: clear token/session nếu có
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
            _HeroCard(),

            const SizedBox(height: 14),

            // ===== Group Information =====
            _SectionCard(
              icon: Icons.groups_rounded,
              title: 'Group',
              trailing: Text(' $kGroupCode', style: t.labelLarge),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _KeyValueRow(label: 'Project', value: kProjectTitle),
                  const SizedBox(height: 8),
                  _KeyValueRow(label: 'Class', value: kClassName),
                  const SizedBox(height: 12),
                  Text('Members',
                      style:
                          t.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ...kMembers.map((m) => _MemberTile(member: m)),
                ],
              ),
            ),

            const SizedBox(height: 14),

            // ===== Settings + Language =====
            _SectionCard(
              icon: Icons.settings,
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
                        child: _LangButton(
                          label: 'Vietnamese',
                          filled: true, // filled (orange)
                          onTap: () => _switchToVi(context),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _LangButton(
                          label: 'English',
                          filled: false, // outlined
                          onTap: () => _switchToEn(context),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 46,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: cs.primary,
                              foregroundColor: cs.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () => _logout(context),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.logout_rounded, size: 18),
                                SizedBox(width: 8),
                                Text('Đăng Xuất',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),
            Center(
              child: Text(
                'v1.0.0 • Phenikaa Cinemas',
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
class _HeroCard extends StatelessWidget {
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
                Text('Phenikaa Cinemas',
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
class _KeyValueRow extends StatelessWidget {
  final String label;
  final String value;
  const _KeyValueRow({required this.label, required this.value});

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

class _MemberTile extends StatelessWidget {
  final GroupMember member;
  const _MemberTile({required this.member});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final t = Theme.of(context).textTheme;
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
            child: Text(
              initials,
              style: TextStyle(color: cs.primary, fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(width: 10),
          // ⬇️ Name (trên) + MSSV (dưới)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên ở trên
                Text(
                  member.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: t.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 2),
                // MSSV ở dưới
                Text(
                  'MSSV: ${member.mssv}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: t.bodyMedium?.copyWith(
                    color: cs.onSurface.withOpacity(.75),
                  ),
                ),
              ],
            ),
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
              member.role,
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
class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget child;
  final Widget? trailing;
  const _SectionCard({
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
                _LeadingIcon(icon: icon),
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

class _LeadingIcon extends StatelessWidget {
  final IconData icon;
  const _LeadingIcon({required this.icon});
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
class _LangButton extends StatelessWidget {
  final String label;
  final bool filled;
  final VoidCallback onTap;

  const _LangButton({
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
