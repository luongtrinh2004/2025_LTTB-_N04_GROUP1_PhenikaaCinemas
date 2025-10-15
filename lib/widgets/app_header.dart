import 'package:flutter/material.dart';

/// AppHeader: logo lệch trái nhẹ, account icon to hơn & căn đều.
class AppHeader extends StatelessWidget implements PreferredSizeWidget {
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
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.of(context).canPop();

    return Material(
      color: backgroundColor,
      elevation: elevation,
      shadowColor: Colors.black12,
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Stack(
            fit: StackFit.expand,
            children: [
              /// LOGO — đặt sát trái (flush left)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Image.asset(
                    'img/logo.png', // logo
                    height: logoHeight + 6, // hơi lớn hơn
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              /// Nút back (nếu có trang trước)
              if (canPop)
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    tooltip: 'Quay lại',
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: _brandBlue,
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),

              /// Bên phải: account icon to hơn
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: right ??
                      const CircleAvatar(
                        radius: 26, // lớn hơn trước
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: _brandBlue,
                          size: 34,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
