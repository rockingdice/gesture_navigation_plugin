import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';
import 'package:provider/provider.dart';

class GestureSettingsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GestureSettings(),
      child: GestureSettingsPage(),
    );
  }
}

class GestureSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<GestureSettings>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Gesture Settings")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Swipe Sensitivity",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Slider(
              value: settings.swipeSensitivity,
              min: 100.0,
              max: 1000.0,
              divisions: 9,
              label: settings.swipeSensitivity.toStringAsFixed(0),
              onChanged: (value) => settings.updateSwipeSensitivity(value),
            ),
            SwitchListTile(
              title: const Text("Enable Swipe Navigation"),
              value: settings.enableSwipeNavigation,
              onChanged: (value) => settings.toggleSwipeNavigation(value),
            ),
            SwitchListTile(
              title: const Text("Enable Edge Gestures"),
              value: settings.enableEdgeGestures,
              onChanged: (value) => settings.toggleEdgeGestures(value),
            ),
          ],
        ),
      ),
    );
  }
}
