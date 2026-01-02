import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';
import 'library_screen.dart';
import 'confess_screen.dart';
import 'fees_tab.dart';
import 'channua_tab.dart';
import 'grades_screen.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good Morning,',
                          style: TextStyle(color: AppColors.textGray, fontSize: 12),
                        ),
                        Text(
                          'Alex Johnson',
                          style: TextStyle(
                            color: AppColors.textMain,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Stack(
                      children: [
                        Icon(Icons.notifications, color: AppColors.textMain),
                        Positioned(
                          right: 2,
                          top: 2,
                          child: CircleAvatar(
                            radius: 4,
                            backgroundColor: AppColors.statusRed,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 24),

                // ID Card
                _buildIDCard(),

                const SizedBox(height: 32),

                // Quick Actions
                _buildQuickActions(context),

                const SizedBox(height: 32),

                // Daily Inspiration
                const Text(
                  'Daily Inspiration',
                  style: TextStyle(
                    color: AppColors.textMain,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                _isLoading 
                  ? const ShimmerLoading.rectangular(height: 160)
                  : _buildInspirationCard(),

                const SizedBox(height: 32),

                 // Latest Notices
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Latest Notices',
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primaryGold.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                if (_isLoading)
                  Column(
                    children: List.generate(2, (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ShimmerLoading.rectangular(height: 80),
                    )),
                  )
                else
                  Column(
                    children: [
                      _buildNoticeItem(
                        icon: Icons.calendar_today,
                        color: const Color(0xFF2E7D5C),
                        title: 'Exam Timetable Released',
                        subtitle: 'May 2024 Semester Exams',
                        hasDot: true,
                      ),
                      const SizedBox(height: 12),
                       _buildNoticeItem(
                        icon: Icons.warning_amber_rounded,
                        color: AppColors.primaryGold,
                        title: 'Library Closure',
                        subtitle: 'Maintenance on 12th June',
                        hasDot: false,
                      ),
                    ],
                  ),

                const SizedBox(height: 32),

                 // Campus Posts
                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Campus Posts',
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        color: AppColors.primaryGold.withOpacity(0.8),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                if (_isLoading)
                  Column(
                    children: List.generate(2, (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: ShimmerLoading.rectangular(height: 100),
                    )),
                  )
                else
                  Column(
                    children: [
                      _buildPostItem(
                        'Highlights from Tech Week 2024: Innovation on Display',
                        '2 hours ago',
                        'Events',
                        'https://images.unsplash.com/photo-1544531586-fde5298cdd40?w=800',
                      ),
                      const SizedBox(height: 12),
                       _buildPostItem(
                        'Rugby Team secures spot in semi-finals',
                        'Yesterday',
                        'Sports',
                        'https://images.unsplash.com/photo-1560272564-c83b66b1ad12?w=800',
                         isSports: true,
                      ),
                    ],
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIDCard() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD1A443), Color(0xFF2E7D5C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              FontAwesomeIcons.graduationCap,
              size: 150,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(FontAwesomeIcons.graduationCap, color: Colors.white, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'TUK STUDENT ID',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(Icons.qr_code, size: 24),
                    ),
                  ],
                ),
                const Spacer(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Mwangi',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'SC201/1054/2021',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(color: Colors.white24, height: 1),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PROGRAM', style: TextStyle(color: Colors.white60, fontSize: 10)),
                        Text('B.Sc. Computer Science', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('YEAR / SEM', style: TextStyle(color: Colors.white60, fontSize: 10)),
                        Text('Y3 . S2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildQuickActionItem(context, icon: Icons.local_library, color: AppColors.primaryTeal, label: 'Library', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LibraryScreen())))),
            const SizedBox(width: 12),
            Expanded(child: _buildQuickActionItem(context, icon: Icons.diversity_3, color: AppColors.primaryGold, label: 'Confess', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ConfessScreen())))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildQuickActionItem(context, icon: Icons.account_balance_wallet, color: const Color(0xFF5C6BC0), label: 'Financials', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const FeesTab())))),
            const SizedBox(width: 12),
            Expanded(child: _buildQuickActionItem(context, icon: Icons.grade, color: AppColors.primaryGold, label: 'Results', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const GradesScreen())))),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildQuickActionItem(context, icon: Icons.forum, color: const Color(0xFFAB47BC), label: 'Channua', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ChannuaTab())))),
            const SizedBox(width: 12),
            Expanded(child: _buildQuickActionItem(context, icon: Icons.event_note, color: AppColors.primaryTeal, label: 'Timetable', onTap: () {})),
          ],
        ),
      ],
    );
  }

  Widget _buildInspirationCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(FontAwesomeIcons.quoteLeft, color: AppColors.primaryGold, size: 20),
          SizedBox(height: 12),
          Text(
            '"Education is the most powerful weapon which you can use to change the world."',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textMain,
              fontSize: 16,
              fontStyle: FontStyle.italic,
              height: 1.5,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '— Nelson Mandela',
                style: TextStyle(
                  color: AppColors.primaryGold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeItem({required IconData icon, required Color color, required String title, required String subtitle, required bool hasDot}) {
    return Container(
       padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textMain,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (hasDot)
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryTeal,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: AppColors.textGray,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textGray),
          ],
        ),
    );
  }

    Widget _buildPostItem(String title, String time, String category, String imageUrl, {bool isSports = false}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSports ? const Color(0xFF654321) : AppColors.primaryTeal.withOpacity(0.2), 
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    category,
                    style: TextStyle(
                      color: isSports ? AppColors.primaryGold : AppColors.primaryTeal,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textMain,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.textGray,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildQuickActionItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.backgroundCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.textMain,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}