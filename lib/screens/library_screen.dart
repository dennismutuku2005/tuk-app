import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Library Help', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How can we assist you\ntoday?',
                style: TextStyle(
                  color: AppColors.textMain,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Search our database or connect with library staff.',
                style: TextStyle(color: AppColors.textGray, fontSize: 14),
              ),
              const SizedBox(height: 20),
              
              // Search
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.white24.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.primaryTeal.withOpacity(0.3)),
                ),
                child: const TextField(
                  style: TextStyle(color: AppColors.textMain),
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: AppColors.primaryGold),
                    hintText: 'Search FAQs and Resources...',
                    hintStyle: TextStyle(color: Colors.white54),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              const Text('Quick Actions', style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              // Chat CTA
              if (_isLoading)
                const ShimmerLoading.rectangular(height: 160)
              else
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [AppColors.primaryTeal, Color(0xFF004D40)]),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Row(
                             children: [
                               Container(height: 8, width: 8, decoration: const BoxDecoration(color: AppColors.statusGreen, shape: BoxShape.circle)),
                               const SizedBox(width: 8),
                               const Text('ONLINE NOW', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
                             ],
                           ),
                          const SizedBox(height: 12),
                          const Text('Chat with a Librarian', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          const Text(
                            'Get instant answers to your research\nquestions.',
                            style: TextStyle(color: Colors.white70, fontSize: 14),
                          ),
                          const SizedBox(height: 20),
                          const Row(
                            children: [
                              Text('Start Chat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                            ],
                          ),
                        ],
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(Icons.chat_bubble, size: 80, color: Colors.white.withOpacity(0.1)),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _isLoading 
                      ? const ShimmerLoading.rectangular(height: 120)
                      : _buildQuickActionCard(
                        icon: Icons.door_front_door,
                        title: 'Book Study Room',
                        subtitle: 'Reserve a quiet space',
                        iconColor: const Color(0xFFFFB74D),
                      ),
                  ),
                  const SizedBox(width: 16),
                   Expanded(
                    child: _isLoading
                      ? const ShimmerLoading.rectangular(height: 120)
                      : _buildQuickActionCard(
                        title: 'Report Issue',
                        subtitle: 'Facilities or access',
                         icon: Icons.warning_amber,
                         iconColor: AppColors.statusRed,
                      ),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),

              // Library Map
              if (_isLoading)
                const ShimmerLoading.rectangular(height: 180)
              else
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.5),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Main Library', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                  Row(
                                    children: [
                                      Icon(Icons.location_on, color: Colors.white70, size: 14),
                                      SizedBox(width: 4),
                                      Text('Building B, North Campus', style: TextStyle(color: Colors.white70, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white24,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text('View Full Schedule', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 32),

              const Text('Frequently Asked Questions', style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              
              if (_isLoading)
                Column(
                  children: List.generate(3, (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: const ShimmerLoading.rectangular(height: 60),
                  )),
                )
              else
                Column(
                  children: [
                    _buildFAQItem('How do I renew my books online?'),
                    const SizedBox(height: 12),
                    _buildFAQItem('Where is the quiet study zone?'),
                    const SizedBox(height: 12),
                    _buildFAQItem('Can I access journals off-campus?'),
                  ],
                ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({required IconData icon, required String title, required String subtitle, required Color iconColor}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white24.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderGray.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: TextStyle(color: AppColors.textGray.withOpacity(0.8), fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
       decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(question, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.w500)),
          const Icon(Icons.keyboard_arrow_down, color: AppColors.textGray),
        ],
      ),
    );
  }
}
