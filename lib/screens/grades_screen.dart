import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';

class GradesScreen extends StatefulWidget {
  const GradesScreen({super.key});

  @override
  State<GradesScreen> createState() => _GradesScreenState();
}

class _GradesScreenState extends State<GradesScreen> {
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
        title: const Text(
          'Academic Results',
          style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isLoading 
                ? const ShimmerLoading.rectangular(height: 160)
                : _buildGPAHeader(),
            const SizedBox(height: 32),
            const Text(
              'REPORTS BY SEMESTER',
              style: TextStyle(
                color: AppColors.textGray,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            if (_isLoading)
              Column(
                children: List.generate(2, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: const ShimmerLoading.rectangular(height: 200),
                )),
              )
            else
              Column(
                children: [
                   _buildSemesterCard('Year 3 - Semester 1 (Current)', '3.82', [
                    _buildGradeItem('SC 301: Introduction to CS', 'A'),
                    _buildGradeItem('SC 302: Data Structures', 'A-'),
                    _buildGradeItem('SC 303: Operating Systems', 'B+'),
                  ]),
                  const SizedBox(height: 16),
                  _buildSemesterCard('Year 2 - Semester 2', '3.65', [
                    _buildGradeItem('SC 201: Discrete Math', 'A'),
                    _buildGradeItem('SC 202: Algorithms', 'B'),
                    _buildGradeItem('SC 203: Databases', 'A-'),
                  ]),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGPAHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primaryGold,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Cumulative GPA',
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'BSc. Comp Sci',
                  style: TextStyle(color: AppColors.primaryDark, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            '3.74',
            style: TextStyle(
              color: AppColors.primaryDark,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Top 5% of Department',
            style: TextStyle(
              color: AppColors.primaryDark.withOpacity(0.8),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemesterCard(String title, String gpa, List<Widget> items) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textMain,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'GPA: $gpa',
                  style: const TextStyle(
                    color: AppColors.primaryGold,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...items,
        ],
      ),
    );
  }

  Widget _buildGradeItem(String subject, String grade) {
    return ListTile(
      title: Text(
        subject,
        style: const TextStyle(color: AppColors.textMain, fontSize: 14),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primaryTeal.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          grade,
          style: const TextStyle(
            color: AppColors.primaryTeal,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
