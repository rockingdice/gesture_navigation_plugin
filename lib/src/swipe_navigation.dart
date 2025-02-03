import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// An advanced widget that enables swipe-based navigation with:
/// - Custom transitions
/// - Haptic feedback
/// - Gesture sensitivity tuning
/// - Edge detection for better swipe detection
class SwipeNavigation extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeLeft;
  final VoidCallback? onSwipeRight;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final double swipeThreshold;
  final bool enableHapticFeedback;
  final bool showSwipeIndicator;
  final SwipeTransitionType transitionType;

  /// Creates a SwipeNavigation widget.
  ///
  /// - `child`: The widget inside which swipe gestures will be detected.
  /// - `onSwipeLeft`: Callback when user swipes left.
  /// - `onSwipeRight`: Callback when user swipes right.
  /// - `onSwipeUp`: Callback when user swipes up.
  /// - `onSwipeDown`: Callback when user swipes down.
  /// - `swipeThreshold`: Minimum distance before swipe triggers.
  /// - `enableHapticFeedback`: Enables vibration on valid swipes.
  /// - `showSwipeIndicator`: Displays swipe direction hints.
  /// - `transitionType`: Determines animation for page transitions.
  const SwipeNavigation({
    Key? key,
    required this.child,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.onSwipeUp,
    this.onSwipeDown,
    this.swipeThreshold = 0.2, // Uses percentage of screen size
    this.enableHapticFeedback = true,
    this.showSwipeIndicator = false,
    this.transitionType = SwipeTransitionType.slide,
  }) : super(key: key);

  @override
  _SwipeNavigationState createState() => _SwipeNavigationState();
}

class _SwipeNavigationState extends State<SwipeNavigation> {
  Offset _startPosition = Offset.zero;
  Offset _endPosition = Offset.zero;
  bool _showIndicators = false;

  void _triggerHapticFeedback() {
    if (widget.enableHapticFeedback) {
      HapticFeedback.mediumImpact();
    }
  }

  void _handleSwipe(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final dx = (_endPosition.dx - _startPosition.dx).abs();
    final dy = (_endPosition.dy - _startPosition.dy).abs();
    final isHorizontal = dx > dy;

    if (isHorizontal && dx > screenSize.width * widget.swipeThreshold) {
      if (_endPosition.dx < _startPosition.dx) {
        widget.onSwipeLeft?.call();
      } else {
        widget.onSwipeRight?.call();
      }
      _triggerHapticFeedback();
    } else if (!isHorizontal &&
        dy > screenSize.height * widget.swipeThreshold) {
      if (_endPosition.dy < _startPosition.dy) {
        widget.onSwipeUp?.call();
      } else {
        widget.onSwipeDown?.call();
      }
      _triggerHapticFeedback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onPanStart: (details) {
            _startPosition = details.globalPosition;
            if (widget.showSwipeIndicator) {
              setState(() => _showIndicators = true);
            }
          },
          onPanUpdate: (details) {
            _endPosition = details.globalPosition;
          },
          onPanEnd: (details) {
            _handleSwipe(context);
            if (widget.showSwipeIndicator) {
              setState(() => _showIndicators = false);
            }
          },
          child: widget.child,
        ),
        if (widget.showSwipeIndicator && _showIndicators)
          _buildSwipeIndicators(),
      ],
    );
  }

  Widget _buildSwipeIndicators() {
    return Positioned.fill(
      child: IgnorePointer(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: _showIndicators ? 1.0 : 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _indicatorIcon(Icons.arrow_back_ios, Alignment.centerLeft),
              _indicatorIcon(Icons.arrow_forward_ios, Alignment.centerRight),
            ],
          ),
        ),
      ),
    );
  }

  Widget _indicatorIcon(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 24),
      ),
    );
  }
}

/// Available transition types for SwipeNavigation
enum SwipeTransitionType { fade, slide, scale }

/// Creates a smooth transition animation based on selected type.
PageRouteBuilder createPageTransition(Widget page, SwipeTransitionType type) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (type) {
        case SwipeTransitionType.fade:
          return FadeTransition(opacity: animation, child: child);
        case SwipeTransitionType.scale:
          return ScaleTransition(scale: animation, child: child);
        case SwipeTransitionType.slide:
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
              position: animation.drive(tween), child: child);
      }
    },
    transitionDuration: const Duration(milliseconds: 500),
  );
}
