import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/bug_report_overlay.dart';
import 'login_screen.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.arrow_back, color: AppColors.textMain),
                        onPressed: () {},
                      ),
                    Expanded(
                      child: Text(
                        'Settings',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: AppColors.textMain,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),

                // Profile Section
                 Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=11'),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGold,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.edit, color: AppColors.primaryDark, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Column(
                    children: [
                      Text(
                        'Alex Johnson',
                        style: TextStyle(
                          color: AppColors.textMain,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Computer Science • ID: 20234819',
                        style: TextStyle(
                          color: AppColors.primaryTeal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const Text('ACCOUNT', style: TextStyle(color: AppColors.textGray, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildSettingsItem(Icons.person, 'Personal Information'),
                      Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.lock, 'Security & Password'),
                       Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.badge, 'Digital Student ID'),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                const Text('APP PREFERENCES', style: TextStyle(color: AppColors.textGray, fontSize: 12, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildSwitchItem(
                        Icons.notifications, 
                        'Push Notifications', 
                        true,
                        (v) {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                 Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                       _buildSettingsItem(Icons.info_outline, 'About App'),
                      Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(
                        Icons.bug_report_outlined, 
                        'Report Bug',
                        onTap: () {
                           BugReportOverlay.of(context)?.activate();
                        },
                      ),
                      Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.help_outline, 'Help Center'),
                      Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
                
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OutlinedButton(
                    onPressed: () {
                       Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.statusRed.withOpacity(0.5)),
                      backgroundColor: AppColors.statusRed.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Icon(Icons.logout, color: AppColors.primaryTeal), // Design shows teal for logout icon? Or uses Teal accent colour globally? Let's use Teal to match image
                         SizedBox(width: 8),
                         Text(
                          'Sign Out',
                          style: TextStyle(
                            color: AppColors.primaryTeal,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                 const SizedBox(height: 24),
                  const Center(child: Text('App Version 2.4.0 (Build 302)', style: TextStyle(color: AppColors.textGray, fontSize: 12))),
                 const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsItem(IconData icon, String title, {String? trailing, VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryGold.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryGold, size: 20),
      ),
      title: Text(title, style: TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) ...[
            Text(trailing, style: TextStyle(color: AppColors.textGray, fontSize: 14)),
            const SizedBox(width: 8),
          ],
          Icon(Icons.chevron_right, color: AppColors.textGray),
        ],
      ),
      onTap: onTap ?? () {},
    );
  }

    Widget _buildSwitchItem(IconData icon, String title, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withOpacity(0.1), // Example variations
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryTeal, size: 20),
      ),
      title: Text(title, style: TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Switch(
        value: value, 
        onChanged: onChanged,
        activeColor: AppColors.primaryGold,
        activeTrackColor: AppColors.primaryGold.withOpacity(0.5),
      ),
    );
  }
}
