import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

/// A widget that allows users to reorder a list by dragging items.
class DragReorder extends StatefulWidget {
  final List<String> items;
  final Function(List<String>) onReorder;
  final bool enableColorPicker;
  final bool enableUndo;
  final bool enableSnackbar;
  final bool saveOrder;
  final Color? backgroundColor;

  /// Creates a drag-to-reorder list.
  ///
  /// - `items`: The list of items to display and reorder.
  /// - `onReorder`: A callback function returning the new order after reordering.
  /// - `enableColorPicker`: Enables the drag color selection.
  /// - `enableUndo`: Enables the undo last move feature.
  /// - `enableSnackbar`: Enables snackbar messages.
  /// - `saveOrder`: Enables saving the order persistently.
  /// - `itemHeight`: The height of each draggable item.
  /// - `backgroundColor`: Optional background color.
  const DragReorder({
    Key? key,
    required this.items,
    required this.onReorder,
    this.enableColorPicker = false,
    this.enableUndo = false,
    this.enableSnackbar = true,
    this.saveOrder = false,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _DragReorderState createState() => _DragReorderState();
}

class _DragReorderState extends State<DragReorder> {
  List<String> _items = [];
  String? _draggingItem;
  List<String>? _previousOrder;
  Color _selectedColor = Colors.blue[100]!; // Default drag color

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.items);
    if (widget.saveOrder) {
      _loadSavedOrder();
    }
  }

  /// Loads saved order from SharedPreferences
  Future<void> _loadSavedOrder() async {
    final prefs = await SharedPreferences.getInstance();
    final savedList = prefs.getStringList('saved_order');
    if (savedList != null && savedList.isNotEmpty) {
      setState(() {
        _items = savedList;
      });
    }
  }

  /// Saves the new order to SharedPreferences
  Future<void> _saveOrder() async {
    if (!widget.saveOrder) return;
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('saved_order', _items);
  }

  /// Opens a color picker for customizing the dragging highlight color
  void _showColorPicker() async {
    if (!widget.enableColorPicker) return;

    Color newColor = await showDialog(
      context: context,
      builder: (context) => _ColorPickerDialog(initialColor: _selectedColor),
    );

    if (newColor != _selectedColor) {
      setState(() {
        _selectedColor = newColor;
      });
    }
  }

  /// Displays a snackbar with the given message
  void _showSnackbar(String message) {
    if (widget.enableSnackbar) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  /// Shows an undo snackbar to revert last reorder action
  void _showUndoSnackbar() {
    if (!widget.enableUndo || _previousOrder == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Order updated"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _items = List.from(_previousOrder!);
              widget.onReorder(_items);
              _saveOrder();
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// **Optional Color Picker Button**
        if (widget.enableColorPicker)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _showColorPicker,
              child: const Text("Select Drag Color"),
            ),
          ),
        Expanded(
          child: Container(
            color: widget.backgroundColor ?? Colors.grey[200],
            child: ReorderableListView(
              padding: const EdgeInsets.all(8.0),
              children: _items
                  .map(
                    (item) => AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      key: ValueKey(item),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: _draggingItem == item
                            ? _selectedColor
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          if (_draggingItem == item)
                            BoxShadow(
                              color: _selectedColor.withOpacity(0.8),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(item, style: const TextStyle(fontSize: 18)),
                        leading: ReorderableDragStartListener(
                          index: _items.indexOf(item),
                          child:
                              const Icon(Icons.drag_handle, color: Colors.grey),
                        ),
                        tileColor: Colors.white,
                        onLongPress: () {
                          setState(() {
                            _draggingItem = item;
                          });
                          HapticFeedback.mediumImpact();
                        },
                        onTap: () {
                          setState(() {
                            _draggingItem = null;
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
              onReorderStart: (index) {
                if (widget.enableUndo) {
                  setState(() {
                    _previousOrder = List.from(_items);
                  });
                }
              },
              onReorder: (oldIndex, newIndex) {
                setState(() {
                  _draggingItem = null;
                  if (newIndex > oldIndex) newIndex -= 1;
                  final String movedItem = _items.removeAt(oldIndex);
                  _items.insert(newIndex, movedItem);
                });
                widget.onReorder(List.from(_items));
                _saveOrder();
                _showUndoSnackbar();
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Color Picker Dialog for Selecting Drag Highlight Color
class _ColorPickerDialog extends StatelessWidget {
  final Color initialColor;

  const _ColorPickerDialog({Key? key, required this.initialColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color selectedColor = initialColor;

    return AlertDialog(
      title: const Text("Select Drag Color"),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: initialColor,
          onColorChanged: (color) {
            selectedColor = color;
          },
        ),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context, initialColor),
            child: const Text("Cancel")),
        TextButton(
            onPressed: () => Navigator.pop(context, selectedColor),
            child: const Text("Select")),
      ],
    );
  }
}
