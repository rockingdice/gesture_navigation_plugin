import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';

class ModalControlDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Advanced Modal Control")),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showCustomModal(context),
          child: const Text("Open Modal"),
        ),
      ),
    );
  }

  /// **Displays a modern modal with swipe gestures**
  void _showCustomModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false, // Prevent tapping outside to dismiss
      backgroundColor: Colors.transparent,
      builder: (_) => _buildModalContent(context),
    );
  }

  /// **Modal Content with Blur Effect**
  Widget _buildModalContent(BuildContext context) {
    return ModalControl(
      onSwipeDown: () => Navigator.pop(context),
      child: Stack(
        children: [
          // **Blurred Background for a Modern Look**
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),

          // **Modal Content**
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 350,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 10),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // **Drag Indicator**
                  Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // **Title**
                  const Text(
                    "Swipe Down to Close",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // **Content**
                  const Text(
                    "This modal supports smooth swipe-up and swipe-down gestures.\nYou can customize it further!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 20),

                  // **Dismiss Button**
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close Modal"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
