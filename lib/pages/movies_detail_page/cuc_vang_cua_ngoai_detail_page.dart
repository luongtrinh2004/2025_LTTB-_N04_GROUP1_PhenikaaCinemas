import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/booking_page.dart';

class CucVangCuaNgoaiDetailPage extends StatefulWidget {
  const CucVangCuaNgoaiDetailPage({super.key});

  @override
  State<CucVangCuaNgoaiDetailPage> createState() =>
      _CucVangCuaNgoaiDetailPageState();
}

class _CucVangCuaNgoaiDetailPageState
    extends State<CucVangCuaNgoaiDetailPage> {
  // Ảnh
  static const poster = 'img/cucvangcuangoai.jpg';
  // TODO: thay bằng ảnh hậu trường đúng nếu có
  static const stills = [
    'img/cucvangcuangoai.jpg',
    'img/cucvangcuangoai.jpg',
    'img/cucvangcuangoai.jpg',
  ];

  // Chọn ngày/giờ
  final List<String> _dates = const [
    'Hôm nay',
    'Ngày mai',
    'Thứ 7'
  ];
  final List<String> _times = const [
    '10:00',
    '13:30',
    '16:45',
    '20:15'
  ];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Ghế còn (demo)
  final int _roomCapacity = 120;
  final Map<String, Map<String, int>> _remainingByDateTime =
      const {
    'Hôm nay': {
      '10:00': 70,
      '13:30': 42,
      '16:45': 16,
      '20:15': 60
    },
    'Ngày mai': {
      '10:00': 64,
      '13:30': 38,
      '16:45': 25,
      '20:15': 82
    },
    'Thứ 7': {
      '10:00': 30,
      '13:30': 20,
      '16:45': 10,
      '20:15': 18
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Tag('Tâm lý'),
              _Tag('Gia đình'),
              _Tag('13+'),
            ],
          ),

          const SizedBox(height: 18),

          // Nội dung
          const _SectionTitle('Nội dung'),
          const SizedBox(height: 8),
          const Text(
            'Lấy cảm hứng từ những ký ức tuổi thơ ngọt ngào, “Cục Vàng Của Ngoại” mang đến câu chuyện ấm áp về tình bà cháu trong một xóm nhỏ chan chứa nghĩa tình. '
            'Bà Hậu – người phụ nữ cả đời tần tảo, nay trở thành chỗ dựa duy nhất của cháu ngoại khi con gái bỏ đi. '
            'Dẫu cuộc sống còn nhiều nhọc nhằn, tình thương bà dành cho cháu vẫn luôn trọn vẹn. '
            'Với bà, cháu là “cục vàng” – niềm vui, niềm an ủi và cũng là lẽ sống của đời mình. '
            'Bộ phim nhẹ nhàng dẫn khán giả trở lại những khoảnh khắc quen thuộc nơi xóm nhỏ: nụ cười hồn nhiên của cháu, vòng tay chở che của bà và sự đùm bọc từ hàng xóm láng giềng. '
            'Tất cả cùng hòa thành một bức tranh đời thường ấm áp, gợi nhắc về tuổi thơ bình yên và tình người mộc mạc, chân thành.',
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

          // chọn ngày
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

          // chọn giờ
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

          // Nút đặt vé -> BookingPage
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPage(
                      movieTitle: 'Cục Vàng Của Ngoại',
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
          'CỤC VÀNG CỦA NGOẠI',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('8.7 / 10',
                style:
                    TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('119 phút'),
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
                    'Ngôn ngữ: Tiếng Việt, phụ đề Tiếng Anh')),
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
