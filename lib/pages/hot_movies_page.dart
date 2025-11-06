// lib/pages/hot_movies_page.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_cinema_booking_ui/core/colors.dart';
import 'package:flutter_cinema_booking_ui/widgets/app_header.dart';

// ==== IMPORT detail pages ====
import 'movies_detail_page/mai_detail_page.dart';
import 'movies_detail_page/tay_anh_giu_mot_vi_sao_detail_page.dart';
import 'movies_detail_page/tee_yod_detail_page.dart';
import 'movies_detail_page/tu_chien_tren_khong_detail_page.dart';
import 'movies_detail_page/avatar3_detail_page.dart';
import 'movies_detail_page/shin_detail_page.dart';
import 'movies_detail_page/nam_cua_anh_ngay_cua_em_detail_page.dart';
import 'movies_detail_page/gio_van_thoi_detail_page.dart';
import 'movies_detail_page/cai_ma_detail_page.dart';
import 'movies_detail_page/cuc_vang_cua_ngoai_detail_page.dart';
import 'movies_detail_page/goodboy_detail_page.dart';
import 'movies_detail_page/roboco_detail_page.dart';
import 'movies_detail_page/van_may_detail_page.dart';

enum _HotSort { hot, views, likes, rating }

class HotMoviesPage extends StatefulWidget {
  const HotMoviesPage({super.key});
  @override
  State<HotMoviesPage> createState() => _HotMoviesPageState();
}

class _HotMoviesPageState extends State<HotMoviesPage> {
  final _topMovies = <Map<String, dynamic>>[
    {'title':'MAI','poster':'img/mai.webp','rating':8.7,'views':1200000,'likes':340000,'release':DateTime(2024,2,10)},
    {'title':'Tay Anh Giữ Một Vì Sao','poster':'img/tay_anh_giu_mot_vi_sao.jpg','rating':8.3,'views':720000,'likes':180000,'release':DateTime(2025,3,1)},
    {'title':'Tee Yod','poster':'img/tee_yod.jpeg','rating':7.5,'views':510000,'likes':110000,'release':DateTime(2025,10,1)},
    {'title':'Tử Chiến Trên Không','poster':'img/tu_chien_tren_khong.jpg','rating':7.9,'views':430000,'likes':95000,'release':DateTime(2025,8,15)},
    {'title':'Avatar 3','poster':'img/avatar3.jpg','rating':7.1,'views':980000,'likes':210000,'release':DateTime(2025,12,20)},
    {'title':'Shin Cậu Bé Bút Chì: Nóng Bỏng Tay! Những Vũ Công Siêu Cay Kasukabe','poster':'img/shin.jpg','rating':9.0,'views':650000,'likes':230000,'release':DateTime(2025,8,10)},
    {'title':'Năm Của Anh, Ngày Của Em','poster':'img/namcuaanh_ngaycuaem.jpg','rating':7.0,'views':300000,'likes':60000,'release':DateTime(2024,11,1)},
    {'title':'Gió Vẫn Thổi','poster':'img/giovanthoi.jpg','rating':8.6,'views':560000,'likes':160000,'release':DateTime(2024,6,1)},
    {'title':'Cải Mả','poster':'img/caima.jpg','rating':7.5,'views':410000,'likes':100000,'release':DateTime(2025,7,1)},
    {'title':'Cục Vàng Của Ngoại','poster':'img/cucvangcuangoai.jpg','rating':8.7,'views':470000,'likes':150000,'release':DateTime(2024,9,20)},
  ];

  _HotSort _sortBy = _HotSort.hot;

  double _recencyScore(DateTime d) {
    final days = DateTime.now().difference(d).inDays.clamp(0, 365);
    return 1.0 - (days / 365.0);
  }

  double _hotScore(Map<String, dynamic> m) {
    final maxViews = _topMovies.map((e)=>e['views'] as int).reduce(math.max).toDouble();
    final maxLikes = _topMovies.map((e)=>e['likes'] as int).reduce(math.max).toDouble();
    final viewsN  = (math.log((m['views'] as int)+1)/math.log(maxViews+1)).clamp(0.0,1.0);
    final likesN  = ((m['likes'] as int)/(maxLikes==0?1:maxLikes)).clamp(0.0,1.0);
    final ratingN = ((m['rating'] as num)/10).clamp(0.0,1.0);
    final recencyN= _recencyScore(m['release'] as DateTime);
    return 0.4*viewsN + 0.3*likesN + 0.2*ratingN + 0.1*recencyN;
  }

  List<Map<String, dynamic>> _sorted() {
    final list = [..._topMovies];
    list.sort((a,b){
      switch(_sortBy){
        case _HotSort.views:  return (b['views'] as int).compareTo(a['views'] as int);
        case _HotSort.likes:  return (b['likes'] as int).compareTo(a['likes'] as int);
        case _HotSort.rating: return (b['rating'] as num).compareTo(a['rating'] as num);
        case _HotSort.hot: default: return _hotScore(b).compareTo(_hotScore(a));
      }
    });
    return list;
  }

  void _openDetail(Map<String, dynamic> movie){
    final t = (movie['title'] as String).trim().toLowerCase();
    Widget? page;
    if (t=='mai') page=const MaiDetailPage();
    else if (t=='tay anh giữ một vì sao'||t=='tay anh giu mot vi sao') page=const TayAnhGiuMotViSaoDetailPage();
    else if (t=='tee yod') page=const TeeYodDetailPage();
    else if (t=='tử chiến trên không'||t=='tu chien tren khong') page=const TuChienTrenKhongDetailPage();
    else if (t=='avatar 3'||t=='avatar3') page=const Avatar3DetailPage();
    else if (t=='shin cậu bé bút chì: nóng bỏng tay! những vũ công siêu cay kasukabe'
          || t=='shin cau be but chi: nong bong tay! nhung vu cong sieu cay kasukabe') page=const ShinDetailPage();
    else if (t=='năm của anh, ngày của em'||t=='nam cua anh, ngay cua em') page=const NamCuaAnhNgayCuaEmDetailPage();
    else if (t=='gió vẫn thổi'||t=='gio van thoi') page=const GioVanThoiDetailPage();
    else if (t=='cải mả'||t=='cai ma') page=const CaiMaDetailPage();
    else if (t=='cục vàng của ngoại'||t=='cuc vang cua ngoai') page=const CucVangCuaNgoaiDetailPage();
    else if (t=='good boy - chó cưng đừng sợ'||t=='good boy - cho cung dung so') page=const GoodBoyDetailPage();
    else if (t=='tớ và roboco: siêu cấp đa vũ trụ'||t=='to va roboco: sieu cap da vu tru') page=const RobocoDetailPage();
    else if (t=='vận may'||t=='van may') page=const VanMayDetailPage();

    if(page!=null){ Navigator.push(context, MaterialPageRoute(builder:(_)=>page!)); }
    else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chưa có trang chi tiết cho phim này.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = _sorted();

    return Scaffold(
      appBar: const AppHeader(),      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20,16,20,8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Top Hot 🔥', style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
            // Sort 1 hàng
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _SortRow(
                  value: _sortBy,
                  onChanged: (v)=>setState(()=>_sortBy=v),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 12)),
            // Grid
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  // width/height. Tăng height bằng cách giảm ratio để có chỗ cho info
                  childAspectRatio: 0.56,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index){
                    final m = items[index];
                    return _MovieCard(
                      movie: m,
                      rank: index+1,
                      hotScore: _hotScore(m),
                      onTap: ()=>_openDetail(m),
                    );
                  },
                  childCount: items.length,
                ),
              ),
            ),
            // chừa đáy cho NavigationBar
            const SliverToBoxAdapter(child: SizedBox(height: kBottomNavigationBarHeight+8)),
          ],
        ),
      ),
    );
  }
}

/// Account button
class _AccountButton extends StatelessWidget {
  const _AccountButton();
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (v) {
        if (v == 'logout') {
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false);
        } else if (v == 'profile') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đi đến Hồ sơ')));
        } else if (v == 'tickets') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đi đến Vé của tôi')));
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

/// Sort row (1 hàng, cuộn ngang nếu hẹp)
class _SortRow extends StatelessWidget {
  final _HotSort value;
  final ValueChanged<_HotSort> onChanged;
  const _SortRow({required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _SortChip(label:'Hot',       selected:value==_HotSort.hot,    onTap:()=>onChanged(_HotSort.hot),    icon:Icons.local_fire_department_outlined),
          const SizedBox(width: 8),
          _SortChip(label:'Lượt xem',  selected:value==_HotSort.views,  onTap:()=>onChanged(_HotSort.views),  icon:Icons.visibility_outlined),
          const SizedBox(width: 8),
          _SortChip(label:'Yêu thích', selected:value==_HotSort.likes,  onTap:()=>onChanged(_HotSort.likes),  icon:Icons.favorite_border),
          const SizedBox(width: 8),
          _SortChip(label:'Đánh giá',  selected:value==_HotSort.rating, onTap:()=>onChanged(_HotSort.rating), icon:Icons.star_border),
        ],
      ),
    );
  }
}

class _SortChip extends StatelessWidget {
  final String label; final bool selected; final VoidCallback onTap; final IconData icon;
  const _SortChip({required this.label, required this.selected, required this.onTap, required this.icon});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary.withOpacity(.12) : theme.colorScheme.surfaceVariant.withOpacity(.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? theme.colorScheme.primary : theme.dividerColor.withOpacity(.4)),
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, size: 16),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurface)),
        ]),
      ),
    );
  }
}

/// Movie Card — KHÔNG tràn
class _MovieCard extends StatelessWidget {
  final Map<String, dynamic> movie;
  final int rank;
  final double hotScore;
  final VoidCallback? onTap;

  const _MovieCard({required this.movie, required this.rank, required this.hotScore, this.onTap});

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
            // Poster
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(
                        movie['poster'] as String,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFF1F3F6),
                          child: const Center(child: Icon(Icons.movie_filter_outlined, size: 40)),
                        ),
                      ),
                    ),
                  ),
                  Positioned(top: 8, left: 8, child: _RankBadge(rank: rank)),
                  Positioned(bottom: 8, right: 8, child: _RatingBadge(rating: (movie['rating'] as num).toDouble())),
                ],
              ),
            ),

            // Info (CỐ ĐỊNH CHIỀU CAO -> không tràn)
            SizedBox(
              height: 94, // chỉnh nhỏ/lớn tùy ý; cố định để không overflow
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie['title'] as String,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.visibility_outlined, size: 14),
                        const SizedBox(width: 4),
                        Text(_fmt(movie['views'] as int), style: const TextStyle(fontSize: 12)),
                        const SizedBox(width: 10),
                        const Icon(Icons.favorite_border, size: 14),
                        const SizedBox(width: 4),
                        Text(_fmt(movie['likes'] as int), style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                    const Spacer(),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: LinearProgressIndicator(
                        value: hotScore.clamp(0.0, 1.0),
                        minHeight: 6,
                        backgroundColor: theme.colorScheme.surfaceVariant.withOpacity(.6),
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

class _RankBadge extends StatelessWidget {
  final int rank;
  const _RankBadge({required this.rank});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: theme.colorScheme.primary, borderRadius: BorderRadius.circular(10)),
      child: Text('#$rank', style: TextStyle(color: theme.colorScheme.onPrimary, fontWeight: FontWeight.bold, fontSize: 12)),
    );
  }
}

class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.white.withOpacity(.92), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.black12)),
      child: Row(children: [
        const Icon(Icons.star_rounded, size: 14, color: kOrange),
        const SizedBox(width: 4),
        Text(rating.toStringAsFixed(1), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
      ]),
    );
  }
}

/// Utils
String _fmt(int n){
  if (n >= 1000000000) return '${(n/1e9).toStringAsFixed(1)}B';
  if (n >= 1000000)   return '${(n/1e6).toStringAsFixed(1)}M';
  if (n >= 1000)      return '${(n/1e3).toStringAsFixed(1)}K';
  return '$n';
}
