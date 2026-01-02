import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({super.key});

  @override
  State<NewsTab> createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate data fetching
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
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
                    Row(
                      children: [
                         const CircleAvatar(
                          backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'), 
                          radius: 20,
                        ),
                         const SizedBox(width: 12),
                         Column(
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
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white24.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Stack(
                        children: [
                           Icon(Icons.notifications, color: AppColors.textMain),
                           Positioned(
                            right: 0,
                            top: 0,
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: AppColors.statusRed,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),

                // Search Bar
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.white24.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderGray.withOpacity(0.5)),
                  ),
                  child: TextField(
                    style: TextStyle(color: AppColors.textMain), 
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: AppColors.textGray),
                      hintText: 'Search news, events...',
                      hintStyle: TextStyle(color: AppColors.textGray),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Categories
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategoryChip('All', isSelected: true),
                      _buildCategoryChip('Academic'),
                      _buildCategoryChip('Events'),
                      _buildCategoryChip('Sports'),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Featured
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Featured',
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View all',
                      style: TextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Featured Card (Shimmed)
                 if (_isLoading)
                  const ShimmerLoading.rectangular(height: 180)
                else
                  Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1531482615713-2afd69097998?w=800'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.8),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryTeal,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Text(
                            'Innovation Week',
                            style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'TUK Innovation Week Starts Monday!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Row(
                          children: [
                            Icon(Icons.access_time, color: Colors.white70, size: 12),
                             SizedBox(width: 4),
                             Text(
                              '2 hours ago',
                              style: TextStyle(color: Colors.white70, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Latest Updates
                Text(
                  'Latest Updates',
                  style: TextStyle(
                    color: AppColors.textMain,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                if (_isLoading)
                  Column(
                    children: [
                       const SizedBox(height: 16),
                       const ShimmerLoading.rectangular(height: 80),
                       const SizedBox(height: 16),
                       const ShimmerLoading.rectangular(height: 80),
                       const SizedBox(height: 16),
                       const ShimmerLoading.rectangular(height: 80),
                    ],
                  )
                else
                  Column(
                    children: [
                      _buildNewsItem(
                        'Semester Exam Schedule Released',
                        '4 hours ago',
                        'ACADEMIC',
                        'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800',
                      ),
                      _buildNewsItem(
                        'Varsity Football Trials: Registration Open',
                        '1 day ago',
                        'SPORTS',
                        'https://images.unsplash.com/photo-1517649763962-0c623066013b?w=800',
                        isSports: true,
                      ),
                       _buildNewsItem(
                        'Library Maintenance Hours Updated',
                        '2 days ago',
                        'CAMPUS LIFE',
                        'https://images.unsplash.com/photo-1521587760476-6c12a4b040da?w=800',
                      ),
                       // Added more items to test scrolling
                        _buildNewsItem(
                        'New Cafeteria Menu',
                        '3 days ago',
                        'CAMPUS LIFE',
                        'https://images.unsplash.com/photo-1565256509603-c8113a986ec5?w=800',
                      ),
                       _buildNewsItem(
                        'Tech Club Hackathon Winners',
                        '4 days ago',
                        'EVENTS',
                        'https://images.unsplash.com/photo-1504384308090-c54be3855833?w=800',
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryGold : AppColors.white24.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primaryDark : AppColors.textGray,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildNewsItem(String title, String time, String category, String imageUrl, {bool isSports = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              height: 80,
              width: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: isSports ? const Color(0xFF654321) : AppColors.primaryTeal.withOpacity(0.2), // Brownish for sports, Teal tint for others
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
                const SizedBox(height: 8),
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
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: AppColors.primaryGold),
        ],
      ),
    );
  }
}
