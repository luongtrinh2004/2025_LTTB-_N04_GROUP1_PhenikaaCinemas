import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// Điều hướng tab "Home" (EN)
import 'package:flutter_cinema_booking_ui/pages/english/home_page_en.dart';
// Nếu bạn đã có các trang EN cho Hot/Tickets/Profile, import vào đây và thay
// SnackBar ở _onBottomTabTap tương ứng:
// import 'package:flutter_cinema_booking_ui/pages/english/hot_movies_page_en.dart';
// import 'package:flutter_cinema_booking_ui/pages/english/tickets_page_en.dart';
// import 'package:flutter_cinema_booking_ui/pages/english/profile_page_en.dart';

class AllMoviesPageEn extends StatefulWidget {
  final List<Map<String, dynamic>> allMovies;
  final String? initialCategory;
  final void Function(Map<String, dynamic>) onOpenDetail;

  const AllMoviesPageEn({
    super.key,
    required this.allMovies,
    required this.onOpenDetail,
    this.initialCategory,
  });

  @override
  State<AllMoviesPageEn> createState() => _AllMoviesPageEnState();
}

class _AllMoviesPageEnState extends State<AllMoviesPageEn> {
  String? _category;

  // Tab index: 0 = Home, 1 = Hot, 2 = Tickets, 3 = Info
  int _currentTabIndex = 1; // hợp ngữ cảnh phim (giống “Hot/Movies”)

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  // ===== Categories (EN) sinh động từ dữ liệu =====
  List<String> _categoriesFromMovies() {
    final set = <String>{};
    for (final m in widget.allMovies) {
      final gs = (m['genres'] as List).cast<String>();
      for (final g in gs) {
        set.add(g.trim());
      }
    }
    final list = set.toList()..sort();
    return list;
  }

  bool _movieHasGenre(Map<String, dynamic> m, String selected) {
    final wanted = selected.toLowerCase().trim();
    final gs = (m['genres'] as List).cast<String>();
    final normalized = gs.map((e) => e.toLowerCase().trim());
    return normalized.contains(wanted);
  }

  void _onBottomTabTap(int index) {
    if (index == _currentTabIndex) return;
    setState(() => _currentTabIndex = index);

    switch (index) {
      case 0: // Home
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => const HomePageEn()),
          (route) => false,
        );
        break;
      case 1: // Hot
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Hot: Coming soon')),
        );
        // Khi có trang: thay bằng điều hướng
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (_) => const HotMoviesPageEn()),
        //   (route) => false,
        // );
        break;
      case 2: // Tickets
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tickets: Coming soon')),
        );
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (_) => const TicketsPageEn()),
        //   (route) => false,
        // );
        break;
      case 3: // Info/Profile
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Info: Coming soon')),
        );
        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(builder: (_) => const ProfilePageEn()),
        //   (route) => false,
        // );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = _categoriesFromMovies();

    final filtered = _category == null
        ? widget.allMovies
        : widget.allMovies.where((m) => _movieHasGenre(m, _category!)).toList();

    return Scaffold(
      // ===== Header trên cùng =====
      appBar: const AppHeader(),

      // ===== Nội dung =====
      body: Column(
        children: [
          const SizedBox(height: 12),
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
                      _category = selected ? null : label; // tap again to clear
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text('No movies'))
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

      // ===== App shell (bottom nav) dưới cùng =====
      bottomNavigationBar: SafeArea(
        top: false,
        child: BottomNavigationBar(
          currentIndex: _currentTabIndex,
          type: BottomNavigationBarType.fixed,
          onTap: _onBottomTabTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department),
              label: 'Hot',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.confirmation_number),
              label: 'Tickets',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Info',
            ),
          ],
        ),
      ),
    );
  }
}
