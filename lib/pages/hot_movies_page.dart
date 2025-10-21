import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// import các trang chi tiết bạn có
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/mai_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tee_yod_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tu_chien_tren_khong_detail_page.dart';
import 'package:flutter_cinema_booking_ui/pages/movies_detail_page/tay_anh_giu_mot_vi_sao_detail_page.dart';

class HotMoviesPage extends StatelessWidget {
  const HotMoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppHeader(
        // AppHeader không có title, chỉ có right nếu bạn muốn đặt nút
        right: _SearchButton(),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: _movies.length + 1, // +1 để chèn tiêu đề "Phim hot"
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, i) {
          if (i == 0) {
            return const Padding(
              padding: EdgeInsets.only(bottom: 4, top: 4),
              child: Text(
                'Phim hot',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
            );
          }
          final m = _movies[i - 1];
          return _MovieCard(
            movie: m,
            onTap: () => _openDetail(context, m.id),
          );
        },
      ),
    );
  }

  void _openDetail(BuildContext context, String id) {
    Widget page;
    switch (id) {
      case 'mai':
        page = const MaiDetailPage();
        break;
      case 'tee_yod':
        page = const TeeYodDetailPage();
        break;
      case 'air_war':
        page = const TuChienTrenKhongDetailPage();
        break;
      case 'star_hand':
        page = const TayAnhGiuMotViSaoDetailPage();
        break;
      default:
        page = const MaiDetailPage();
    }
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => page));
  }
}

class _SearchButton extends StatelessWidget {
  const _SearchButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.search_rounded),
    );
  }
}

/// --- Dữ liệu & card demo ---

class _Movie {
  final String id, title, poster, tagLine, duration;
  final double rating;
  const _Movie({
    required this.id,
    required this.title,
    required this.poster,
    required this.tagLine,
    required this.rating,
    required this.duration,
  });
}

const _movies = <_Movie>[
  _Movie(
      id: 'mai',
      title: 'MAI',
      poster: 'img/mai.webp',
      tagLine: 'Tâm lý, tình cảm',
      rating: 8.7,
      duration: '120 phút'),
  _Movie(
      id: 'tee_yod',
      title: 'Tee Yod',
      poster: 'img/tee_yod.webp',
      tagLine: 'Kinh dị',
      rating: 7.9,
      duration: '110 phút'),
  _Movie(
      id: 'air_war',
      title: 'Tử Chiến Trên Không',
      poster: 'img/air_war.webp',
      tagLine: 'Hành động',
      rating: 7.2,
      duration: '118 phút'),
  _Movie(
      id: 'star_hand',
      title: 'Tay Anh Giữ Một Vì Sao',
      poster: 'img/tay_anh.webp',
      tagLine: 'Tình cảm',
      rating: 7.8,
      duration: '115 phút'),
];

class _MovieCard extends StatelessWidget {
  final _Movie movie;
  final VoidCallback onTap;
  const _MovieCard({required this.movie, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
              child: Image.asset(
                movie.poster,
                width: 100,
                height: 140,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 140,
                  color: const Color(0xFFF1F3F6),
                  alignment: Alignment.center,
                  child: const Icon(Icons.broken_image_outlined),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 12, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star_rounded,
                            color: kOrange, size: 20),
                        const SizedBox(width: 4),
                        Text('${movie.rating}',
                            style:
                                const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 10),
                        const Icon(Icons.access_time, size: 16),
                        const SizedBox(width: 4),
                        Text(movie.duration),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(movie.tagLine,
                        style: const TextStyle(color: Colors.black54)),
                    const Spacer(),
                    Row(
                      children: [
                        FilledButton(
                          style: FilledButton.styleFrom(
                            backgroundColor: kOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: onTap,
                          child: const Text('Xem chi tiết',
                              style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton.icon(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: kOrange),
                            foregroundColor: kOrange,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                          ),
                          onPressed: onTap,
                          icon: const Icon(Icons.airplane_ticket_outlined,
                              size: 18),
                          label: const Text('Đặt vé'),
                        ),
                      ],
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
