import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// Các trang cho bottom nav
import 'package:flutter_cinema_booking_ui/pages/home_page.dart';
import 'package:flutter_cinema_booking_ui/pages/hot_movies_page.dart';
import 'package:flutter_cinema_booking_ui/pages/profile_page.dart';
// Nếu có trang vé riêng, import vào đây:
// import 'package:flutter_cinema_booking_ui/pages/tickets_page.dart';

class AllMoviesPage extends StatefulWidget {
  final List<Map<String, dynamic>> allMovies;
  final String? initialCategory;
  final void Function(Map<String, dynamic>) onOpenDetail;

  const AllMoviesPage({
    super.key,
    required this.allMovies,
    required this.onOpenDetail,
    this.initialCategory,
  });

  @override
  State<AllMoviesPage> createState() => _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMoviesPage> {
  // VN <-> EN map: chip hiển thị VN, data genres là EN
  static const Map<String, String> _vn2en = {
    'Tình cảm': 'Romance',
    'Hài': 'Comedy',
    'Kinh dị': 'Horror',
    'Tâm lý': 'Drama',
    'Hành động': 'Action',
    'Hoạt hình': 'Animation',
  };
  static const Map<String, String> _en2vn = {
    'Romance': 'Tình cảm',
    'Comedy': 'Hài',
    'Horror': 'Kinh dị',
    'Drama': 'Tâm lý',
    'Action': 'Hành động',
    'Animation': 'Hoạt hình',
  };

  String? _category;

  // Chỉ số tab đang chọn cho app shell dưới cùng:
  // 0 = Trang chủ, 1 = Phim hot, 2 = Vé, 3 = Thông tin
  // Với trang “Tất cả phim”, mặc định mình để 1 (nhóm “phim”).
  int _currentTabIndex = 1;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  // Lấy danh sách chip VN từ dữ liệu (genres hiện là EN)
  List<String> _categoriesFromMoviesVN() {
    final set = <String>{};
    for (final m in widget.allMovies) {
      final gs = (m['genres'] as List).cast<String>();
      for (final g in gs) {
        final en = g.trim();
        final vn = _en2vn[en] ?? en; // nếu chưa map thì giữ nguyên EN
        set.add(vn);
      }
    }
    final list = set.toList()..sort();
    return list;
  }

  bool _movieMatchesCategoryVN(Map<String, dynamic> m, String selectedVN) {
    final wantedEN = (_vn2en[selectedVN] ?? selectedVN).toLowerCase().trim();
    final gs = (m['genres'] as List).cast<String>();
    final normalized = gs.map((e) => e.toLowerCase().trim());
    return normalized.contains(wantedEN);
  }

  void _onBottomTabTap(int index) {
    if (index == _currentTabIndex) return;
    setState(() => _currentTabIndex = index);

    switch (index) {
      case 0: // Trang chủ
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
        break;
      case 1: // Phim hot
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HotMoviesPage()),
          (route) => false,
        );
        break;
      case 2: // Vé
        // Nếu có TicketsPage, thay SnackBar bằng điều hướng như trên:
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (_) => const TicketsPage()),
        //   (route) => false,
        // );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tính năng Vé sẽ có sớm!')),
        );
        break;
      case 3: // Thông tin (Profile)
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const ProfilePage()),
          (route) => false,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categoriesFromMoviesVN();

    final filtered = _category == null
        ? widget.allMovies
        : widget.allMovies
            .where((m) => _movieMatchesCategoryVN(m, _category!))
            .toList();

    return Scaffold(
      // ===== Header ở trên giống các trang khác =====
      appBar: const AppHeader(),

      // ===== Nội dung =====
      body: Column(
        children: [
          const SizedBox(height: 12),
          // Chip thể loại
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final label = categories[i];
                final selected = _category == label;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _category = selected ? null : label; // bấm lại để bỏ lọc
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),

          // Lưới phim
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('Không có phim'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 2 / 3,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final m = filtered[i];
                      return GestureDetector(
                        onTap: () => widget.onOpenDetail(m),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(14),
                                child: Image.asset(
                                  m['poster'] as String,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                      const ColoredBox(
                                    color: Color(0xFFF1F3F6),
                                    child: Center(
                                      child: Icon(Icons.broken_image_outlined),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              m['title'] as String,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.star_rounded, size: 16),
                                const SizedBox(width: 4),
                                Text('${m['rating']}'),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ===== App shell (bottom nav) ở dưới =====
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onBottomTabTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Trang chủ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Phim hot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Vé',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Thông tin',
            ),
          ],
        ),
      ),
    );
  }
}
