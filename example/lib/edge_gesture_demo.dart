import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';

class EdgeGestureDemo extends StatefulWidget {
  @override
  _EdgeGestureDemoState createState() => _EdgeGestureDemoState();
}

class _EdgeGestureDemoState extends State<EdgeGestureDemo> {
  bool enableHaptic = true;
  bool enableSnackbar = true;

  /// **Shows a Snackbar Without Spamming**
  void _showSnackbar(String message) {
    if (enableSnackbar) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edge Gesture Demo"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: _showSettingsDialog,
          ),
        ],
      ),
      body: EdgeGesture(
        onSwipeLeftEdge: () => _showSnackbar("Swiped from Left Edge!"),
        onSwipeRightEdge: () => _showSnackbar("Swiped from Right Edge!"),
        enableHapticFeedback: enableHaptic,
        child: const Center(
          child: Text(
            "Swipe from the **left or right edge** to trigger actions.\n\nPress settings to enable/disable options.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  /// **Settings Dialog**
  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Settings"),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSwitchTile("Enable Haptic Feedback", enableHaptic,
                      (val) {
                    setDialogState(() => enableHaptic = val);
                    setState(() {});
                  }),
                  _buildSwitchTile("Enable Snackbar Messages", enableSnackbar,
                      (val) {
                    setDialogState(() => enableSnackbar = val);
                    setState(() {});
                  }),
                ],
              );
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Close")),
          ],
        );
      },
    );
  }

  /// **Helper for Settings Switches**
  Widget _buildSwitchTile(String title, bool value, Function(bool) onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: (val) {
        onChanged(val);
      },
    );
  }
}
