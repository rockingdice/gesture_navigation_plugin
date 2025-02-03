import 'package:example_gesture_navigation/swipe_navigation_demo.dart';
import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';

class NextPage extends StatelessWidget {
  const NextPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SwipeNavigation(
      onSwipeRight: () {
        Navigator.pop(context);
      },
      showSwipeIndicator: true,
      child: Scaffold(
        body: Stack(
          children: [
            /// Background Gradient
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFF512F), Color(0xFFDD2476)],
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
                      "Next Page",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildSwipeHint(
                        Icons.arrow_forward, "Swipe Right → Go Back"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwipeHint(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 10),
          Text(text, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }
}
