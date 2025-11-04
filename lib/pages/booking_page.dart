import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

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
  final int seatsPerRow = 9;
  static const double seatPrice = 70000;

  // Ghế đã chọn
  final Set<String> _selected = {};

  // Giả lập một số ghế đã có người đặt (không click được)
  final Set<String> _booked = {
    'A4',
    'A5',
    'B3',
    'B4',
    'C5',
    'D6',
    'E2',
    'E5',
    'E6',
    'F4',
    'F5',
    'F7',
    'G1',
    'H9'
  };

  void _toggle(String id) {
    if (_booked.contains(id)) return; // đã đặt thì thôi
    setState(() {
      if (_selected.contains(id)) {
        _selected.remove(id);
      } else {
        _selected.add(id);
      }
    });
  }

  int get _count => _selected.length;
  double get _total => _count * seatPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // nền trắng
      appBar: AppHeader(
        right: TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ),
      body: Column(
        children: [
          // Thông tin cụm rạp / suất chiếuWWWWWW
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade300),
              ),
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.grey.shade300,
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

                        // Ghế 1..9
                        ...List.generate(seatsPerRow, (i) {
                          final id = '$r${i + 1}';
                          final isBooked = _booked.contains(id);
                          final isSelected = _selected.contains(id);

                          Color bg;
                          Color border = Colors.grey.shade300;
                          Widget child;

                          if (isBooked) {
                            bg = Colors.grey.shade200; // đã đặt
                            child = Icon(Icons.close,
                                size: 16, color: Colors.grey.shade600);
                          } else if (isSelected) {
                            bg = kOrange; // đang chọn
                            border = kOrange.withOpacity(.8);
                            child = const Text(
                              '✓',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            );
                          } else {
                            bg = Colors.white; // trống
                            child = Text(
                              (i + 1).toString(),
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
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
                                borderRadius: BorderRadius.circular(6),
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
                        }),

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

          // Chú thích + giá
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Legend(
                        color: Colors.white,
                        borderColor: Colors.grey.shade300,
                        label: 'Trống'),
                    const SizedBox(width: 16),
                    _Legend(
                        color: kOrange,
                        label: 'Đang chọn',
                        foreground: Colors.white),
                    const SizedBox(width: 16),
                    _Legend(
                        color: Colors.grey.shade200,
                        borderColor: Colors.grey.shade300,
                        label: 'Đã đặt',
                        icon: Icons.close),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Giá: ${seatPrice.toStringAsFixed(0)} đ / ghế',
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
              border: Border(
                top: BorderSide(color: Colors.grey.shade300),
              ),
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
                        '${_total.toStringAsFixed(0)} đ',
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
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Đặt ${_count} ghế: ${_selected.join(', ')} • ${_total.toStringAsFixed(0)} đ',
                                ),
                              ),
                            );
                          },
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
}

class _Legend extends StatelessWidget {
  final Color color;
  final Color? borderColor;
  final String label;
  final IconData? icon;
  final Color? foreground;

  const _Legend({
    required this.color,
    this.borderColor,
    required this.label,
    this.icon,
    this.foreground,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: borderColor ?? color),
          ),
          child: icon == null
              ? null
              : Icon(icon, size: 14, color: Colors.grey.shade600),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: foreground ?? Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
