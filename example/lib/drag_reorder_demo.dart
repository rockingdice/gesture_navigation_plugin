import 'package:flutter/material.dart';
import 'package:gesture_navigation/gesture_navigation.dart';

class DragReorderDemo extends StatefulWidget {
  @override
  _DragReorderDemoState createState() => _DragReorderDemoState();
}

class _DragReorderDemoState extends State<DragReorderDemo> {
  List<String> items = [
    "Task 1",
    "Task 2",
    "Task 3",
    "Task 4",
    "Task 5",
  ];

  bool enableUndo = true;
  bool enableSnackbar = true;
  bool enableColorPicker = true;
  bool saveOrder = true;
  Color selectedDragColor = Colors.blue[100]!; // Default drag color

  void updateOrder(List<String> newOrder) {
    setState(() {
      items = List.from(newOrder);
    });
  }

  void updateDragColor(Color newColor) {
    setState(() {
      selectedDragColor = newColor;
    });
  }

  void showSnackbarMessage(String message) {
    if (enableSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Drag & Reorder"),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                items = ["Task 1", "Task 2", "Task 3", "Task 4", "Task 5"];
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _showSettingsDialog(),
          ),
        ],
      ),
      body: DragReorder(
        items: items,
        onReorder: updateOrder,
        enableUndo: enableUndo,
        enableSnackbar: enableSnackbar,
        enableColorPicker: enableColorPicker,
        saveOrder: saveOrder,
        backgroundColor: Colors.deepPurple[50],
      ),
    );
  }

  /// **Settings Dialog to Toggle Features**
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
                  _buildSwitchTile("Enable Undo", enableUndo, (val) {
                    setDialogState(() => enableUndo = val);
                    setState(() {});
                  }),
                  _buildSwitchTile("Enable Snackbar", enableSnackbar, (val) {
                    setDialogState(() => enableSnackbar = val);
                    setState(() {});
                  }),
                  _buildSwitchTile("Enable Color Picker", enableColorPicker,
                      (val) {
                    setDialogState(() => enableColorPicker = val);
                    setState(() {});
                  }),
                  _buildSwitchTile("Save Order Persistently", saveOrder, (val) {
                    setDialogState(() => saveOrder = val);
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

  /// **Helper Method for Settings Switches**
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
