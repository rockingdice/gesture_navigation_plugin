import 'package:example_gesture_navigation/pinch_zoom_demo.dart';
import 'package:flutter/material.dart';
import 'swipe_navigation_demo.dart';
import 'drag_reorder_demo.dart';
import 'edge_gesture_demo.dart';
import 'modal_control_demo.dart';
import 'settings_demo.dart';

void main() {
  runApp(const GestureExampleApp());
}

class GestureExampleApp extends StatelessWidget {
  const GestureExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gesture Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Navigation Demo')),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Swipe Navigation'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SwipeNavigationDemo()),
            ),
          ),
          ListTile(
            title: const Text('Pinch-to-Zoom'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => PinchZoomDemo()),
            ),
          ),
          ListTile(
            title: const Text('Drag & Reorder'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => DragReorderDemo()),
            ),
          ),
          ListTile(
            title: const Text('Edge Gestures'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => EdgeGestureDemo()),
            ),
          ),
          ListTile(
            title: const Text('Modal Control'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ModalControlDemo()),
            ),
          ),
          ListTile(
            title: const Text('Gesture Settings'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => GestureSettingsDemo()),
            ),
          ),
        ],
      ),
    );
  }
}
