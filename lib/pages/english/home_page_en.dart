import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// Back to Vietnamese home when toggling language
import 'package:flutter_cinema_booking_ui/pages/home_page.dart';

// Reuse the existing AllMoviesPage (neutral enough)
import 'package:flutter_cinema_booking_ui/pages/all_movies_page.dart';

// Reuse VI detail pages (to avoid creating EN duplicates)
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/mai_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tay_anh_giu_mot_vi_sao_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tee_yod_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tu_chien_tren_khong_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/avatar3_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/shin_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/nam_cua_anh_ngay_cua_em_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/gio_van_thoi_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/roboco_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/cai_ma_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/goodboy_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/cuc_vang_cua_ngoai_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/van_may_detail_page.dart';

class HomePageEn extends StatefulWidget {
  const HomePageEn({super.key});
  @override
  State<HomePageEn> createState() => _HomePageEnState();
}

class _HomePageEnState extends State<HomePageEn> {
  static const _orange = Color(0xFFFF7A00);

  /// Same routeKey so we can navigate to existing VI detail pages safely
  final List<Map<String, dynamic>> movies = const [
    {
      'routeKey': 'mai',
      'title': 'MAI',
      'poster': 'img/mai.webp',
      'rating': 8.7,
      'duration': '120 min',
      'genres': ['Drama', 'Romance'],
    },
    {
      'routeKey': 'tay_anh_giu_mot_vi_sao',
      'title': 'Hold A Star For Me',
      'poster': 'img/tay_anh_giu_mot_vi_sao.jpg',
      'rating': 8.3,
      'duration': '115 min',
      'genres': ['Romance', 'Comedy'],
    },
    {
      'routeKey': 'tee_yod',
      'title': 'Tee Yod',
      'poster': 'img/tee_yod.jpeg',
      'rating': 7.5,
      'duration': '110 min',
      'genres': ['Horror'],
    },
    {
      'routeKey': 'tu_chien_tren_khong',
      'title': 'Air Battle',
      'poster': 'img/tu_chien_tren_khong.jpg',
      'rating': 7.9,
      'duration': '118 min',
      'genres': ['Action'],
    },
    {
      'routeKey': 'avatar3',
      'title': 'Avatar 3',
      'poster': 'img/avatar3.jpg',
      'rating': 7.1,
      'duration': '157 min',
      'genres': ['Action'],
    },
    {
      'routeKey': 'shin',
      'title': 'Crayon Shin-chan: Super Spicy Kasukabe Dancers',
      'poster': 'img/shin.jpg',
      'rating': 9.0,
      'duration': '105 min',
      'genres': ['Comedy', 'Animation'],
    },
    {
      'routeKey': 'nam_cua_anh_ngay_cua_em',
      'title': 'Your Year, My Day',
      'poster': 'img/namcuaanh_ngaycuaem.jpg',
      'rating': 7.0,
      'duration': '112 min',
      'genres': ['Romance'],
    },
    {
      'routeKey': 'gio_van_thoi',
      'title': 'The Wind Rises (2025)',
      'poster': 'img/giovanthoi.jpg',
      'rating': 8.6,
      'duration': '127 min',
      'genres': ['Animation', 'Drama'],
    },
    {
      'routeKey': 'cai_ma',
      'title': 'Grave Relocation',
      'poster': 'img/caima.jpg',
      'rating': 7.5,
      'duration': '115 min',
      'genres': ['Horror'],
    },
    {
      'routeKey': 'cuc_vang_cua_ngoai',
      'title': 'Grandma’s Little Treasure',
      'poster': 'img/cucvangcuangoai.jpg',
      'rating': 8.7,
      'duration': '119 min',
      'genres': ['Drama'],
    },
    {
      'routeKey': 'goodboy',
      'title': 'Good Boy',
      'poster': 'img/goodboy.jpg',
      'rating': 7.5,
      'duration': '73 min',
      'genres': ['Horror'],
    },
    {
      'routeKey': 'roboco',
      'title': 'Me & Roboco: Multiverse Mayhem',
      'poster': 'img/roboco.jpg',
      'rating': 7.2,
      'duration': '64 min',
      'genres': ['Animation', 'Comedy'],
    },
    {
      'routeKey': 'van_may',
      'title': 'Lucky Day',
      'poster': 'img/vanmay.jpg',
      'rating': 7.9,
      'duration': '98 min',
      'genres': ['Action', 'Comedy'],
    },
  ];

  late final PageController _page;
  Timer? _auto;
  String? _selectedCategory; // null = All

  @override
  void initState() {
    super.initState();
    _page = PageController(
      initialPage: movies.length * 1000,
      viewportFraction: .62,
    );

    _auto = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!mounted) return;
      final next = (_page.page ?? _page.initialPage.toDouble()).round() + 1;
      _page.animateToPage(
        next,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _auto?.cancel();
    _page.dispose();
    super.dispose();
  }

  Widget? _routeFor(String routeKey) {
    switch (routeKey) {
      case 'mai':
        return const MaiDetailPage();
      case 'tay_anh_giu_mot_vi_sao':
        return const TayAnhGiuMotViSaoDetailPage();
      case 'tee_yod':
        return const TeeYodDetailPage();
      case 'tu_chien_tren_khong':
        return const TuChienTrenKhongDetailPage();
      case 'avatar3':
        return const Avatar3DetailPage();
      case 'shin':
        return const ShinDetailPage();
      case 'nam_cua_anh_ngay_cua_em':
        return const NamCuaAnhNgayCuaEmDetailPage();
      case 'gio_van_thoi':
        return const GioVanThoiDetailPage();
      case 'cai_ma':
        return const CaiMaDetailPage();
      case 'cuc_vang_cua_ngoai':
        return const CucVangCuaNgoaiDetailPage();
      case 'goodboy':
        return const GoodBoyDetailPage();
      case 'roboco':
        return const RobocoDetailPage();
      case 'van_may':
        return const VanMayDetailPage();
      default:
        return null;
    }
  }

  void _openDetail(Map<String, dynamic> movie) {
    final key = (movie['routeKey'] as String?) ?? '';
    final page = _routeFor(key);
    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Detail page not available yet.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Romance',
      'Comedy',
      'Horror',
      'Drama',
      'Action',
      'Animation',
    ];
    final filteredMovies = _selectedCategory == null
        ? movies
        : movies.where((m) {
            final gs = (m['genres'] as List).cast<String>();
            return gs.contains(_selectedCategory);
          }).toList();

    return Scaffold(
      appBar: const AppHeader(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- Language Switcher (VI / EN) ---
            const LanguageSwitcherEn(isEnglish: true),
            const SizedBox(height: 16),

            // --- Search ---
            TextField(
              decoration: InputDecoration(
                hintText: 'Search movies, genres…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // --- Categories ---
            const Text('Genres', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) {
                  final label = categories[i];
                  final selected = _selectedCategory == label;
                  return ChoiceChip(
                    label: Text(label),
                    selected: selected,
                    onSelected: (_) {
                      setState(() {
                        _selectedCategory = selected ? null : label;
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // --- Now Playing ---
            _SectionHeader(
              title: 'Now Playing',
              action: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllMoviesPage(
                        allMovies: movies,
                        initialCategory: _selectedCategory,
                        onOpenDetail: (m) => _openDetail(m),
                      ),
                    ),
                  );
                },
                child: const Text('See all'),
              ),
            ),
            const SizedBox(height: 12),

            // --- Carousel ---
            SizedBox(
              height: 330,
              child: PageView.builder(
                controller: _page,
                padEnds: false,
                itemBuilder: (context, index) {
                  if (filteredMovies.isEmpty) {
                    return const Center(child: Text('No movies in this genre'));
                  }
                  final movie = filteredMovies[index % filteredMovies.length];
                  return AnimatedBuilder(
                    animation: _page,
                    builder: (context, child) {
                      double currentPage = 0;
                      try {
                        currentPage =
                            _page.page ?? _page.initialPage.toDouble();
                      } catch (_) {}
                      final diff = (index - currentPage).abs();
                      final scale = 1 - (diff * 0.12).clamp(0.0, 0.12);
                      return Transform.scale(scale: scale, child: child);
                    },
                    child: _MoviePosterCard(
                      movie: movie,
                      onTap: () => _openDetail(movie),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),

            // --- Indicator ---
            Center(
              child: AnimatedBuilder(
                animation: _page,
                builder: (_, __) {
                  final len = filteredMovies.length;
                  if (len == 0) return const SizedBox.shrink();
                  final cur =
                      ((_page.page ?? _page.initialPage.toDouble()).round()) %
                          len;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(len, (i) {
                      final active = cur == i;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: active ? 10 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color:
                              active ? _orange : Colors.black.withOpacity(.2),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      );
                    }),
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // --- Coming Soon ---
            _SectionHeader(
              title: 'Coming Soon',
              action: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllMoviesPage(
                        allMovies: movies,
                        initialCategory: _selectedCategory,
                        onOpenDetail: (m) => _openDetail(m),
                      ),
                    ),
                  );
                },
                child: const Text('See all'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: filteredMovies.isEmpty
                  ? const Center(child: Text('No movies'))
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: filteredMovies.length,
                      separatorBuilder: (_, __) => const SizedBox(width: 14),
                      itemBuilder: (_, i) => _SmallMovieTile(
                        movie: filteredMovies[(i + 1) % filteredMovies.length],
                        onTap: () => _openDetail(
                          filteredMovies[(i + 1) % filteredMovies.length],
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

//
// ───────────── LANGUAGE SWITCHER (EN page) ─────────────
//
class LanguageSwitcherEn extends StatelessWidget {
  final bool isEnglish;
  const LanguageSwitcherEn({super.key, required this.isEnglish});

  @override
  Widget build(BuildContext context) {
    final selectedStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
        );
    final unselectedStyle = Theme.of(context).textTheme.labelLarge;

    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FA),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LangChip(
            label: 'Vietnamese',
            selected: !isEnglish,
            onTap: () {
              // switch back to VI
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomePage()),
              );
            },
            selectedStyle: selectedStyle,
            unselectedStyle: unselectedStyle,
          ),
          _LangChip(
            label: 'English',
            selected: isEnglish,
            onTap: () {},
            selectedStyle: selectedStyle,
            unselectedStyle: unselectedStyle,
          ),
        ],
      ),
    );
  }
}

class _LangChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final TextStyle? selectedStyle;
  final TextStyle? unselectedStyle;

  const _LangChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedStyle,
    required this.unselectedStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      margin: const EdgeInsets.all(1),
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(999),
        boxShadow: selected
            ? [
                BoxShadow(
                    color: Colors.black.withOpacity(.06),
                    blurRadius: 8,
                    offset: const Offset(0, 4))
              ]
            : null,
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(999),
        onTap: onTap,
        child: Text(label, style: selected ? selectedStyle : unselectedStyle),
      ),
    );
  }
}

//
// ────────────────── SUB WIDGETS ──────────────────
//
class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;
  const _SectionHeader({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
        action ?? const SizedBox.shrink(),
      ],
    );
  }
}

class _MoviePosterCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  final VoidCallback? onTap;

  const _MoviePosterCard({
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(16);
    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: SizedBox(
        width: 190,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster (tappable)
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(radius),
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: AssetImage(movie['poster'] as String),
                    fit: BoxFit.cover,
                    child: InkWell(onTap: onTap),
                    onImageError: (_, __) {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              movie['title'] as String,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: kOrange, size: 18),
                const SizedBox(width: 4),
                Text('${movie['rating']}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SmallMovieTile extends StatelessWidget {
  final Map<String, dynamic> movie;
  final VoidCallback? onTap;

  const _SmallMovieTile({
    required this.movie,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      child: Row(
        children: [
          GestureDetector(
            onTap: onTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                movie['poster'] as String,
                height: 150,
                width: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 150,
                  width: 100,
                  color: const Color(0xFFF1F3F6),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie['title'] as String,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 16),
                      const SizedBox(width: 6),
                      Text((movie['duration'] as String?) ?? ''),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonal(
                    onPressed: onTap,
                    child: const Text('Remind me'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
