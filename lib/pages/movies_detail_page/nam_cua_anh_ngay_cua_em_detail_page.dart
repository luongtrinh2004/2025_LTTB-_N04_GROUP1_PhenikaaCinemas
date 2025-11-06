import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/booking_page.dart';

class NamCuaAnhNgayCuaEmDetailPage extends StatefulWidget {
  const NamCuaAnhNgayCuaEmDetailPage({super.key});

  @override
  State<NamCuaAnhNgayCuaEmDetailPage> createState() =>
      _NamCuaAnhNgayCuaEmDetailPageState();
}

class _NamCuaAnhNgayCuaEmDetailPageState
    extends State<NamCuaAnhNgayCuaEmDetailPage> {
  // Ảnh
  static const poster = 'img/namcuaanh_ngaycuaem.jpg';
  static const stills = [
    'img/namcuaanh_ngaycuaem.jpg',
    'img/namcuaanh_ngaycuaem.jpg',
    'img/namcuaanh_ngaycuaem.jpg',
  ];

  // Ngày / giờ
  final List<String> _dates = const [
    'Hôm nay',
    'Ngày mai',
    'Chủ nhật'
  ];
  final List<String> _times = const [
    '09:45',
    '13:00',
    '15:20',
    '18:30',
    '20:45'
  ];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Ghế còn (demo)
  final int _roomCapacity = 120;
  final Map<String, Map<String, int>> _remainingByDateTime =
      const {
    'Hôm nay': {
      '09:45': 70,
      '13:00': 44,
      '15:20': 28,
      '18:30': 16,
      '20:45': 88
    },
    'Ngày mai': {
      '09:45': 92,
      '13:00': 63,
      '15:20': 40,
      '18:30': 35,
      '20:45': 96
    },
    'Chủ nhật': {
      '09:45': 30,
      '13:00': 20,
      '15:20': 12,
      '18:30': 8,
      '20:45': 14
    },
  };

  String get _selectedDate => _dates[_dateIndex];
  String get _selectedTime => _times[_timeIndex];
  int get _seatsLeft =>
      _remainingByDateTime[_selectedDate]?[_selectedTime] ??
      _roomCapacity;

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
          // Poster + info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset(
                  poster,
                  width: 130,
                  height: 195,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 130,
                    height: 195,
                    color: const Color(0xFFF1F3F6),
                    alignment: Alignment.center,
                    child: const Icon(
                        Icons.broken_image_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: _MovieInfo()),
            ],
          ),

          const SizedBox(height: 18),

          // Thể loại
          const _SectionTitle('Thể loại'),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Tag('Tình cảm'),
              _Tag('Tuổi trẻ'),
              _Tag('T13'),
            ],
          ),

          const SizedBox(height: 18),

          // Nội dung
          const _SectionTitle('Nội dung'),
          const SizedBox(height: 8),
          const Text(
            'Khi thế giới bị chia cắt thành 2 chiều không gian song song, tình yêu nảy nở giữa hai người trẻ bị cuốn trôi theo hai nhịp sống khác biệt. '
            'Họ vẫn níu giữ sợi dây mong manh của định mệnh, cố tìm đến điểm giao nhau giữa hai thế giới để viết tiếp chuyện tình còn dang dở.',
          ),

          const SizedBox(height: 18),

          // Hình ảnh
          const _SectionTitle('Hình ảnh'),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: stills.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 12),
              itemBuilder: (_, i) => ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.asset(
                    stills[i],
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: const Color(0xFFF1F3F6),
                      alignment: Alignment.center,
                      child: const Icon(
                          Icons.broken_image_outlined),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Suất chiếu
          const _SectionTitle('Suất chiếu'),
          const SizedBox(height: 10),

          // Chọn ngày
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
              itemBuilder: (_, i) => ChoiceChip(
                label: Text(_dates[i]),
                selected: i == _dateIndex,
                onSelected: (_) =>
                    setState(() => _dateIndex = i),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Chọn giờ
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_times.length, (i) {
              final sel = i == _timeIndex;
              return InputChip(
                label: Text(_times[i]),
                selected: sel,
                onSelected: (_) =>
                    setState(() => _timeIndex = i),
              );
            }),
          ),

          const SizedBox(height: 8),
          Text(
            'Còn $_seatsLeft / $_roomCapacity ghế cho suất $_selectedTime • $_selectedDate',
            style: TextStyle(
                fontWeight: FontWeight.w600, color: subtle),
          ),

          const SizedBox(height: 24),

          // Đặt vé -> BookingPage
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(
                      movieTitle:
                          'Năm Của Anh, Ngày Của Em',
                      showDate: _selectedDate,
                      showTime: _selectedTime,
                    ),
                  ),
                );
              },
              child: const Text('Đặt vé phim'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieInfo extends StatelessWidget {
  const _MovieInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Năm Của Anh, Ngày Của Em',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('7.0 / 10',
                style:
                    TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('112 phút'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 18),
            SizedBox(width: 6),
            Text('Khởi chiếu: 2025'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.language_outlined, size: 18),
            SizedBox(width: 6),
            Expanded(
                child: Text(
                    'Ngôn ngữ: Tiếng Trung Quốc, phụ đề Tiếng Việt')),
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 16),
      );
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);
  @override
  Widget build(BuildContext context) => Chip(
        label: Text(text),
        backgroundColor: const Color(0xFFF1F3F6),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      );
}
