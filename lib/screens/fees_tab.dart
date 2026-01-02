import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/app_colors.dart';
import '../widgets/shimmer_loading.dart';

class FeesTab extends StatefulWidget {
  const FeesTab({super.key});

  @override
  State<FeesTab> createState() => _FeesTabState();
}

class _FeesTabState extends State<FeesTab> {
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.textMain),
                      onPressed: () {},
                    ),
                    const Text(
                      'Financials',
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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

                // Total Outstanding Card
                if (_isLoading)
                  const ShimmerLoading.rectangular(height: 280)
                else
                  _buildOutstandingCard(),

                const SizedBox(height: 24),

                // Statement & Analytics Buttons
                Row(
                  children: [
                    Expanded(
                      child: _isLoading 
                        ? const ShimmerLoading.rectangular(height: 100)
                        : _buildActionButton(
                          icon: Icons.download_outlined,
                          label: 'Statement',
                          color: AppColors.primaryTeal,
                        ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _isLoading
                        ? const ShimmerLoading.rectangular(height: 100)
                        : _buildActionButton(
                          icon: Icons.pie_chart_outline,
                          label: 'Analytics',
                          color: AppColors.primaryGold,
                        ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Fee Breakdown
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Fee Breakdown',
                      style: TextStyle(
                        color: AppColors.textMain,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Fall Semester 2023',
                      style: TextStyle(
                        color: AppColors.textGray.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                if (_isLoading)
                  const ShimmerLoading.rectangular(height: 300)
                else
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundCard,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildFeeItem(
                          icon: FontAwesomeIcons.graduationCap,
                          title: 'Tuition Fee',
                          subtitle: 'Standard Rate',
                          amount: 'KES 3,800.00',
                          color: const Color(0xFF5C6BC0),
                        ),
                        const Divider(height: 1, color: AppColors.white24),
                        _buildFeeItem(
                          icon: FontAwesomeIcons.flask,
                          title: 'Lab Charges',
                          subtitle: 'Computer Science',
                          amount: 'KES 450.00',
                          color: const Color(0xFFAB47BC),
                        ),
                        const Divider(height: 1, color: AppColors.white24),
                        _buildFeeItem(
                          icon: FontAwesomeIcons.users,
                          title: 'Student Union',
                          subtitle: 'Annual',
                          amount: 'KES 100.00',
                          color: const Color(0xFF26A69A),
                        ),
                        const Divider(height: 1, color: AppColors.white24),
                        _buildFeeItem(
                          icon: Icons.verified,
                          title: 'Early Bird Discount',
                          subtitle: 'Applied automatically',
                          amount: '-KES 50.00',
                          color: const Color(0xFF2E7D5C),
                          isDiscount: true,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 32),
                
                if (_isLoading)
                  Column(
                    children: List.generate(2, (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: const ShimmerLoading.rectangular(height: 80),
                    )),
                  )
                else
                  Column(
                    children: [
                      _buildHistoryItem(
                        icon: Icons.check,
                        iconColor: AppColors.statusGreen,
                        title: 'Payment Received',
                        subtitle: 'Visa ending in 4242',
                        amount: '+KES 500.00',
                        amountColor: AppColors.statusGreen,
                        date: 'Sept 01',
                      ),
                      const SizedBox(height: 16),
                      _buildHistoryItem(
                        icon: Icons.receipt_long,
                        iconColor: AppColors.textGray,
                        title: 'Invoice #INV-2023-001',
                        subtitle: 'Fall Semester Tuition',
                        amount: 'KES 4,350.00',
                        amountColor: AppColors.textMain,
                        date: 'Aug 15',
                      ),
                    ],
                  ),
                
                 const SizedBox(height: 48),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.lock, color: AppColors.textGray.withOpacity(0.4), size: 14),
                     const SizedBox(width: 8),
                     Text(
                       'Payments secured by 256-bit SSL encryption',
                       style: TextStyle(
                         color: AppColors.textGray.withOpacity(0.4),
                         fontSize: 12,
                       ),
                     ),
                   ],
                 ),
                 const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutstandingCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: AppColors.primaryGold.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
             decoration: BoxDecoration(
              color: AppColors.statusRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.statusRed.withOpacity(0.3)),
            ),
            child: const Text(
              'Payment Overdue',
              style: TextStyle(
                color: AppColors.statusRed,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'TOTAL OUTSTANDING',
            style: TextStyle(
              color: AppColors.textGray.withOpacity(0.6),
              fontSize: 12,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'KES 4,350.00',
            style: TextStyle(
              color: AppColors.textMain,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.calendar_today, color: AppColors.primaryTeal, size: 14),
              SizedBox(width: 8),
              Text(
                'Due by Oct 15, 2023',
                style: TextStyle(
                  color: AppColors.primaryTeal,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.buttonGold,
                foregroundColor: AppColors.primaryDark,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.payments_outlined),
                  SizedBox(width: 12),
                  Text(
                    'Pay Now KES 4,350.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({required IconData icon, required String label, required Color color}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textMain,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String amount,
    required Color color,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isDiscount ? AppColors.primaryTeal : AppColors.textMain,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.textGray.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              color: isDiscount ? AppColors.primaryTeal : AppColors.textMain,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required Color amountColor,
    required String date,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white24.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: AppColors.textGray.withOpacity(0.6), fontSize: 13),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: TextStyle(color: amountColor, fontWeight: FontWeight.bold),
              ),
              Text(
                date,
                style: TextStyle(color: AppColors.textGray.withOpacity(0.6), fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
