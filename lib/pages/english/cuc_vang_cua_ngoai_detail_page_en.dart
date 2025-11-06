// lib/pages/english/movies_detail_page/cuc_vang_cua_ngoai_detail_page_en.dart
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/english/booking_page_en.dart';

class CucVangCuaNgoaiDetailPageEn extends StatefulWidget {
  const CucVangCuaNgoaiDetailPageEn({super.key});

  @override
  State<CucVangCuaNgoaiDetailPageEn> createState() =>
      _CucVangCuaNgoaiDetailPageEnState();
}

class _CucVangCuaNgoaiDetailPageEnState
    extends State<CucVangCuaNgoaiDetailPageEn> {
  // Assets
  static const poster = 'img/cucvangcuangoai.jpg';
  // TODO: replace with real stills if available
  static const stills = [
    'img/cucvangcuangoai.jpg',
    'img/cucvangcuangoai.jpg',
    'img/cucvangcuangoai.jpg',
  ];

  // Date/Time chips (EN)
  final List<String> _dates = const ['Today', 'Tomorrow', 'Sat'];
  final List<String> _times = const ['10:00', '13:30', '16:45', '20:15'];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Seats demo
  final int _roomCapacity = 120;
  final Map<String, Map<String, int>> _remainingByDateTime = const {
    'Today': {'10:00': 70, '13:30': 42, '16:45': 16, '20:15': 60},
    'Tomorrow': {'10:00': 64, '13:30': 38, '16:45': 25, '20:15': 82},
    'Sat': {'10:00': 30, '13:30': 20, '16:45': 10, '20:15': 18},
  };

  String get _selectedDate => _dates[_dateIndex];
  String get _selectedTime => _times[_timeIndex];
  int get _seatsLeft =>
      _remainingByDateTime[_selectedDate]?[_selectedTime] ?? _roomCapacity;

  @override
  Widget build(BuildContext context) {
    final subtle = Theme.of(context).colorScheme.onSurface.withOpacity(.7);

    return Scaffold(
      appBar: const AppHeader(), // header giữ nguyên như bản VN
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
                    child: const Icon(Icons.broken_image_outlined),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(child: _MovieInfoEn()),
            ],
          ),

          const SizedBox(height: 18),

          // Genres
          const _SectionTitle('Genres'),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [_Tag('Drama'), _Tag('Family'), _Tag('13+')],
          ),

          const SizedBox(height: 18),

          // Synopsis
          const _SectionTitle('Synopsis'),
          const SizedBox(height: 8),
          const Text(
            'Inspired by tender childhood memories, “Grandma’s Little Treasure” tells a warm story '
            'about the bond between a grandmother and her grandchild in a close-knit neighborhood. '
            'Mrs. Hau, a woman who has worked tirelessly all her life, becomes the only support for her grandchild '
            'after her daughter leaves. Despite hardships, her love remains whole and unwavering. '
            'To her, the child is a “little treasure” — a source of joy, comfort, and purpose. '
            'The film gently brings audiences back to familiar moments of a small alley: a child’s innocent smile, '
            'a grandmother’s protective embrace, and the kindness of neighbors — weaving an intimate portrait of everyday life, '
            'evoking a peaceful childhood and sincere, rustic humanity.',
          ),

          const SizedBox(height: 18),

          // Stills
          const _SectionTitle('Stills'),
          const SizedBox(height: 10),
          SizedBox(
            height: 120,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: stills.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
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
                      child: const Icon(Icons.broken_image_outlined),
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          // Showtimes
          const _SectionTitle('Showtimes'),
          const SizedBox(height: 10),

          // select date
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _dates.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) => ChoiceChip(
                label: Text(_dates[i]),
                selected: i == _dateIndex,
                onSelected: (_) => setState(() => _dateIndex = i),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // select time
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: List.generate(_times.length, (i) {
              final sel = i == _timeIndex;
              return InputChip(
                label: Text(_times[i]),
                selected: sel,
                onSelected: (_) => setState(() => _timeIndex = i),
              );
            }),
          ),

          const SizedBox(height: 8),
          Text(
            '$_seatsLeft / $_roomCapacity seats left for $_selectedTime • $_selectedDate',
            style: TextStyle(fontWeight: FontWeight.w600, color: subtle),
          ),

          const SizedBox(height: 24),

          // Book button -> BookingPage (VN)
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPageEn(
                      movieTitle: 'Cuc Vang Cua Ngoai',
                      showDate: _selectedDate,
                      showTime: _selectedTime,
                    ),
                  ),
                );
              },
              child: const Text('Book tickets'),
            ),
          ),
        ],
      ),
    );
  }
}

class _MovieInfoEn extends StatelessWidget {
  const _MovieInfoEn();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CUC VANG CUA NGOAI',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('8.7 / 10', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('119 min'),
          ],
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.calendar_today_outlined, size: 18),
            SizedBox(width: 6),
            Text('Release: 2025'),
          ],
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.language_outlined, size: 18),
            SizedBox(width: 6),
            Expanded(child: Text('Languages: Vietnamese, English subtitles')),
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
      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
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
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
