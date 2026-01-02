import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';
import 'login_screen.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showBugReportDialog() {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.backgroundCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text(
          'Report a Bug',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Please describe the issue you encountered.',
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'What went wrong?',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                filled: true,
                fillColor: Colors.black.withOpacity(0.2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Bug report submitted!'),
                  backgroundColor: AppColors.primaryTeal,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGold,
              foregroundColor: AppColors.primaryDark,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Submit', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

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
                        icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
                        onPressed: () => Navigator.maybePop(context),
                      ),
                    const Expanded(
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
                if (_isLoading)
                  const Column(
                    children: [
                      ShimmerLoading.circular(radius: 50),
                      SizedBox(height: 16),
                      ShimmerLoading.rectangular(height: 24, width: 150),
                      SizedBox(height: 8),
                      ShimmerLoading.rectangular(height: 16, width: 200),
                    ],
                  )
                else
                  _buildProfileSection(),

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
                      const Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.lock, 'Security & Password'),
                       const Divider(height: 1, color: AppColors.white24),
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
                      const Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(
                        Icons.bug_report_outlined, 
                        'Report Bug',
                        onTap: _showBugReportDialog,
                      ),
                      const Divider(height: 1, color: AppColors.white24),
                      _buildSettingsItem(Icons.help_outline, 'Help Center'),
                      const Divider(height: 1, color: AppColors.white24),
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
                         Icon(Icons.logout, color: AppColors.primaryTeal),
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

  Widget _buildProfileSection() {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage('https://i.pravatar.cc/300?img=11'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGold,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.edit, color: AppColors.primaryDark, size: 16),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Alex Johnson',
          style: TextStyle(
            color: AppColors.textMain,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Computer Science • ID: 20234819',
          style: TextStyle(
            color: AppColors.primaryTeal,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
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
      title: Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null) ...[
            Text(trailing, style: const TextStyle(color: AppColors.textGray, fontSize: 14)),
            const SizedBox(width: 8),
          ],
          const Icon(Icons.chevron_right, color: AppColors.textGray),
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
          color: AppColors.primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.primaryTeal, size: 20),
      ),
      title: Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 16, fontWeight: FontWeight.w500)),
      trailing: Switch(
        value: value, 
        onChanged: onChanged,
        activeColor: AppColors.primaryGold,
        activeTrackColor: AppColors.primaryGold.withOpacity(0.5),
      ),
    );
  }
}
