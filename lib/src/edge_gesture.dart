import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget that detects swipe gestures from the **left and right** edges of the screen.
class EdgeGesture extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeLeftEdge;
  final VoidCallback? onSwipeRightEdge;
  final double edgeThreshold;
  final bool enableHapticFeedback;

  /// Creates an **EdgeGesture** widget.
  ///
  /// - `child`: The widget inside which edge gestures will be detected.
  /// - `onSwipeLeftEdge`: Callback for left edge swipe.
  /// - `onSwipeRightEdge`: Callback for right edge swipe.
  /// - `edgeThreshold`: Sensitivity width (default: 40 pixels).
  /// - `enableHapticFeedback`: Provides vibration feedback.
  const EdgeGesture({
    Key? key,
    required this.child,
    this.onSwipeLeftEdge,
    this.onSwipeRightEdge,
    this.edgeThreshold = 40.0,
    this.enableHapticFeedback = true,
  }) : super(key: key);

  @override
  _EdgeGestureState createState() => _EdgeGestureState();
}

class _EdgeGestureState extends State<EdgeGesture> {
  bool _gestureTriggered = false;

  /// **Triggers Haptic Feedback on Gesture**
  void _triggerHapticFeedback() {
    if (widget.enableHapticFeedback) {
      HapticFeedback.mediumImpact();
    }
  }

  /// **Handles Gesture Without Spamming**
  void _handleGesture(VoidCallback? callback) {
    if (callback != null && !_gestureTriggered) {
      setState(() {
        _gestureTriggered = true;
      });

      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          _gestureTriggered = false;
        });
      });

      _triggerHapticFeedback();
      callback.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        if (details.primaryDelta == null) return;

        if (details.globalPosition.dx < widget.edgeThreshold &&
            details.primaryDelta! > 0) {
          _handleGesture(widget.onSwipeLeftEdge);
        } else if (details.globalPosition.dx >
                screenWidth - widget.edgeThreshold &&
            details.primaryDelta! < 0) {
          _handleGesture(widget.onSwipeRightEdge);
        }
      },
      child: widget.child,
    );
  }
}
