import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ConfessScreen extends StatelessWidget {
  const ConfessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.textMain),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Confess Room', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white24,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.shield, color: AppColors.textMain, size: 16),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primaryTeal,
        label: const Text('Confess', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Speak your mind\nfreely.',
                style: TextStyle(
                  color: AppColors.textMain,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 20),
              
              // Privacy Badge
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF33691E).withOpacity(0.2), // Dark green background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF33691E).withOpacity(0.5)),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.visibility_off, color: AppColors.primaryGold, size: 20),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Your identity is hidden. This is a safe space for the TUK community to share thoughts without judgment.',
                        style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Filter Tabs
              Row(
                children: [
                  _buildFilterTab('Recent', true),
                  _buildFilterTab('Trending', false, icon: Icons.local_fire_department),
                  _buildFilterTab('Top Rated', false),
                ],
              ),

              const SizedBox(height: 24),

              // Feed
              _buildConfessionItem(
                avatarColor: Colors.teal,
                name: 'Anonymous Owl',
                time: '2m ago',
                text: 'I honestly don\'t know how I\'m going to pass Stats 101... Is anyone else struggling this much? The professor moves way too fast.',
                likes: 12,
                comments: 4,
                mood: 'Hug',
              ),
              _buildConfessionItem(
                avatarImage: 'https://i.pravatar.cc/150?img=60',
                name: 'Hidden Fox',
                time: '15m ago',
                text: 'To the girl in the red hoodie at the library: your playlist is too loud, but honestly? impeccable taste. Can you drop the link?',
                likes: 48,
                comments: 12,
                isHighlight: true,
              ),
               _buildConfessionItem(
                 avatarColor: Colors.purple,
                name: 'Silent Echo',
                time: '1h ago',
                text: 'Found a wallet near the cafeteria. Turned it into security. Hope you get it back, Jason!',
                likes: 85,
                comments: 2,
              ),
              _buildConfessionItem(
                avatarColor: Colors.grey,
                name: 'Ghost Writer',
                time: '3h ago',
                text: 'Sometimes I just sit in the quad and watch the squirrels. It\'s the only peace I get during finals week.',
                likes: 23,
                comments: 0,
              ),
              
              const SizedBox(height: 60),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterTab(String label, bool isSelected, {IconData? icon}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryTeal : AppColors.white24.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.white24.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 16, color: isSelected ? Colors.white : AppColors.primaryGold),
              const SizedBox(width: 6),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfessionItem({
    Color? avatarColor,
    String? avatarImage,
    required String name,
    required String time,
    required String text,
    required int likes,
    required int comments,
    String? mood,
    bool isHighlight = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  if (avatarImage != null)
                     CircleAvatar(backgroundImage: NetworkImage(avatarImage), radius: 18)
                  else
                    CircleAvatar(backgroundColor: avatarColor!.withOpacity(0.5), radius: 18),
                  const SizedBox(width: 12),
                  Text(name, style: TextStyle(color: isHighlight ? AppColors.primaryGold : AppColors.primaryTeal, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(time, style: TextStyle(color: AppColors.textGray, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            text,
            style: TextStyle(color: AppColors.textMain, fontSize: 15, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(Icons.favorite, color: likes > 50 ? AppColors.statusRed : AppColors.textGray, size: 18),
              const SizedBox(width: 6),
              Text('$likes', style: TextStyle(color: AppColors.textGray, fontSize: 13)),
              const SizedBox(width: 16),
              Icon(Icons.chat_bubble, color: AppColors.textGray, size: 18),
              const SizedBox(width: 6),
              Text('$comments', style: TextStyle(color: AppColors.textGray, fontSize: 13)),
              
              if (mood != null) ...[
                const SizedBox(width: 16),
                Icon(Icons.sentiment_satisfied, color: AppColors.textGray, size: 18),
                const SizedBox(width: 6),
                Text(mood, style: TextStyle(color: AppColors.textGray, fontSize: 13)),
              ],

              const Spacer(),
              Icon(Icons.flag, color: AppColors.textGray, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
