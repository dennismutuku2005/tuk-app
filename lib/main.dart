import 'package:flutter/material.dart';
import 'screens/landing_screen.dart';
import 'utils/app_colors.dart';
import 'widgets/bug_report_overlay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tukapp',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
      ),
      builder: (context, child) {
        return BugReportOverlay(child: child!);
      },
      home: const LandingScreen(),
    );
  }
}