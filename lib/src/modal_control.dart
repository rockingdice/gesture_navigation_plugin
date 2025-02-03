import 'package:flutter/material.dart';
import 'dart:ui';

/// A widget that allows swipe-up to open and swipe-down to dismiss a modal with smooth interaction.
class ModalControl extends StatefulWidget {
  final Widget child;
  final VoidCallback? onSwipeUp;
  final VoidCallback? onSwipeDown;
  final bool allowDismiss;
  final double swipeSensitivity;

  /// **Creates a modal with swipe gestures**
  ///
  /// - `child`: Content inside the modal.
  /// - `onSwipeUp`: Callback for swipe up.
  /// - `onSwipeDown`: Callback for swipe down.
  /// - `allowDismiss`: If `false`, prevents accidental dismissal.
  /// - `swipeSensitivity`: Controls how fast the user must swipe (default: 300).
  const ModalControl({
    Key? key,
    required this.child,
    this.onSwipeUp,
    this.onSwipeDown,
    this.allowDismiss = true,
    this.swipeSensitivity = 300.0,
  }) : super(key: key);

  @override
  _ModalControlState createState() => _ModalControlState();
}

class _ModalControlState extends State<ModalControl>
    with SingleTickerProviderStateMixin {
  double _dragPosition = 0.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  /// **Handles drag movement smoothly**
  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.primaryDelta!;
      _dragPosition = _dragPosition.clamp(-50, 300); // Limits movement
    });
  }

  /// **Handles drag end & determines action**
  void _handleDragEnd(DragEndDetails details) {
    if (details.primaryVelocity != null) {
      if (details.primaryVelocity! < -widget.swipeSensitivity) {
        widget.onSwipeUp?.call();
      } else if (details.primaryVelocity! > widget.swipeSensitivity) {
        if (widget.allowDismiss) {
          widget.onSwipeDown?.call();
        }
      }
    }
    _resetPosition();
  }

  /// **Resets modal position smoothly**
  void _resetPosition() {
    _animationController.forward(from: 0);
    setState(() {
      _dragPosition = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _handleDragUpdate,
      onVerticalDragEnd: _handleDragEnd,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _dragPosition, 0),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: widget.child,
        ),
      ),
    );
  }
}
