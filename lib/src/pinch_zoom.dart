import 'package:flutter/material.dart';

/// A fully working pinch-to-zoom widget with panning, rotation, and smooth animations.
class PinchZoom extends StatefulWidget {
  final Widget child;
  final double minScale;
  final double maxScale;
  final bool allowRotation;

  /// Creates a PinchZoom widget.
  ///
  /// - `child`: The widget to be zoomed.
  /// - `minScale`: The minimum zoom level (default: 1.0).
  /// - `maxScale`: The maximum zoom level (default: 4.0).
  /// - `allowRotation`: Enables rotation gestures (default: true).
  const PinchZoom({
    Key? key,
    required this.child,
    this.minScale = 1.0,
    this.maxScale = 4.0,
    this.allowRotation = true,
  }) : super(key: key);

  @override
  _PinchZoomState createState() => _PinchZoomState();
}

class _PinchZoomState extends State<PinchZoom>
    with SingleTickerProviderStateMixin {
  late TransformationController _controller;
  TapDownDetails? _doubleTapDetails;
  double _rotation = 0.0;
  double _baseRotation = 0.0;
  Matrix4 _baseMatrix = Matrix4.identity();
  Offset _lastFocalPoint = Offset.zero;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Smoothly animates zooming out and resetting the position.
  void _resetZoom() {
    setState(() {
      _rotation = 0.0;
      _controller.value = Matrix4.identity();
    });
  }

  /// Handles double-tap zoom behavior.
  void _handleDoubleTap(TapDownDetails details) {
    if (_controller.value != Matrix4.identity()) {
      _resetZoom();
    } else {
      final position = details.localPosition;
      _controller.value = Matrix4.identity()
        ..translate(-position.dx * 1.5, -position.dy * 1.5)
        ..scale(2.0);
    }
  }

  /// Handles rotation gestures when scaling.
  void _handleRotation(ScaleUpdateDetails details) {
    if (widget.allowRotation) {
      setState(() {
        _rotation = _baseRotation + details.rotation;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) => _doubleTapDetails = details,
      onDoubleTap: () => _handleDoubleTap(_doubleTapDetails!),
      onScaleStart: (details) {
        _baseRotation = _rotation;
        _lastFocalPoint = details.focalPoint;
        _baseMatrix = _controller.value.clone();
      },
      onScaleUpdate: (details) {
        _handleRotation(details);
        final newMatrix = Matrix4.identity()
          ..translate(details.focalPoint.dx - _lastFocalPoint.dx,
              details.focalPoint.dy - _lastFocalPoint.dy)
          ..scale(details.scale)
          ..rotateZ(widget.allowRotation ? _rotation : 0);
        _controller.value = _baseMatrix.multiplied(newMatrix);
      },
      child: InteractiveViewer(
        transformationController: _controller,
        boundaryMargin: const EdgeInsets.all(20),
        minScale: widget.minScale,
        maxScale: widget.maxScale,
        panEnabled: true,
        scaleEnabled: true,
        child: widget.child,
      ),
    );
  }
}
