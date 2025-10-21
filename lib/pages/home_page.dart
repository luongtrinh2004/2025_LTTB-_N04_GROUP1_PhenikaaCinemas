import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// IMPORT các trang chi tiết phim
import 'movies_detail_page/mai_detail_page.dart';
import 'movies_detail_page/tay_anh_giu_mot_vi_sao_detail_page.dart';
import 'movies_detail_page/tee_yod_detail_page.dart';
import 'movies_detail_page/tu_chien_tren_khong_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _orange = Color(0xFFFF7A00);

  final List<Map<String, Object>> movies = const [
    {'title': 'MAI', 'poster': 'img/mai.webp', 'rating': 8.7},
    {
      'title': 'Tay Anh Giữ Một Vì Sao',
      'poster': 'img/tay_anh_giu_mot_vi_sao.jpg',
      'rating': 8.3
    },
    {'title': 'Tee Yod', 'poster': 'img/tee_yod.jpeg', 'rating': 7.5},
    {
      'title': 'Tử Chiến Trên Không',
      'poster': 'img/tu_chien_tren_khong.jpg',
      'rating': 7.9
    },
  ];

  late final PageController _page;
  Timer? _auto;

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

  void _openDetail(Map<String, Object> movie) {
    final title = (movie['title'] as String).trim().toLowerCase();
    Widget? page;

    if (title == 'mai') {
      page = const MaiDetailPage();
    } else if (title == 'tay anh giữ một vì sao' ||
        title == 'tay anh giu mot vi sao') {
      page = const TayAnhGiuMotViSaoDetailPage();
    } else if (title == 'tee yod') {
      page = const TeeYodDetailPage();
    } else if (title == 'tử chiến trên không' ||
        title == 'tu chien tren khong') {
      page = const TuChienTrenKhongDetailPage();
    }

    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page!));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chưa có trang chi tiết cho phim này.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Lãng mạn',
      'Hài',
      'Kinh dị',
      'Tâm lý',
      'Hành động',
      'Giả tưởng',
    ];

    return Scaffold(
      appBar: const AppHeader(right: _AccountButton()),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // --- Search ---
            TextField(
              decoration: InputDecoration(
                hintText: 'Tìm phim, rạp, thể loại…',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.tune),
                ),
              ),
            ),
            const SizedBox(height: 18),

            // --- Categories ---
            const Text('Thể loại',
                style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (_, i) => _ChipCategory(label: categories[i]),
              ),
            ),
            const SizedBox(height: 22),

            // --- Now Playing ---
            _SectionHeader(
              title: 'Đang chiếu',
              action: TextButton(
                onPressed: () {},
                child: const Text('Xem tất cả'),
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
                  final movie = movies[index % movies.length];
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
                  final cur =
                      ((_page.page ?? _page.initialPage.toDouble()).round()) %
                          movies.length;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(movies.length, (i) {
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
              title: 'Sắp chiếu',
              action: TextButton(
                onPressed: () {},
                child: const Text('Xem tất cả'),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 160,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: movies.length,
                separatorBuilder: (_, __) => const SizedBox(width: 14),
                itemBuilder: (_, i) => _SmallMovieTile(
                  movie: movies[(i + 1) % movies.length],
                  onTap: () => _openDetail(movies[(i + 1) % movies.length]),
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
//   ACCOUNT BUTTON
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
            const SnackBar(content: Text('Đi đến Hồ sơ')),
          );
        } else if (v == 'tickets') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đi đến Vé của tôi')),
          );
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'profile', child: Text('Hồ sơ')),
        PopupMenuItem(value: 'tickets', child: Text('Vé của tôi')),
        PopupMenuItem(value: 'logout', child: Text('Đăng xuất')),
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
class _ChipCategory extends StatelessWidget {
  final String label;
  const _ChipCategory({required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      label: Text(label),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: const BorderSide(color: Colors.transparent),
    );
  }
}

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
  final Map<String, Object> movie;
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
            // Ảnh poster có thể bấm
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.all(radius),
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: AssetImage(movie['poster'] as String),
                    fit: BoxFit.cover,
                    child: InkWell(onTap: onTap),
                    // fallback nếu lỗi asset
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
  final Map<String, Object> movie;
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
                    children: const [
                      Icon(Icons.access_time, size: 16),
                      SizedBox(width: 6),
                      Text('120 phút'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FilledButton.tonal(
                    onPressed: onTap,
                    child: const Text('Nhắc tôi'),
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
