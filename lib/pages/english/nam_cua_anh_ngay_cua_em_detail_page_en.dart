import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/english/booking_page_en.dart';

class NamCuaAnhNgayCuaEmDetailPageEn extends StatefulWidget {
  const NamCuaAnhNgayCuaEmDetailPageEn({super.key});

  @override
  State<NamCuaAnhNgayCuaEmDetailPageEn> createState() =>
      _NamCuaAnhNgayCuaEmDetailPageEnState();
}

class _NamCuaAnhNgayCuaEmDetailPageEnState
    extends State<NamCuaAnhNgayCuaEmDetailPageEn> {
  // Images
  static const poster = 'img/namcuaanh_ngaycuaem.jpg';
  static const stills = [
    'img/namcuaanh_ngaycuaem.jpg',
    'img/namcuaanh_ngaycuaem.jpg',
    'img/namcuaanh_ngaycuaem.jpg',
  ];

  // Dates / times
  final List<String> _dates = const ['Today', 'Tomorrow', 'Sunday'];
  final List<String> _times = const [
    '09:45',
    '13:00',
    '15:20',
    '18:30',
    '20:45'
  ];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Remaining seats (demo)
  final int _roomCapacity = 120;
  final Map<String, Map<String, int>> _remainingByDateTime = const {
    'Today': {'09:45': 70, '13:00': 44, '15:20': 28, '18:30': 16, '20:45': 88},
    'Tomorrow': {
      '09:45': 92,
      '13:00': 63,
      '15:20': 40,
      '18:30': 35,
      '20:45': 96
    },
    'Sunday': {'09:45': 30, '13:00': 20, '15:20': 12, '18:30': 8, '20:45': 14},
  };

  String get _selectedDate => _dates[_dateIndex];
  String get _selectedTime => _times[_timeIndex];
  int get _seatsLeft =>
      _remainingByDateTime[_selectedDate]?[_selectedTime] ?? _roomCapacity;

  @override
  Widget build(BuildContext context) {
    final subtle = Theme.of(context).colorScheme.onSurface.withOpacity(.7);

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
          const _SectionTitleEn('Genres'),
          const SizedBox(height: 8),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagEn('Romance'),
              _TagEn('Youth'),
              _TagEn('13+'),
            ],
          ),

          const SizedBox(height: 18),

          // Synopsis
          const _SectionTitleEn('Synopsis'),
          const SizedBox(height: 8),
          const Text(
            'When the world splits into two parallel dimensions, love blossoms between two young people living on different timelines. '
            'They cling to a fragile thread of fate, striving to find the intersection between their worlds to continue a love story left unfinished.',
          ),

          const SizedBox(height: 18),

          // Stills
          const _SectionTitleEn('Stills'),
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
          const _SectionTitleEn('Showtimes'),
          const SizedBox(height: 10),

          // Pick date
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

          // Pick time
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

          // Book -> BookingPageEn
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookingPageEn(
                      // You can rename the display title if you have an official English title
                      movieTitle: 'Your Year, My Day',
                      showDate: _selectedDate,
                      showTime: _selectedTime,
                    ),
                  ),
                );
              },
              child: const Text('Book Tickets'),
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
          'Your Year, My Day',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('7.0 / 10', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('112 min'),
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
            Expanded(
              child: Text('Language: Chinese; Subtitles: Vietnamese'),
            ),
          ],
        ),
      ],
    );
  }
}

class _SectionTitleEn extends StatelessWidget {
  final String text;
  const _SectionTitleEn(this.text);
  @override
  Widget build(BuildContext context) => Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      );
}

class _TagEn extends StatelessWidget {
  final String text;
  const _TagEn(this.text);
  @override
  Widget build(BuildContext context) => Chip(
        label: Text(text),
        backgroundColor: const Color(0xFFF1F3F6),
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      );
}
