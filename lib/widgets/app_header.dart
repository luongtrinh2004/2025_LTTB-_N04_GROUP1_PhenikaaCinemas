import 'package:flutter/material.dart';

/// AppHeader: logo/tiêu đề ở giữa thật sự.
/// - Nếu có nút back (canPop) mà KHÔNG truyền `right`, ta thêm 1 SizedBox
///   có bề rộng ~ kToolbarHeight vào `actions` để cân đối với `leading`.
/// - Nếu `right` != null thì hiển thị `right` bình thường.
/// - Nếu `title` != null thì hiển thị text; ngược lại hiển thị logo.
/// - Nếu `right` == null thì KHÔNG render gì bên phải (trừ khi cần spacer để cân đối).
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    Key? key,
    this.right,
    this.backgroundColor = Colors.white,
    this.elevation = 4,
    this.logoHeight = 44, // kích thước logo
    this.title,
  }) : super(key: key);

  /// Widget hiển thị bên phải (VD: account button). Nếu null -> không render.
  final Widget? right;
  final Color backgroundColor;
  final double elevation;
  final double logoHeight;

  /// Optional title: nếu có sẽ hiển thị text, nếu null thì hiển thị logo.
  final String? title;

  static const _brandBlue = Color(0xFF0C2D5A);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,

      // Không tự thêm leading mặc định
      automaticallyImplyLeading: false,

      // Nút back nếu có thể pop
      leading: canPop
          ? IconButton(
              tooltip: 'Quay lại',
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: _brandBlue,
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,

      // Đặt tiêu đề giữa vùng AppBar (tính đến leading & actions)
      centerTitle: true,

      // KHÔNG padding trái cho title để không bị lệch
      // titleSpacing: 0, // có thể bỏ hẳn để AppBar tự tính spacing hợp lý

      // Hiển thị title text hoặc logo
      title: (title != null)
          ? Text(
              title!,
              style: const TextStyle(
                color: _brandBlue,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            )
          : Image.asset(
              'img/logo.png',
              height: logoHeight,
              fit: BoxFit.contain,
            ),

      // ❗ Chỉ render nếu có truyền `right`.
      // Trường hợp có leading (back) nhưng KHÔNG có `right`,
      // ta thêm 1 spacer để cân đối với leading, giúp title thực sự giữa.
      actions: (right != null)
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: right!,
              ),
            ]
          : (canPop ? const [SizedBox(width: kToolbarHeight)] : null),
    );
  }
}
