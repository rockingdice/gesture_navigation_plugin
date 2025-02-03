import 'package:example_gesture_navigation/next_page.dart';
import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';

class SwipeNavigationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SwipeNavigation(
      onSwipeLeft: () {
        Navigator.push(
          context,
          createPageTransition(const NextPage(), SwipeTransitionType.scale),
        );
      },
      onSwipeRight: () {
        Navigator.pop(context);
      },
      onSwipeUp: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Swiped Up!")),
        );
      },
      onSwipeDown: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Swiped Down!")),
        );
      },
      showSwipeIndicator: true,
      enableHapticFeedback: true,
      child: Scaffold(
        body: Stack(
          children: [
            /// Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF2E3192), Color(0xFF1BFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),

            /// Center Card
            Center(
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Swipe Navigation Demo",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSwipeHint(Icons.arrow_back, "Swipe Left → Next Page"),
                    _buildSwipeHint(
                        Icons.arrow_forward, "Swipe Right → Go Back"),
                    _buildSwipeHint(
                        Icons.arrow_upward, "Swipe Up → Show Snackbar"),
                    _buildSwipeHint(
                        Icons.arrow_downward, "Swipe Down → Show Snackbar"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a swipe hint with animation
  Widget _buildSwipeHint(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 14, color: Colors.white)),
        ],
      ),
    );
  }
}

/// Glassmorphic card effect
class GlassCard extends StatelessWidget {
  final Widget child;
  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
