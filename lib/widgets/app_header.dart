import 'package:flutter/material.dart';

/// AppHeader: logo lệch trái nhẹ, account icon to hơn & căn đều.
class AppHeader extends StatelessWidget
    implements PreferredSizeWidget {
  const AppHeader({
    Key? key,
    this.right,
    this.backgroundColor = Colors.white,
    this.elevation = 4,
    this.logoHeight = 44, // tăng kích thước logo
  }) : super(key: key);

  /// Widget hiển thị bên phải (VD: account button)
  final Widget? right;
  final Color backgroundColor;
  final double elevation;
  final double logoHeight;

  static const _brandBlue = Color(0xFF0C2D5A);

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return AppBar(
      backgroundColor: backgroundColor,
      elevation: elevation,
      automaticallyImplyLeading:
          false, // tự kiểm soát nút back
      leading: canPop
          ? IconButton(
              tooltip: 'Quay lại',
              icon: const Icon(
                  Icons.arrow_back_ios_new_rounded),
              color: _brandBlue,
              onPressed: () =>
                  Navigator.of(context).maybePop(),
            )
          : null,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Image.asset(
          'img/logo.png',
          height: logoHeight, // kích thước logo bạn muốn
          fit: BoxFit.contain,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: right ??
              const CircleAvatar(
                radius: 20, // chỉnh 20–26 tùy ý
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.account_circle_outlined,
                  color: _brandBlue,
                  size: 28,
                ),
              ),
        ),
      ],
    );
  }
}
