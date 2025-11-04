import 'package:flutter/material.dart';

/// AppHeader: logo lệch trái nhẹ. Nếu `right` null thì KHÔNG hiện gì bên phải.
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
      automaticallyImplyLeading: false,
      leading: canPop
          ? IconButton(
              tooltip: 'Quay lại',
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              color: _brandBlue,
              onPressed: () => Navigator.of(context).maybePop(),
            )
          : null,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: title != null
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
      ),

      // ❗ Chỉ render nếu có truyền `right`
      actions: right != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: right!,
              ),
            ]
          : null,
    );
  }
}
