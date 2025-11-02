// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';

class NamCuaAnhNgayCuaEmDetailPage extends StatelessWidget {
  const NamCuaAnhNgayCuaEmDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    const poster = 'img/namcuanh_ngaycuaem.jpg';
    const stills = [
      'img/mai.webp', // bạn có thể thêm các ảnh khác nếu có
      'img/mai.webp',
      'img/mai.webp',
    ];

    return Scaffold(
      appBar: const AppHeader(),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
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
          const _SectionTitle('Thể loại'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              _Tag('Tình cảm'),
              _Tag('Tuổi trẻ'),
              _Tag('T13'),
            ],
          ),
          const SizedBox(height: 18),
          const _SectionTitle('Nội dung'),
          const SizedBox(height: 8),
          const Text(
            'Khi thế giới bị chia cắt thành 2 chiều không gian song song, tình yêu nảy nở giữa Hứa Quang Hán và Viên Lễ Lâm bị cuốn trôi theo hai nhịp sống khác biệt.'
            'Họ vẫn níu giữ sợi dây mong manh của định mệnh, cố tìm đến điểm giao nhau giữa hai thế giới để viết tiếp chuyện tình còn dang dở.'
            'Một bản tình ca lặng lẽ và day dứt, nơi Hứa Quang Hán nhẹ nhàng mang đến những nốt lặng bồi hồi, liệu tình yêu có đủ để vượt qua giới hạn của không gian và thời gian?',
          ),
          const SizedBox(height: 18),
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
            children: _times
                .map((t) => InputChip(
                      label: Text(t),
                      selected: t == _times.first,
                      onSelected: (_) {},
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
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

const _times = [
  '09:45',
  '13:00',
  '15:20',
  '18:30',
  '20:45'
];
const _dates = ['Hôm nay', 'Ngày mai', 'Chủ nhật'];

class _MovieInfo extends StatelessWidget {
  const _MovieInfo();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Năm Của Anh, Ngày Của Em',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w800)),
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
  Widget build(BuildContext context) => Text(text,
      style: const TextStyle(
          fontWeight: FontWeight.w700, fontSize: 16));
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
