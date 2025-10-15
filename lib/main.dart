import 'package:flutter/material.dart';

import 'core/colors.dart';
import 'pages/login_page.dart';
import 'widgets/app_shell.dart';

void main() => runApp(const CinemaApp());

class CinemaApp extends StatelessWidget {
  const CinemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    final overlay = MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.hovered) ||
          states.contains(MaterialState.pressed) ||
          states.contains(MaterialState.focused)) {
        return kOrange.withOpacity(.12);
      }
      return null;
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phenikaa Cinemas',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: kOrange,
          secondary: kOrange,
          background: Colors.white,
          surface: const Color(0xFFF6F7F9),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: .6,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.black,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(overlayColor: overlay),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(overlayColor: overlay),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(overlayColor: overlay),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(overlayColor: overlay),
        ),
        chipTheme: const ChipThemeData(
          backgroundColor: Color(0xFFF1F3F6),
          labelStyle: TextStyle(color: Colors.black87),
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginPage(),
        '/shell': (_) => const AppShell(), // ← Shell có NavigationBar
      },
    );
  }
}
