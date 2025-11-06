import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/english/booking_page_en.dart';

class GoodBoyDetailPageEn extends StatefulWidget {
  const GoodBoyDetailPageEn({super.key});

  @override
  State<GoodBoyDetailPageEn> createState() => _GoodBoyDetailPageEnState();
}

class _GoodBoyDetailPageEnState extends State<GoodBoyDetailPageEn> {
  // Images
  static const poster = 'img/goodboy.jpg';
  static const stills = [
    'img/goodboy.jpg',
    'img/goodboy.jpg',
    'img/goodboy.jpg',
  ];

  // Date & time selection
  final List<String> _dates = const ['Today', 'Tomorrow', 'Saturday'];
  final List<String> _times = const ['11:00', '14:15', '17:40', '21:00'];
  int _dateIndex = 0;
  int _timeIndex = 0;

  // Remaining seats (demo)
  final int _roomCapacity = 90;
  final Map<String, Map<String, int>> _remainingByDateTime = const {
    'Today': {'11:00': 45, '14:15': 22, '17:40': 12, '21:00': 58},
    'Tomorrow': {'11:00': 60, '14:15': 38, '17:40': 20, '21:00': 70},
    'Saturday': {'11:00': 28, '14:15': 18, '17:40': 10, '21:00': 15},
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
              _TagEn('Horror'),
              _TagEn('Survival'),
              _TagEn('16+'),
            ],
          ),

          const SizedBox(height: 18),

          // Synopsis
          const _SectionTitleEn('Synopsis'),
          const SizedBox(height: 8),
          const Text(
            'The film follows Indy, a loyal dog who moves with his owner Todd to a quiet countryside house. '
            'Indy soon senses sinister supernatural forces lurking in the dark and must fight to protect the human he loves '
            'when malevolent entities set their sights on Todd.',
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

          // pick date
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

          // pick time
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
                      movieTitle: 'GOOD BOY',
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
          'GOOD BOY',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
        ),
        SizedBox(height: 6),
        Row(
          children: [
            Icon(Icons.star_rounded, color: kOrange),
            SizedBox(width: 6),
            Text('7.5 / 10', style: TextStyle(fontWeight: FontWeight.w600)),
            SizedBox(width: 12),
            Icon(Icons.access_time, size: 18),
            SizedBox(width: 6),
            Text('73 min'),
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
              child: Text('Languages: English; Subtitles: Vietnamese'),
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
