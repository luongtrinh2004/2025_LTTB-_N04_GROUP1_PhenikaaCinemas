import 'package:flutter/material.dart';

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
  State<AllMoviesPage> createState() =>
      _AllMoviesPageState();
}

class _AllMoviesPageState extends State<AllMoviesPage> {
  static const categories = [
    'Lãng mạn',
    'Hài',
    'Kinh dị',
    'Tâm lý',
    'Hành động',
    'Giả tưởng',
    'Hoạt hình'
  ];
  String? _category;

  @override
  void initState() {
    super.initState();
    _category = widget.initialCategory;
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _category == null
        ? widget.allMovies
        : widget.allMovies.where((m) {
            final gs = (m['genres'] as List).cast<String>();
            return gs.contains(_category);
          }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tất cả phim')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          SizedBox(
            height: 44,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: 10),
              itemBuilder: (_, i) {
                final label = categories[i];
                final selected = _category == label;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) {
                    setState(() {
                      _category = selected
                          ? null
                          : label; // bấm lại để bỏ lọc
                    });
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 12),
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
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(
                                        14),
                                child: Image.asset(
                                  m['poster'] as String,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) =>
                                          const ColoredBox(
                                    color:
                                        Color(0xFFF1F3F6),
                                    child: Center(
                                        child: Icon(Icons
                                            .broken_image_outlined)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              m['title'] as String,
                              maxLines: 2,
                              overflow:
                                  TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight:
                                      FontWeight.w700),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                    Icons.star_rounded,
                                    size: 16),
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
    );
  }
}
