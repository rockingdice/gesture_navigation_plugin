import 'package:flutter/material.dart';
import 'swipe_navigation_demo.dart';
import 'pinch_zoom_demo.dart';
import 'drag_reorder_demo.dart';
import 'edge_gesture_demo.dart';
import 'modal_control_demo.dart';
import 'settings_demo.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Navigation Demo')),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildDemoTile(context, 'Swipe Navigation', SwipeNavigationDemo()),
          _buildDemoTile(context, 'Pinch-to-Zoom', PinchZoomDemo()),
          _buildDemoTile(context, 'Drag & Reorder', DragReorderDemo()),
          _buildDemoTile(context, 'Edge Gestures', EdgeGestureDemo()),
          _buildDemoTile(context, 'Modal Control', ModalControlDemo()),
          _buildDemoTile(context, 'Gesture Settings', GestureSettingsDemo()),
        ],
      ),
    );
  }

  /// Builds a ListTile for the demo navigation
  Widget _buildDemoTile(BuildContext context, String title, Widget page) {
    return Card(
      child: ListTile(
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        ),
      ),
    );
  }
}
