import 'package:flutter/material.dart';

/// A provider that manages gesture settings globally.
class GestureSettings extends ChangeNotifier {
  double _swipeSensitivity = 300.0;
  bool _enableSwipeNavigation = true;
  bool _enableEdgeGestures = true;

  /// Gets the swipe sensitivity value.
  double get swipeSensitivity => _swipeSensitivity;

  /// Gets whether swipe navigation is enabled.
  bool get enableSwipeNavigation => _enableSwipeNavigation;

  /// Gets whether edge gestures are enabled.
  bool get enableEdgeGestures => _enableEdgeGestures;

  /// Updates swipe sensitivity.
  void updateSwipeSensitivity(double value) {
    _swipeSensitivity = value;
    notifyListeners();
  }

  /// Toggles swipe navigation.
  void toggleSwipeNavigation(bool value) {
    _enableSwipeNavigation = value;
    notifyListeners();
  }

  /// Toggles edge gestures.
  void toggleEdgeGestures(bool value) {
    _enableEdgeGestures = value;
    notifyListeners();
  }
}
