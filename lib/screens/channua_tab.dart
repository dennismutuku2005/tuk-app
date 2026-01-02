import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';

class ChannuaTab extends StatefulWidget {
  const ChannuaTab({super.key});

  @override
  State<ChannuaTab> createState() => _ChannuaTabState();
}

class _ChannuaTabState extends State<ChannuaTab> {
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                             const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'), radius: 20), // User
                             const SizedBox(width: 12),
                             const Text(
                              'Channua Room',
                              style: TextStyle(color: AppColors.textMain, fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const IconButton(icon: Icon(Icons.search, color: AppColors.textGray, size: 20), onPressed: null),
                            Stack(
                              children: [
                                const Icon(Icons.notifications, color: AppColors.textMain, size: 20),
                                Positioned(right: 0, top: 0, child: CircleAvatar(radius: 4, backgroundColor: AppColors.statusRed)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildCategoryChip('All', true),
                          _buildCategoryChip('Popular', false),
                           _buildCategoryChip('Academics', false),
                          _buildCategoryChip('Finance', false),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                    
                    // Ask Question Input
                    if (_isLoading)
                      const ShimmerLoading.rectangular(height: 100)
                    else
                      Container(
                         padding: const EdgeInsets.all(12),
                         decoration: BoxDecoration(
                           color: AppColors.backgroundCard,
                           borderRadius: BorderRadius.circular(16),
                         ),
                         child: Column(
                           children: [
                             const Row(
                               children: [
                                 CircleAvatar(
                                   radius: 16,
                                   backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'), // Current user
                                 ),
                                 SizedBox(width: 12),
                                 Expanded(
                                   child: Text(
                                     "What's on your mind? Ask a question...",
                                     style: TextStyle(color: AppColors.textGray),
                                   ),
                                 ),
                               ],
                             ),
                             const SizedBox(height: 12),
                             Row(
                               children: [
                                 Icon(Icons.image, color: AppColors.primaryTeal.withOpacity(0.8), size: 20),
                                 const SizedBox(width: 16),
                                 Icon(Icons.sell, color: AppColors.primaryTeal.withOpacity(0.8), size: 20),
                                 const Spacer(),
                                 Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                   decoration: BoxDecoration(
                                     color: AppColors.primaryGold,
                                     borderRadius: BorderRadius.circular(20),
                                   ),
                                   child: const Text('Post', style: TextStyle(color: AppColors.primaryDark, fontWeight: FontWeight.bold)),
                                 ),
                               ],
                             )
                           ],
                         ),
                      ),
                  ],
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Discussions', style: TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('VIEW ALL', style: TextStyle(color: AppColors.primaryTeal.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              if (_isLoading)
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: 2,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: ShimmerLoading.rectangular(height: 200),
                  ),
                )
              else
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    _buildDiscussionItem(
                      tag: 'Finance',
                      time: '2h ago',
                      title: 'HELB Loan Disbursement',
                      content: 'Has anyone received their HELB loan disbursement for this semester? It\'s been over a week since the portal status changed to...',
                      likes: 124,
                      comments: 24,
                      avatars: ['https://i.pravatar.cc/150?img=1', 'https://i.pravatar.cc/150?img=2', 'https://i.pravatar.cc/150?img=3'],
                    ),
                     _buildDiscussionItem(
                      tag: 'Academics',
                      time: '45m ago',
                      title: 'Study Group for SC 301?',
                      content: 'Looking for serious study partners for Introduction to Computer Science. We meet at the library every Tue/Thu.',
                      likes: 8,
                      comments: 5,
                      author: 'David Kimani',
                      authorRole: 'Engineering',
                      hasAuthor: true,
                      tags: ['#Academics', '#StudyGroup'],
                    ),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),

    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryGold : AppColors.white24.withOpacity(0.1),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: isSelected ? AppColors.primaryGold : Colors.transparent),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? AppColors.primaryDark : AppColors.textMain,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDiscussionItem({
    required String tag,
    required String time,
    required String title,
    required String content,
    required int likes,
    required int comments,
    List<String>? avatars,
    String? author,
    String? authorRole,
    bool hasAuthor = false,
    List<String>? tags,
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
          if (hasAuthor)
           Row(
             children: [
               const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'), radius: 16),
               const SizedBox(width: 12),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(author!, style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                   Text('$authorRole • $time', style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
                 ],
               ),
             ],
           )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(tag, style: const TextStyle(color: AppColors.primaryTeal, fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(width: 8),
                    Text('• $time', style: const TextStyle(color: AppColors.textGray, fontSize: 12)),
                  ],
                ),
                const Icon(Icons.more_horiz, color: AppColors.textGray),
              ],
            ),
          
          const SizedBox(height: 12),
          
          Text(title, style: const TextStyle(color: AppColors.textMain, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(content, style: TextStyle(color: AppColors.textGray.withOpacity(0.9), height: 1.4)),
          
          if (tags != null) ...[
            const SizedBox(height: 12),
            Row(
              children: tags.map((t) => Container(
                margin: const EdgeInsets.only(right: 8),
                 padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                 decoration: BoxDecoration(color: AppColors.white24.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                 child: Text(t, style: const TextStyle(color: AppColors.primaryTeal, fontSize: 12)),
              )).toList(),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.white24),
          const SizedBox(height: 12),
          
          Row(
            children: [
              Icon(Icons.thumb_up_alt_outlined, color: AppColors.textGray.withOpacity(0.7), size: 18),
              const SizedBox(width: 6),
              Text('$likes', style: const TextStyle(color: AppColors.textMain, fontSize: 13, fontWeight: FontWeight.bold)),
              const SizedBox(width: 20),
              Icon(Icons.chat_bubble_outline, color: AppColors.textGray.withOpacity(0.7), size: 18),
               const SizedBox(width: 6),
              Text('$comments Replies', style: const TextStyle(color: AppColors.textMain, fontSize: 13, fontWeight: FontWeight.bold)),
              
              const Spacer(),
              
              if (avatars != null)
                SizedBox(
                  width: 60,
                  height: 24,
                  child: Stack(
                    children: [
                      Positioned(left: 0, child: CircleAvatar(backgroundImage: NetworkImage(avatars[0]), radius: 10)),
                      Positioned(left: 15, child: CircleAvatar(backgroundImage: NetworkImage(avatars[1]), radius: 10)),
                      Positioned(left: 30, child: CircleAvatar(backgroundImage: NetworkImage(avatars[2]), radius: 10)),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
