import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class BugReportOverlay extends StatefulWidget {
  final Widget child;

  const BugReportOverlay({super.key, required this.child});

  static _BugReportOverlayState? of(BuildContext context) {
    return context.findAncestorStateOfType<_BugReportOverlayState>();
  }

  @override
  State<BugReportOverlay> createState() => _BugReportOverlayState();
}

class _BugReportOverlayState extends State<BugReportOverlay> {
  bool _isActive = false;
  final List<Offset> _circles = [];
  final TextEditingController _controller = TextEditingController();

  void activate() {
    setState(() {
      _isActive = true;
      _circles.clear();
      _controller.clear();
    });
  }

  void _deactivate() {
    setState(() {
      _isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isActive)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Stack(
                children: [
                  // Tap listener for circles
                  GestureDetector(
                    onTapUp: (details) {
                      setState(() {
                        _circles.add(details.localPosition);
                      });
                    },
                    child: Container(
                      color: Colors.transparent,
                    ),
                  ),
                  // Draw circles
                  ..._circles.map((offset) => Positioned(
                        left: offset.dx - 25,
                        top: offset.dy - 25,
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.red, width: 3),
                          ),
                        ),
                      )),
                  // Controls
                  Positioned(
                    bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                    left: 20,
                    right: 20,
                    child: Card(
                      color: AppColors.backgroundCard,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Report a Bug',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Tap the screen to circle the issue, then explain below.',
                              style: TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            const SizedBox(height: 16),
                            TextField(
                              controller: _controller,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: 'What is happening?',
                                hintStyle: const TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: AppColors.background,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              maxLines: 3,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  onPressed: _deactivate,
                                  child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    // Submit bug report
                                    _deactivate();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Bug report submitted!')),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryGold,
                                    foregroundColor: AppColors.primaryDark,
                                  ),
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
