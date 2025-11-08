// lib/pages/english/hot_movies_page_en.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// ==== IMPORT detail pages (reuse the same ones) ====
import 'package:flutter_cinema_booking_ui/pages/english/mai_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tay_anh_giu_mot_vi_sao_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/tee_yod_detail_page_en.dart';

import 'package:flutter_cinema_booking_ui/pages/english/tu_chien_tren_khong_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/avatar3_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/shin_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/nam_cua_anh_ngay_cua_em_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/gio_van_thoi_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/cai_ma_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/cuc_vang_cua_ngoai_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/goodboy_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/roboco_detail_page_en.dart';
import 'package:flutter_cinema_booking_ui/pages/english/van_may_detail_page_en.dart';

enum _HotSortEn { hot, views, likes, rating }

class HotMoviesPageEn extends StatefulWidget {
  const HotMoviesPageEn({super.key});
  @override
  State<HotMoviesPageEn> createState() => _HotMoviesPageEnState();
}

class _HotMoviesPageEnState extends State<HotMoviesPageEn> {
  final _topMovies = <Map<String, dynamic>>[
    {
      'title': 'MAI',
      'poster': 'img/mai.webp',
      'rating': 8.7,
      'views': 1200000,
      'likes': 340000,
      'release': DateTime(2024, 2, 10),
      'detail': const MaiDetailPageEn(),
    },
    {
      'title': 'Tay Anh Giữ Một Vì Sao',
      'poster': 'img/tay_anh_giu_mot_vi_sao.jpg',
      'rating': 8.3,
      'views': 720000,
      'likes': 180000,
      'release': DateTime(2025, 3, 1),
      'detail': const TayAnhGiuMotViSaoDetailPageEn(),
    },
    {
      'title': 'Tee Yod',
      'poster': 'img/tee_yod.jpeg',
      'rating': 7.5,
      'views': 510000,
      'likes': 110000,
      'release': DateTime(2025, 10, 1),
      'detail': const TeeYodDetailPageEn(),
    },
    {
      'title': 'Tử Chiến Trên Không',
      'poster': 'img/tu_chien_tren_khong.jpg',
      'rating': 7.9,
      'views': 430000,
      'likes': 95000,
      'release': DateTime(2025, 8, 15),
      'detail': const TuChienTrenKhongDetailPageEn(),
    },
    {
      'title': 'Avatar 3',
      'poster': 'img/avatar3.jpg',
      'rating': 7.1,
      'views': 980000,
      'likes': 210000,
      'release': DateTime(2025, 12, 20),
      'detail': const Avatar3DetailPageEn(),
    },
    {
      'title':
          'Shin Cậu Bé Bút Chì: Nóng Bỏng Tay! Những Vũ Công Siêu Cay Kasukabe',
      'poster': 'img/shin.jpg',
      'rating': 9.0,
      'views': 650000,
      'likes': 230000,
      'release': DateTime(2025, 8, 10),
      'detail': const ShinDetailPageEn(),
    },
    {
      'title': 'Năm Của Anh, Ngày Của Em',
      'poster': 'img/namcuaanh_ngaycuaem.jpg',
      'rating': 7.0,
      'views': 300000,
      'likes': 60000,
      'release': DateTime(2024, 11, 1),
      'detail': const NamCuaAnhNgayCuaEmDetailPageEn(),
    },
    {
      'title': 'Gió Vẫn Thổi',
      'poster': 'img/giovanthoi.jpg',
      'rating': 8.6,
      'views': 560000,
      'likes': 160000,
      'release': DateTime(2024, 6, 1),
      'detail': const GioVanThoiDetailPageEn(),
    },
    {
      'title': 'Cải Mả',
      'poster': 'img/caima.jpg',
      'rating': 7.5,
      'views': 410000,
      'likes': 100000,
      'release': DateTime(2025, 7, 1),
      'detail': const CaiMaDetailPageEn(),
    },
    {
      'title': 'Cục Vàng Của Ngoại',
      'poster': 'img/cucvangcuangoai.jpg',
      'rating': 8.7,
      'views': 470000,
      'likes': 150000,
      'release': DateTime(2024, 9, 20),
      'detail': const CucVangCuaNgoaiDetailPageEn(),
    },
  ];

  _HotSortEn _sortBy = _HotSortEn.hot;

  double _recencyScoreEn(DateTime d) {
    final days = DateTime.now().difference(d).inDays.clamp(0, 365);
    return 1.0 - (days / 365.0);
  }

  double _hotScoreEn(Map<String, dynamic> m) {
    final maxViews =
        _topMovies.map((e) => e['views'] as int).reduce(math.max).toDouble();
    final maxLikes =
        _topMovies.map((e) => e['likes'] as int).reduce(math.max).toDouble();
    final viewsN = (math.log((m['views'] as int) + 1) / math.log(maxViews + 1))
        .clamp(0.0, 1.0);
    final likesN =
        ((m['likes'] as int) / (maxLikes == 0 ? 1 : maxLikes)).clamp(0.0, 1.0);
    final ratingN = ((m['rating'] as num) / 10).clamp(0.0, 1.0);
    final recencyN = _recencyScoreEn(m['release'] as DateTime);
    return 0.4 * viewsN + 0.3 * likesN + 0.2 * ratingN + 0.1 * recencyN;
  }

  List<Map<String, dynamic>> _sortedEn() {
    final list = [..._topMovies];
    list.sort((a, b) {
      switch (_sortBy) {
        case _HotSortEn.views:
          return (b['views'] as int).compareTo(a['views'] as int);
        case _HotSortEn.likes:
          return (b['likes'] as int).compareTo(a['likes'] as int);
        case _HotSortEn.rating:
          return (b['rating'] as num).compareTo(a['rating'] as num);
        case _HotSortEn.hot:
        default:
          return _hotScoreEn(b).compareTo(_hotScoreEn(a));
      }
    });
    return list;
  }

  void _openDetailEn(Map<String, dynamic> movie) {
    final page = movie['detail'] as Widget?;
    if (page != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('No detail page available for this movie yet.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _sortedEn();

    return Scaffold(
      // 👇 chỉ hiển thị logo
      appBar: const AppHeader(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    // Text('Top Trending 🔥',
                    //     style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SortRowEn(
                  value: _sortBy,
                  onChanged: (v) => setState(() => _sortBy = v),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: 0.56,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final m = items[index];
                    return _MovieCardEn(
                      movie: m,
                      rank: index + 1,
                      hotScore: _hotScoreEn(m),
                      onTap: () => _openDetailEn(m),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(
                child: SizedBox(height: kBottomNavigationBarHeight + 8)),
          ],
        ),
      ),
    );
  }
}

/// Account button (English)
class _AccountButtonEn extends StatelessWidget {
  const _AccountButtonEn();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'logout') {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        } else if (v == 'profile') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Go to Profile')));
        } else if (v == 'tickets') {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Go to My tickets')));
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

class _SortRowEn extends StatelessWidget {
  final _HotSortEn value;
  final ValueChanged<_HotSortEn> onChanged;
  const _SortRowEn({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: const [
          _SortChipEn(
              label: 'Hot',
              icon: Icons.local_fire_department_outlined,
              type: _HotSortEn.hot),
          SizedBox(width: 8),
          _SortChipEn(
              label: 'Views',
              icon: Icons.visibility_outlined,
              type: _HotSortEn.views),
          SizedBox(width: 8),
          _SortChipEn(
              label: 'Likes',
              icon: Icons.favorite_border,
              type: _HotSortEn.likes),
          SizedBox(width: 8),
          _SortChipEn(
              label: 'Rating',
              icon: Icons.star_border,
              type: _HotSortEn.rating),
        ],
      ),
    );
  }
}

class _SortChipEn extends StatelessWidget {
  final String label;
  final IconData icon;
  final _HotSortEn type;
  const _SortChipEn(
      {required this.label, required this.icon, required this.type});
  @override
  Widget build(BuildContext context) {
    final parent = context.findAncestorStateOfType<_HotMoviesPageEnState>()!;
    final selected = parent._sortBy == type;
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => parent.setState(() => parent._sortBy = type),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected
              ? theme.colorScheme.primary.withOpacity(.12)
              : theme.colorScheme.surfaceVariant.withOpacity(.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected
                  ? theme.colorScheme.primary
                  : theme.dividerColor.withOpacity(.4)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface)),
        ]),
      ),
    );
  }
}

/// Movie Card — fixed info height
class _MovieCardEn extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int rank;
  final double hotScore;
  final VoidCallback? onTap;

  const _MovieCardEn(
      {required this.movie,
      required this.rank,
      required this.hotScore,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      elevation: 1,
      color: theme.colorScheme.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        movie['poster'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFF1F3F6),
                          child: const Center(
                              child:
                                  Icon(Icons.movie_filter_outlined, size: 40)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 8, left: 8, child: _RankBadgeEn(rank: rank)),
                  Positioned(
                      bottom: 8,
                      right: 8,
                      child: _RatingBadgeEn(
                          rating: (movie['rating'] as num).toDouble())),
                ],
              ),
            ),
            SizedBox(
              height: 94,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.visibility_outlined, size: 14),
                        const SizedBox(width: 4),
                        Text(_fmtEn(movie['views'] as int),
                            style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 10),
                        const Icon(Icons.favorite_border, size: 14),
                        const SizedBox(width: 4),
                        Text(_fmtEn(movie['likes'] as int),
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: hotScore.clamp(0.0, 1.0),
                        minHeight: 6,
                        backgroundColor:
                            theme.colorScheme.surfaceVariant.withOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RankBadgeEn extends StatelessWidget {
  final int rank;
  const _RankBadgeEn({required this.rank});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10)),
      child: Text('#$rank',
          style: TextStyle(
              color: theme.colorScheme.onPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 12)),
    );
  }
}

class _RatingBadgeEn extends StatelessWidget {
  final double rating;
  const _RatingBadgeEn({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.92),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(children: [
        const Icon(Icons.star_rounded, size: 14, color: kOrange),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1),
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      ]),
    );
  }
}

/// Utils
String _fmtEn(int n) {
  if (n >= 1000000000) return '${(n / 1e9).toStringAsFixed(1)}B';
  if (n >= 1000000) return '${(n / 1e6).toStringAsFixed(1)}M';
  if (n >= 1000) return '${(n / 1e3).toStringAsFixed(1)}K';
  return '$n';
}
