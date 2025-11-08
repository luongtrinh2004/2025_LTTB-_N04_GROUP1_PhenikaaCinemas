import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/utils/utils.dart';

class BookingPage extends StatefulWidget {
  final String movieTitle;
  final String showDate; // ví dụ: "Hôm nay"
  final String showTime; // ví dụ: "13:30"

  const BookingPage({
    Key? key,
    required this.movieTitle,
    required this.showDate,
    required this.showTime,
  }) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  // ── Cấu hình sơ đồ ────────────────────────────────────────────
  final List<String> rows = const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  final int seatsPerRow = 10;

  // Hàng ghế đôi
  final Set<String> _coupleRows = {'H'};

  // Ghế đã chọn & đã đặt
  final Set<String> _selected = {};
  final Set<String> _booked = {
    'A4', 'A5',
    'B3', 'B4',
    'C5',
    'D6',
    'E2', 'E5', 'E6',
    'F4', 'F5', 'F7',
    'G1',
    'H9-10', // cặp cuối đã đặt
  };

  // ── Giá ───────────────────────────────────────────────────────
  static const double priceStandard = 70000;
  static const double priceCouple = priceStandard * 2;

  // ── Responsive constants ──────────────────────────────────────
  static const double _sideLabelWidth = 26; // A..H
  static const double _sideLabelGap = 4; // khoảng cách nhãn ↔ ghế
  static const double _rowOuterPadding = 8; // padding Horizontal của ListView
  static const double _seatGap = 8; // khoảng cách giữa 2 ghế

  bool _isCoupleSeatId(String id) => id.contains('-');
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

  int get _countStandard => _selected.where((s) => !_isCoupleSeatId(s)).length;
  int get _countCouple => _selected.where((s) => _isCoupleSeatId(s)).length;

  double get _total => _selected.fold(0.0, (p, id) => p + _priceOf(id));

  /// Tính kích thước **một ghế** dựa theo bề rộng khả dụng của hàng
  double _seatSizeFor(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    // Bề rộng khả dụng = width màn hình
    //   - padding ngoài của ListView (2 bên)
    //   - nhãn hàng trái/phải + khoảng cách của chúng
    final available =
        w - (_rowOuterPadding * 2) - (_sideLabelWidth + _sideLabelGap) * 2;

    // 10 ghế + 9 khoảng trống giữa ghế
    final raw = (available - (seatsPerRow - 1) * _seatGap) / seatsPerRow;

    // Giới hạn để nhìn ổn trên cực nhỏ/cực lớn
    return raw.clamp(24, 44);
  }

  @override
  Widget build(BuildContext context) {
    final seatSize = _seatSizeFor(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppHeader(),
      body: Column(
        children: [
          // Thông tin suất chiếu
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

          // MÀN HÌNH
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
                    'MÀN HÌNH',
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

          // Sơ đồ ghế
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: _rowOuterPadding),
              child: Column(
                children: rows.map((r) {
                  final isCoupleRow = _coupleRows.contains(r);

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nhãn hàng trái
                        SizedBox(
                          width: _sideLabelWidth,
                          child: Text(
                            r,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: _sideLabelGap),

                        if (!isCoupleRow)
                          // GHẾ ĐƠN
                          ...List.generate(seatsPerRow, (i) {
                            final id = '$r${i + 1}';
                            final isBooked = _booked.contains(id);
                            final isSelected = _selected.contains(id);

                            Color bg;
                            Color border = Colors.grey.shade300;
                            Widget child;

                            if (isBooked) {
                              bg = Colors.grey.shade200;
                              child = Icon(Icons.close,
                                  size: seatSize * .47,
                                  color: Colors.grey.shade600);
                            } else if (isSelected) {
                              bg = kOrange;
                              border = kOrange.withOpacity(.85);
                              child = const Text(
                                '✓',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                ),
                              );
                            } else {
                              bg = Colors.white;
                              child = Text(
                                (i + 1).toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              );
                            }

                            final bool isLast = i == seatsPerRow - 1;

                            return GestureDetector(
                              onTap: isBooked ? null : () => _toggle(id),
                              child: Container(
                                // ❗ Chỉ đặt khoảng cách bên phải, ghế cuối = 0
                                margin: EdgeInsets.only(
                                    right: isLast ? 0 : _seatGap),
                                width: seatSize,
                                height: seatSize,
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
                                alignment: Alignment.center,
                                child: child,
                              ),
                            );
                          })
                        else
                          // GHẾ ĐÔI
                          ...[
                          for (int col = 1; col <= seatsPerRow; col += 2)
                            _CoupleSeatBlock(
                              row: r,
                              from: col,
                              to: col + 1,
                              isBooked: _booked.contains('$r$col-${col + 1}'),
                              isSelected:
                                  _selected.contains('$r$col-${col + 1}'),
                              onTap: () => _toggle('$r$col-${col + 1}'),
                              seatSize: seatSize,
                              gap: _seatGap,
                              isLastBlock: col >= seatsPerRow - 1,
                            ),
                        ],

                        const SizedBox(width: _sideLabelGap),

                        // Nhãn hàng phải
                        SizedBox(
                          width: _sideLabelWidth,
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

          // Chú thích + giá
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
            child: Column(
              children: [
                Row(
                  children: const [
                    Expanded(
                      child: _LegendFancy(
                        label: 'Ghế thường',
                        color: Colors.white,
                        borderColor: Color(0xFFDADDE1),
                        textColor: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancy(
                        label: 'Ghế đôi',
                        color: Colors.white,
                        borderColor: Color(0xFFCEB7F4),
                        textColor: Color(0xFF7E57C2),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancy(
                        label: 'Đang chọn',
                        color: kOrange,
                        textOnBox: '✓',
                        textColor: kOrange,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _LegendFancy(
                        label: 'Đã đặt',
                        color: Color(0xFFE6E9ED),
                        icon: Icons.close,
                        textColor: Colors.black54,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Giá: Ghế thường ${fmtCurrency(priceStandard)} • Ghế đôi ${fmtCurrency(priceCouple)}',
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),

          // Tổng tiền + nút ĐẶT VÉ
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
                            ? 'Chưa chọn ghế'
                            : 'Ghế: ${_selected.toList()..sort()}',
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _selected.isEmpty
                        ? null
                        : () => _confirmAndShowDialog(context),
                    child: const Text(
                      'ĐẶT VÉ',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        letterSpacing: .5,
                      ),
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
    if (std > 0) {
      textTier.add('Ghế thường x$std (${fmtCurrency(priceStandard)}/ghế)');
    }
    if (cpl > 0) {
      textTier.add('Ghế đôi x$cpl (${fmtCurrency(priceCouple)}/block)');
    }

    await showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Đặt vé thành công 🎉'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kv('Phim', widget.movieTitle),
            _kv('Suất', '${widget.showTime} • ${widget.showDate}'),
            _kv('Ghế', seats.join(', ')),
            _kv('Mức vé', textTier.join(' • ')),
            const SizedBox(height: 8),
            Text(
              'Tổng: ${fmtCurrency(total)}',
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 16,
                color: kOrange,
              ),
            ),
            const SizedBox(height: 12),
            const Text('Chúc bạn có một buổi xem phim thật vui! 🍿'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
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
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(v)),
        ],
      ),
    );
  }
}

// ──────────────────────────────────────────────────────────────
//   WIDGETS PHỤ
// ──────────────────────────────────────────────────────────────

class _CoupleSeatBlock extends StatelessWidget {
  final String row;
  final int from;
  final int to;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback onTap;

  // responsive
  final double seatSize; // kích thước 1 ghế
  final double gap; // khoảng cách giữa 2 ghế
  final bool isLastBlock;

  const _CoupleSeatBlock({
    required this.row,
    required this.from,
    required this.to,
    required this.isBooked,
    required this.isSelected,
    required this.onTap,
    required this.seatSize,
    this.gap = 8,
    this.isLastBlock = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final idText = '$from-$to';
    final blockWidth = seatSize * 2 + gap; // 2 ghế + khe hở

    Color bg;
    Color border;
    Widget child;

    if (isBooked) {
      bg = Colors.grey.shade200;
      border = Colors.grey.shade300;
      child =
          Icon(Icons.close, size: seatSize * .47, color: Colors.grey.shade600);
    } else if (isSelected) {
      // ⬇️ ĐỔI THÀNH GIỐNG GHẾ ĐƠN
      bg = kOrange;
      border = kOrange.withOpacity(.85);
      child = const Text(
        '✓',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
      );
    } else {
      bg = Colors.white;
      border =
          Colors.purple.withOpacity(.35); // giữ style ghế đôi khi chưa chọn
      child = Text(
        idText,
        style: TextStyle(
          color: Colors.purple.shade400,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return GestureDetector(
      onTap: isBooked ? null : onTap,
      child: Container(
        // ❗ Chỉ tạo khe ở bên phải, block cuối = 0
        margin: EdgeInsets.only(right: isLastBlock ? 0 : gap),
        width: blockWidth,
        height: seatSize,
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
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class _LegendFancy extends StatelessWidget {
  final String label;
  final Color color;
  final Color? borderColor;
  final IconData? icon;
  final String? textOnBox;
  final Color? textColor;

  const _LegendFancy({
    required this.label,
    required this.color,
    this.borderColor,
    this.icon,
    this.textOnBox,
    this.textColor,
    super.key,
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
