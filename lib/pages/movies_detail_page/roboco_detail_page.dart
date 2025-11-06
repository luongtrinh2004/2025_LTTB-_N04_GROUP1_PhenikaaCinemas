import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/booking_page.dart';

class RobocoDetailPage extends StatefulWidget {
  const RobocoDetailPage({super.key});

  @override
  State<RobocoDetailPage> createState() =>
      _RobocoDetailPageState();
}

class _RobocoDetailPageState
    extends State<RobocoDetailPage> {
  // Ảnh
  static const poster = 'img/roboco.jpg';
  static const stills = [
    'img/roboco.jpg',
    'img/roboco.jpg',
    'img/roboco.jpg',
  ];

  // Ngày/giờ chiếu
  final List<String> _dates = const [
    'Hôm nay',
    'Ngày mai',
    'Thứ 7'
  ];
  final List<String> _times = const [
    '09:00',
    '14:30',
    '18:45',
    '22:15'
  ];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Ghế còn (demo)
  final int _roomCapacity = 90;
  final Map<String, Map<String, int>> _remainingByDateTime =
      const {
    'Hôm nay': {
      '09:00': 60,
      '14:30': 35,
      '18:45': 12,
      '22:15': 70
    },
    'Ngày mai': {
      '09:00': 75,
      '14:30': 40,
      '18:45': 20,
      '22:15': 81
    },
    'Thứ 7': {
      '09:00': 30,
      '14:30': 22,
      '18:45': 10,
      '22:15': 18
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
              _Tag('Hoạt hình'),
              _Tag('Hài'),
              _Tag('P'),
            ],
          ),

          const SizedBox(height: 18),

          // Nội dung
          const _SectionTitle('Nội dung'),
          const SizedBox(height: 8),
          const Text(
            'Năm 20XX, cậu bé Bondo luôn mơ ước có một người bạn robot. '
            'Thế nhưng điều xuất hiện lại là Roboco – cô hầu gái “hậu đậu” nhưng mạnh vô đối. '
            'Một thế lực bí ẩn bóp méo các chiều không gian khiến vô số bản thể Roboco mắc kẹt tại Trái Đất. '
            'Bondo, Roboco và bạn bè buộc phải hợp sức để vạch trần ác nhân và bảo vệ những kẻ yếu thế.',
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
                          'Tớ và Roboco: Siêu Cấp Đa Vũ Trụ',
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
          'TỚ VÀ ROBOCO: SIÊU CẤP ĐA VŨ TRỤ',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('8.2 / 10',
                style:
                    TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('64 phút'),
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
                    'Ngôn ngữ: Tiếng Nhật, Phụ Đề/Lồng Tiếng Tiếng Việt & Tiếng Anh')),
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
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 16),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(text),
      backgroundColor: const Color(0xFFF1F3F6),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
    );
  }
}
