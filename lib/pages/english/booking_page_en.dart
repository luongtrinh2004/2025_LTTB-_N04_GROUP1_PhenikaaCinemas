// booking_page_en.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/utils/utils.dart';

class BookingPageEn extends StatefulWidget {
  final String movieTitle;
  final String showDate; // e.g., "Today"
  final String showTime; // e.g., "13:30"

  const BookingPageEn({
    Key? key,
    required this.movieTitle,
    required this.showDate,
    required this.showTime,
  }) : super(key: key);

  @override
  State<BookingPageEn> createState() => _BookingPageEnState();
}

class _BookingPageEnState extends State<BookingPageEn> {
  // Seat layout
  final List<String> rows = const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  final int seatsPerRow = 10; // 1..10

  // Prices
  static const double priceStandard = 70000;
  static const double priceCouple = priceStandard * 2; // 2x standard

  // Convention: entire row H is couple (paired) seats
  final Set<String> _coupleRows = {'H'};

  // Selected seats (id: "A1" or "H1-2" for couple)
  final Set<String> _selected = {};

  // Pretend some seats are already booked (disabled)
  // Note: couple row uses pair ids like "H1-2", "H3-4", ...
  final Set<String> _booked = {
    'A4', 'A5',
    'B3', 'B4',
    'C5',
    'D6',
    'E2', 'E5', 'E6',
    'F4', 'F5', 'F7',
    'G1',
    'H9-10', // last pair already booked
  };

  bool _isCoupleSeatId(String id) => id.contains('-'); // couple seat has '-'

  double _priceOf(String id) =>
      _isCoupleSeatId(id) ? priceCouple : priceStandard;

  void _toggle(String id) {
    if (_booked.contains(id)) return;
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  int get _count => _selected.length;
  int get _countStandard => _selected.where((s) => !_isCoupleSeatId(s)).length;
  int get _countCouple => _selected.where((s) => _isCoupleSeatId(s)).length;

  double get _total {
    double sum = 0;
    for (final id in _selected) {
      sum += _priceOf(id);
    }
    return sum;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(
        right: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ),
      body: Column(
        children: [
          // Showtime info
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_city, color: Colors.black54),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${widget.movieTitle} • ${widget.showDate} • ${widget.showTime}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // "SCREEN"
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Container(
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: const Text(
                    'SCREEN',
                    style: TextStyle(
                      color: Colors.black54,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 4,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey,
                        Colors.transparent
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          // Seat map
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: rows.map((r) {
                  final isCoupleRow = _coupleRows.contains(r);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Left row label
                        SizedBox(
                          width: 26,
                          child: Text(
                            r,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),

                        if (!isCoupleRow)
                          ...List.generate(seatsPerRow, (i) {
                            final id = '$r${i + 1}';
                            final isBooked = _booked.contains(id);
                            final isSelected = _selected.contains(id);

                            Color bg;
                            Color border = Colors.grey.shade300;
                            Color textColor = Colors.black87;
                            Widget child;

                            if (isBooked) {
                              bg = Colors.grey.shade200;
                              child = Icon(Icons.close,
                                  size: 16, color: Colors.grey.shade600);
                            } else if (isSelected) {
                              bg = kOrange;
                              border = kOrange.withOpacity(.85);
                              child = const Text(
                                '✓',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800),
                              );
                            } else {
                              bg = Colors.white;
                              child = Text(
                                (i + 1).toString(),
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w600),
                              );
                            }

                            return GestureDetector(
                              onTap: isBooked ? null : () => _toggle(id),
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                width: 34,
                                height: 34,
                                decoration: BoxDecoration(
                                  color: bg,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: border),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 2,
                                      offset: const Offset(0, 1),
                                    )
                                  ],
                                ),
                                child: Center(child: child),
                              ),
                            );
                          })
                        else
                          // Couple row: paired (1-2, 3-4, ..., 9-10)
                          ...[
                          for (int col = 1; col <= seatsPerRow; col += 2)
                            _CoupleSeatBlockEn(
                              row: r,
                              from: col,
                              to: col + 1,
                              isBooked: _booked.contains('$r$col-${col + 1}'),
                              isSelected:
                                  _selected.contains('$r$col-${col + 1}'),
                              onTap: () => _toggle('$r$col-${col + 1}'),
                            ),
                        ],

                        const SizedBox(width: 4),

                        // Right row label
                        SizedBox(
                          width: 26,
                          child: Text(
                            r,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Legend + prices
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: _LegendFancyEn(
                        label: 'Standard',
                        color: Colors.white,
                        borderColor: Color(0xFFDADDE1),
                        textColor: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancyEn(
                        label: 'Couple',
                        color: Colors.white,
                        borderColor: Color(0xFFCEB7F4),
                        textColor: Color(0xFF7E57C2),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancyEn(
                        label: 'Selected',
                        color: kOrange,
                        textOnBox: '✓',
                        textColor: kOrange,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancyEn(
                        label: 'Booked',
                        color: Color(0xFFE6E9ED),
                        icon: Icons.close,
                        textColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Price: Standard ${fmtCurrency(priceStandard)} • Couple ${fmtCurrency(priceCouple)}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),

          // Total + BOOK button
          Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selected.isEmpty
                            ? 'No seats selected'
                            : 'Seats: ${_selected.join(', ')}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        fmtCurrency(_total),
                        style: const TextStyle(
                          color: kOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  height: 46,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: _selected.isEmpty
                        ? null
                        : () => _confirmAndShowDialog(context),
                    child: const Text(
                      'BOOK',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, letterSpacing: .5),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmAndShowDialog(BuildContext context) async {
    final seats = _selected.toList()..sort();
    final std = _countStandard;
    final cpl = _countCouple;
    final total = _total;

    final textTier = <String>[];
    if (std > 0)
      textTier.add('Standard x$std (${fmtCurrency(priceStandard)}/seat)');
    if (cpl > 0)
      textTier.add('Couple x$cpl (${fmtCurrency(priceCouple)}/block)');

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Booking Confirmed 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kv('Movie', widget.movieTitle),
            _kv('Showtime', '${widget.showTime} • ${widget.showDate}'),
            _kv('Seats', seats.join(', ')),
            _kv('Fare', textTier.join(' • ')),
            const SizedBox(height: 8),
            Text(
              'Total: ${fmtCurrency(total)}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: kOrange,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Enjoy your movie! 🍿'),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close')),
        ],
      ),
    );
    // If you want to reset after booking:
    // setState(() => _selected.clear());
  }

  Widget _kv(String k, String v) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 80,
              child: Text('$k: ',
                  style: const TextStyle(fontWeight: FontWeight.w600))),
          Expanded(child: Text(v)),
        ],
      ),
    );
  }
}

class _CoupleSeatBlockEn extends StatelessWidget {
  final String row;
  final int from;
  final int to;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback onTap;

  const _CoupleSeatBlockEn({
    required this.row,
    required this.from,
    required this.to,
    required this.isBooked,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final idText = '$from-$to';
    final id = '$row$idText';

    Color bg;
    Color border;
    Widget child;

    if (isBooked) {
      bg = Colors.grey.shade200;
      border = Colors.grey.shade300;
      child = Icon(Icons.close, size: 16, color: Colors.grey.shade600);
    } else if (isSelected) {
      bg = Colors.purple;
      border = Colors.purple.withOpacity(.85);
      child = const Text('✓',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800));
    } else {
      bg = Colors.white;
      border = Colors.purple.withOpacity(.35);
      child = Text(
        idText,
        style: TextStyle(
            color: Colors.purple.shade400, fontWeight: FontWeight.w600),
      );
    }

    return GestureDetector(
      onTap: isBooked ? null : onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        width: 72, // ~ two seats (34*2) + spacing
        height: 34,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _LegendFancyEn extends StatelessWidget {
  final String label;
  final Color color;
  final Color? borderColor;
  final IconData? icon;
  final String? textOnBox;
  final Color? textColor;

  const _LegendFancyEn({
    required this.label,
    required this.color,
    this.borderColor,
    this.icon,
    this.textOnBox,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: borderColor ?? Colors.transparent),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: 14, color: Colors.grey.shade700)
            : (textOnBox != null
                ? Text(
                    textOnBox!,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900),
                  )
                : null),
      ),
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        box,
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: textColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
