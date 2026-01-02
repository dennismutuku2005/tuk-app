import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'channua_tab.dart';
import 'home_tab.dart';
import 'news_tab.dart';
import 'fees_tab.dart';
import 'settings_tab.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTab(),
    const FeesTab(),
    const ChannuaTab(),
    const NewsTab(),
    const SettingsTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundDark,
          border: Border(top: BorderSide(color: AppColors.borderGray, width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.backgroundDark,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryGold,
          unselectedItemColor: AppColors.textGray,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Portal',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              label: 'Fees',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.forum),
              label: 'Channua',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.newspaper),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
