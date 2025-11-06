import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tickets = [
      Ticket(
        movieTitle: 'MAI',
        poster: 'img/mai.webp',
        cinema: 'Phenikaa Cinemas - Hà Đông',
        room: 'Rạp 3',
        showtime: DateTime.now().add(const Duration(days: 1, hours: 19)),
        seats: const ['E7', 'E8'],
        code: 'PKA-9F2T7',
        priceVnd: 220000,
        status: TicketStatus.booked,
      ),
      Ticket(
        movieTitle: 'Avatar 3',
        poster: 'img/avatar3.jpg',
        cinema: 'Phenikaa Cinemas - Cầu Giấy',
        room: 'Rạp IMAX',
        showtime: DateTime.now().add(const Duration(days: 3, hours: 20)),
        seats: const ['C10'],
        code: 'PKA-2JX4Q',
        priceVnd: 150000,
        status: TicketStatus.booked,
      ),
      Ticket(
        movieTitle: 'Tee Yod',
        poster: 'img/tee_yod.jpeg',
        cinema: 'Phenikaa Cinemas - Times City',
        room: 'Rạp 6',
        showtime: DateTime.now().subtract(const Duration(days: 2, hours: 21)),
        seats: const ['H5', 'H6', 'H7'],
        code: 'PKA-7N9M2',
        priceVnd: 330000,
        status: TicketStatus.used,
      ),
    ];

    return Scaffold(
      appBar: const AppHeader(),      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: tickets.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, i) => _TicketCard(ticket: tickets[i]),
        ),
      ),
    );
  }
}

/// ───────────────────────── Models ─────────────────────────
enum TicketStatus { booked, used, cancelled }

class Ticket {
  final String movieTitle;
  final String poster;
  final String cinema;
  final String room;
  final DateTime showtime;
  final List<String> seats;
  final String code;
  final int priceVnd;
  final TicketStatus status;

  Ticket({
    required this.movieTitle,
    required this.poster,
    required this.cinema,
    required this.room,
    required this.showtime,
    required this.seats,
    required this.code,
    required this.priceVnd,
    required this.status,
  });
}

/// ───────────────────────── Widgets ─────────────────────────

class _TicketCard extends StatelessWidget {
  final Ticket ticket;
  const _TicketCard({required this.ticket});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPast = ticket.showtime.isBefore(DateTime.now());
    final statusColor = switch (ticket.status) {
      TicketStatus.booked => Colors.green,
      TicketStatus.used => Colors.blueGrey,
      TicketStatus.cancelled => Colors.redAccent,
    };

    return Material(
      elevation: 1,
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {}, // TODO: đi tới chi tiết vé nếu cần
        child: Column(
          children: [
            // Top: Poster + basic info
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Poster
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      ticket.poster,
                      width: 90,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        width: 90,
                        height: 120,
                        color: const Color(0xFFF1F3F6),
                        alignment: Alignment.center,
                        child: const Icon(Icons.movie_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title + status chip
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                ticket.movieTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            _StatusChip(color: statusColor, status: ticket.status),
                          ],
                        ),
                        const SizedBox(height: 8),
                        _InfoRow(icon: Icons.location_on_outlined, text: '${ticket.cinema} • ${ticket.room}'),
                        const SizedBox(height: 6),
                        _InfoRow(
                          icon: Icons.event_outlined,
                          text: _fmtDate(ticket.showtime),
                        ),
                        const SizedBox(height: 6),
                        _InfoRow(
                          icon: Icons.chair_outlined,
                          text: ticket.seats.join(', '),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              _fmtVnd(ticket.priceVnd),
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            if (isPast) ...[
                              const SizedBox(width: 8),
                              Text('• Đã chiếu', style: TextStyle(color: theme.hintColor)),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Perforated divider (vé cắt)
            const _PerforatedDivider(),

            // Bottom: QR + code + actions
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
              child: Row(
                children: [
                  // Fake QR (placeholder)
                  Container(
                    width: 74,
                    height: 74,
                    decoration: BoxDecoration(
                      border: Border.all(color: theme.dividerColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.qr_code_2, size: 40),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mã vé', style: TextStyle(color: theme.hintColor)),
                        const SizedBox(height: 2),
                        SelectableText(
                          ticket.code,
                          style: const TextStyle(
                            fontSize: 16,
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.open_in_new, size: 18),
                              label: const Text('Xem vé'),
                            ),
                            const SizedBox(width: 8),
                            if (ticket.status == TicketStatus.booked)
                              TextButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.cancel_outlined, size: 18),
                                label: const Text('Huỷ vé'),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final Color color;
  final TicketStatus status;
  const _StatusChip({required this.color, required this.status});

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      TicketStatus.booked => 'ĐÃ ĐẶT',
      TicketStatus.used => 'ĐÃ DÙNG',
      TicketStatus.cancelled => 'ĐÃ HUỶ',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11,
          letterSpacing: .5,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  const _InfoRow({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _PerforatedDivider extends StatelessWidget {
  const _PerforatedDivider();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // hai nửa tròn + chấm chấm ở giữa
    return SizedBox(
      height: 20,
      child: Stack(
        children: [
          // chấm chấm
          Align(
            alignment: Alignment.center,
            child: LayoutBuilder(
              builder: (_, c) {
                final count = (c.maxWidth / 10).floor();
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    count,
                    (_) => Container(
                      width: 4,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.dividerColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // nửa tròn hai bên
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ───────────────────────── Account button ─────────────────────────
class _AccountButton extends StatelessWidget {
  const _AccountButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'logout') {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        } else if (v == 'profile') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đi đến Hồ sơ')),
          );
        } else if (v == 'tickets') {
          // đang ở trang vé
        }
      },
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

/// ───────────────────────── Utils ─────────────────────────
String _fmtDate(DateTime dt) {
  // dd/MM/yyyy • HH:mm
  final dd = dt.day.toString().padLeft(2, '0');
  final mm = dt.month.toString().padLeft(2, '0');
  final yyyy = dt.year.toString();
  final hh = dt.hour.toString().padLeft(2, '0');
  final min = dt.minute.toString().padLeft(2, '0');
  return '$dd/$mm/$yyyy • $hh:$min';
}

String _fmtVnd(int vnd) {
  final s = vnd.toString();
  final b = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    final rev = s.length - i;
    b.write(s[i]);
    if (rev > 1 && rev % 3 == 1) b.write('.');
  }
  return '${b.toString()} đ';
}
