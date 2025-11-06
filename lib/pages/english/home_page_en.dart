import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/pages/english/all_movies_page_en.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// Import detail pages (reuse the same ones)
import 'package:flutter_cinema_booking_ui/pages/english/mai_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tay_anh_giu_mot_vi_sao_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tee_yod_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tu_chien_tren_khong_detail_page_en.dart';

import 'package:flutter_cinema_booking_ui/pages/english/avatar3_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/shin_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/nam_cua_anh_ngay_cua_em_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/gio_van_thoi_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/roboco_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/cai_ma_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/goodboy_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/cuc_vang_cua_ngoai_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/van_may_detail_page_en.dart';

class HomePageEn extends StatefulWidget {
  const HomePageEn({super.key});

  @override
  State<HomePageEn> createState() => _HomePageEnState();
}

class _HomePageEnState extends State<HomePageEn> {
  static const _orange = Color(0xFFFF7A00);

  // Keep movie titles as original (to match existing detail mapping)
  final List<Map<String, dynamic>> movies = const [
    {
      'title': 'MAI',
      'poster': 'img/mai.webp',
      'rating': 8.7,
      'duration': '120 min',
      'genres': ['Drama', 'Romance'],
    },
    {
      'title': 'Tay Anh Giữ Một Vì Sao',
      'poster': 'img/tay_anh_giu_mot_vi_sao.jpg',
      'rating': 8.3,
      'duration': '115 min',
      'genres': ['Romance', 'Comedy'],
    },
    {
      'title': 'Tee Yod',
      'poster': 'img/tee_yod.jpeg',
      'rating': 7.5,
      'duration': '110 min',
      'genres': ['Horror'],
    },
    {
      'title': 'Tử Chiến Trên Không',
      'poster': 'img/tu_chien_tren_khong.jpg',
      'rating': 7.9,
      'duration': '118 min',
      'genres': ['Action'],
    },
    {
      'title': 'Avatar 3',
      'poster': 'img/avatar3.jpg',
      'rating': 7.1,
      'duration': '157 min',
      'genres': ['Action'],
    },
    {
      'title':
          'Shin Cậu Bé Bút Chì: Nóng Bỏng Tay! Những Vũ Công Siêu Cay Kasukabe',
      'poster': 'img/shin.jpg',
      'rating': 9.0,
      'duration': '105 min',
      'genres': ['Comedy', 'Animation'],
    },
    {
      'title': 'Năm Của Anh, Ngày Của Em',
      'poster': 'img/namcuaanh_ngaycuaem.jpg',
      'rating': 7.0,
      'duration': '112 min',
      'genres': ['Romance'],
    },
    {
      'title': 'Gió Vẫn Thổi',
      'poster': 'img/giovanthoi.jpg',
      'rating': 8.6,
      'duration': '127 min',
      'genres': ['Animation', 'Drama'],
    },
    {
      'title': 'Cải Mả',
      'poster': 'img/caima.jpg',
      'rating': 7.5,
      'duration': '115 min',
      'genres': ['Horror'],
    },
    {
      'title': 'Cục Vàng Của Ngoại',
      'poster': 'img/cucvangcuangoai.jpg',
      'rating': 8.7,
      'duration': '119 min',
      'genres': ['Drama'],
    },
    {
      'title': 'Good Boy - Chó Cưng Đừng Sợ',
      'poster': 'img/goodboy.jpg',
      'rating': 7.5,
      'duration': '73 min',
      'genres': ['Horror'],
    },
    {
      'title': 'Tớ Và Roboco: Siêu Cấp Đa Vũ Trụ',
      'poster': 'img/roboco.jpg',
      'rating': 7.2,
      'duration': '64 min',
      'genres': ['Animation', 'Comedy'],
    },
    {
      'title': 'Vận May',
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

  void _openDetail(Map<String, dynamic> movie) {
    final title = (movie['title'] as String).trim().toLowerCase();
    Widget? page;

    if (title == 'mai') {
      page = const MaiDetailPageEn();
    } else if (title == 'tay anh giữ một vì sao' ||
        title == 'tay anh giu mot vi sao') {
      page = const TayAnhGiuMotViSaoDetailPageEn();
    } else if (title == 'tee yod') {
      page = const TeeYodDetailPageEn();
    } else if (title == 'tử chiến trên không' ||
        title == 'tu chien tren khong') {
      page = const TuChienTrenKhongDetailPageEn();
    } else if (title == 'avatar 3' || title == 'avatar3') {
      page = const Avatar3DetailPageEn();
    } else if (title ==
            'shin cậu bé bút chì: nóng bỏng tay! những vũ công siêu cay kasukabe' ||
        title ==
            'shin cau be but chi: nong bong tay! nhung vu cong sieu cay kasukabe') {
      page = const ShinDetailPageEn();
    } else if (title == 'năm của anh, ngày của em' ||
        title == 'nam cua anh, ngay cua em') {
      page = const NamCuaAnhNgayCuaEmDetailPageEn();
    } else if (title == 'gió vẫn thổi' || title == 'gio van thoi') {
      page = const GioVanThoiDetailPageEn();
    } else if (title == 'cải mả' || title == 'cai ma') {
      page = const CaiMaDetailPageEn();
    } else if (title == 'cục vàng của ngoại' || title == 'cuc vang cua ngoai') {
      page = const CucVangCuaNgoaiDetailPageEn();
    } else if (title == 'good boy - chó cưng đừng sợ' ||
        title == 'good boy - cho cung dung so') {
      page = const GoodBoyDetailPageEn();
    } else if (title == 'tớ và roboco: siêu cấp đa vũ trụ' ||
        title == 'to va roboco: sieu cap da vu tru') {
      page = const RobocoDetailPageEn();
    } else if (title == 'vận may' || title == 'van may') {
      page = const VanMayDetailPageEn();
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No detail page available for this movie yet.')),
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
                        _selectedCategory =
                            selected ? null : label; // toggle off on second tap
                      });
                    },
                  );
                },
              ),
            ),

            const SizedBox(height: 22),

            // --- Now Playing ---
            _SectionHeader(
              title: 'Now Showing',
              action: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AllMoviesPageEn(
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
                      builder: (_) => AllMoviesPageEn(
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
// ────────────────────────────────────────────────────────────
//   ACCOUNT BUTTON (English)
// ────────────────────────────────────────────────────────────
//
class _AccountButton extends StatelessWidget {
  const _AccountButton();

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'logout') {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        } else if (v == 'profile') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Go to Profile')),
          );
        } else if (v == 'tickets') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Go to My tickets')),
          );
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'profile', child: Text('Profile')),
        PopupMenuItem(value: 'tickets', child: Text('My tickets')),
        PopupMenuItem(value: 'logout', child: Text('Log out')),
      ],
      offset: const Offset(0, kToolbarHeight),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          CircleAvatar(radius: 18, child: Icon(Icons.person, size: 20)),
          SizedBox(width: 4),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

//
// ────────────────────────────────────────────────────────────
//   SUB WIDGETS
// ────────────────────────────────────────────────────────────
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
            // Tappable poster
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
