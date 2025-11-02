import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';

class Avatar3DetailPage extends StatelessWidget {
  const Avatar3DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const poster = 'img/avatar3.jpg';
    const stills = [
      'img/avatar3.jpg', // bạn có thể thêm các ảnh khác nếu có
      'img/avatar3.jpg',
      'img/avatar3.jpg',
    ];

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
              const Expanded(
                child: _MovieInfo(),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // Chips thể loại
          const _SectionTitle('Thể loại'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Tag('Hành động'),
              _Tag('Giả tưởng'),
              _Tag('16+'),
            ],
          ),

          const SizedBox(height: 18),

          // Nội dung
          const _SectionTitle('Nội dung'),
          const SizedBox(height: 8),
          const Text(
            'Avatar 3: Lửa và Tro tàn sẽ tiếp tục hành trình của gia đình Jake Sully sau những sự kiện trong Avatar:'
            'Dòng chảy của nước, nhưng lần này họ phải đối mặt với mâu thuẫn nội tâm do cái chết của Neteyam và'
            'sự xuất hiện của một bộ tộc Na vi mới: Bộ tộc Lửa (Ash People).',
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

          // Suất chiếu (UI)
          const _SectionTitle('Suất chiếu'),
          const SizedBox(height: 10),
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
              itemBuilder: (_, i) => ChoiceChip(
                label: Text(_dates[i]),
                selected: i == 0,
                onSelected: (_) {},
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _times.map((t) {
              return InputChip(
                label: Text(t),
                selected: t == _times.first,
                onSelected: (_) {},
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          // Nút đặt vé
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                // UI demo: bạn có thể điều hướng sang trang chọn suất / ghế sau
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content:
                          Text('Đi đến đặt vé (UI demo)')),
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

const _times = ['09:00', '14:30', '18:45', '22:15'];
const _dates = ['Hôm nay', 'Ngày mai', 'Thứ 7'];

class _MovieInfo extends StatelessWidget {
  const _MovieInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AVATAR 3',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('7.1 / 10',
                style:
                    TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('157 phút'),
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
                    'Ngôn ngữ: Tiếng Anh, phụ đề tiếng Việt')),
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
