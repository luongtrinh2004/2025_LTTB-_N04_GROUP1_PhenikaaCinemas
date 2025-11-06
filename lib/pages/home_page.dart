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
  // Cấu hình ghế
  final List<String> rows = const ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  final int seatsPerRow = 10; // <-- 1..10

  // Giá
  static const double priceStandard = 70000;
  static const double priceCouple = priceStandard * 2; // <-- 2x ghế thường

  // Quy ước: cả hàng H là ghế đôi (couple)
  final Set<String> _coupleRows = {'H'};

  // Ghế đã chọn (id: "A1" hoặc "H1-2" cho ghế đôi)
  final Set<String> _selected = {};

  // Giả lập một số ghế đã có người đặt (không click được)
  // Lưu ý: hàng đôi dùng ID theo cặp "H1-2", "H3-4", ...
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

  bool _isCoupleSeatId(String id) => id.contains('-'); // ghế đôi có dấu '-'
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
        right: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nút đổi ngôn ngữ: VIE / ENG (nhỏ gọn, cam/cam nhạt)
            LanguageSwitcherMini(
              isEnglish: false, // đây là trang VI
              width: 56, // khung nhỏ
              height: 24, // khung nhỏ
              fontSize: 12, // chữ nhỏ cân đối khung
              onTapVI: () {
                // Đang ở VI -> không làm gì
              },
              onTapEN: () {
                // TODO: điều hướng sang trang ENG nếu có
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookingPageEn(...)));
              },
            ),
            const SizedBox(width: 8),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      ),
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

          // "MÀN HÌNH"
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
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: rows.map((r) {
                  final isCoupleRow = _coupleRows.contains(r);
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Nhãn hàng bên trái
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
                          // Hàng ghế đôi: đi theo cặp (1-2, 3-4, ..., 9-10)
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
                            ),
                        ],

                        const SizedBox(width: 4),

                        // Nhãn hàng bên phải
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

          // Chú thích + giá (căn ngang đều)
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
                            : 'Ghế: ${_selected.join(', ')}',
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
                      'ĐẶT VÉ',
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
      textTier.add('Ghế thường x$std (${fmtCurrency(priceStandard)}/ghế)');
    if (cpl > 0)
      textTier.add('Ghế đôi x$cpl (${fmtCurrency(priceCouple)}/block)');

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
              child: const Text('Đóng')),
        ],
      ),
    );
    // Nếu muốn reset sau khi đặt xong:
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

class _CoupleSeatBlock extends StatelessWidget {
  final String row;
  final int from;
  final int to;
  final bool isBooked;
  final bool isSelected;
  final VoidCallback onTap;

  const _CoupleSeatBlock({
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
        width: 72, // ~ 2 ghế (34*2) + khoảng trống
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

/// ─────────────────── MINIMAL LANGUAGE SWITCHER (VIE / ENG) ───────────────────
/// - Cam (#FF7A00) / Cam nhạt
/// - Khung nhỏ: width/height tùy chỉnh
/// - Chữ VIE / ENG tự co vừa khung nhờ FittedBox
class LanguageSwitcherMini extends StatelessWidget {
  final bool isEnglish; // true: ENG, false: VIE
  final double width; // ví dụ: 56
  final double height; // ví dụ: 24
  final double fontSize; // ví dụ: 12
  final VoidCallback? onTapVI;
  final VoidCallback? onTapEN;

  const LanguageSwitcherMini({
    super.key,
    required this.isEnglish,
    required this.width,
    required this.height,
    required this.fontSize,
    this.onTapVI,
    this.onTapEN,
  });

  static const Color _orange = Color(0xFFFF7A00);
  static const Color _orangeLight = Color(0xFFFFE9D6);

  @override
  Widget build(BuildContext context) {
    final Radius r = const Radius.circular(999);
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(r),
        border: Border.all(color: _orange.withOpacity(.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MiniPill(
            label: 'VIE',
            selected: !isEnglish,
            width: width,
            height: height,
            fontSize: fontSize,
            selectedBg: _orange,
            unselectedBg: _orangeLight,
            selectedFg: Colors.white,
            unselectedFg: _orange,
            onTap: onTapVI,
          ),
          _MiniPill(
            label: 'ENG',
            selected: isEnglish,
            width: width,
            height: height,
            fontSize: fontSize,
            selectedBg: _orange,
            unselectedBg: _orangeLight,
            selectedFg: Colors.white,
            unselectedFg: _orange,
            onTap: onTapEN,
          ),
        ],
      ),
    );
  }
}

class _MiniPill extends StatelessWidget {
  final String label;
  final bool selected;
  final double width;
  final double height;
  final double fontSize;
  final Color selectedBg;
  final Color unselectedBg;
  final Color selectedFg;
  final Color unselectedFg;
  final VoidCallback? onTap;

  const _MiniPill({
    required this.label,
    required this.selected,
    required this.width,
    required this.height,
    required this.fontSize,
    required this.selectedBg,
    required this.unselectedBg,
    required this.selectedFg,
    required this.unselectedFg,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 120),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: selected ? selectedBg : unselectedBg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(999),
          onTap: onTap,
          child: Center(
            // FittedBox để chữ tự co vừa khung nhỏ
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                maxLines: 1,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w800,
                  color: selected ? selectedFg : unselectedFg,
                  letterSpacing: 0.5,
                  height: 1.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
