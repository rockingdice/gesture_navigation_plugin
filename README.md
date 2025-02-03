
# Gesture Navigation

A brief description of what this project does and who 
Flutter Package for Gesture-Based Navigation

gesture_navigation enhances user experience by providing gesture-based navigation and controls for Flutter apps. This package supports:

✔ Edge Swipe Gestures (Left & Right)\
✔ Pinch-to-Zoom with Panning & Rotation\
✔ Drag & Drop Reordering\
✔ Swipe Navigation between Pages\
✔ Modal Control with Swipe Up/Down to Dismiss\
✔ Customizable Gesture Sensitivity & Feedback

This package enables smooth and intuitive interactions, making your app more engaging.

Features:\
✅ Edge Gestures – Detect left and right edge swipes.\
✅ Pinch Zoom – Enables zoom, panning, and rotation on widgets.\
✅ Reorderable Drag & Drop List – Users can reorder items seamlessly.\
✅ Swipe Navigation – Swipe between pages with smooth transitions.\
✅ Modal Swipe Control – Swipe up/down to open/dismiss modals.\
✅ Customizable Feedback – Toggle haptic feedback and snackbar notifications.\
✅ Optimized Performance – Built for responsiveness & efficiency.



## Installation:
To use this package, add the following dependency to your pubspec.yaml:
```
dependencies:
  gesture_navigation: ^0.0.3
```


https://github.com/user-attachments/assets/7965c924-5d71-4faa-9fd9-ce1d30708ce4


## Drag & Drop Reordering:
```
DragReorder(
  items: items,
  onReorder: updateOrder,
  enableUndo: true,
  enableSnackbar: true,
  enableColorPicker: true,
  saveOrder: true,
  backgroundColor: Colors.deepPurple[50],
),

```


https://github.com/user-attachments/assets/74a968e1-8d2e-4053-80e2-00f7b90f75a0


## Swipe Navigation:
```
SwipeNavigation(
  onSwipeLeft: () {
    Navigator.push(
      context,
      createPageTransition(NextPage(), SwipeTransitionType.scale),
    );
  },
  onSwipeRight: () {
    Navigator.pop(context);
  },
  child: Scaffold(
    body: Center(child: Text("Swipe Left/Right to Navigate")),
  ),
),
```


https://github.com/user-attachments/assets/9b25aa59-8df4-40cc-b725-560ec5fd7866


## Edge Gesture (Left & Right Swipe):
```
EdgeGesture(
  onSwipeLeftEdge: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Swiped from Left Edge!")),
    );
  },
  onSwipeRightEdge: () {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Swiped from Right Edge!")),
    );
  },
  enableHapticFeedback: true,
  child: Center(child: Text("Swipe from the left or right edge")),
),
```


https://github.com/user-attachments/assets/bc484fe8-e58c-4cff-b48f-d023171cd3a6


## Pinch-to-Zoom with Panning & Rotation:
```
PinchZoom(
  allowRotation: true,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Image.asset('assets/sample_image.jpg', width: 250),
  ),
),


```

https://github.com/user-attachments/assets/a5efd007-cafb-48be-8938-784298e2005f


## Modal Swipe Control:
```

ElevatedButton(
  onPressed: () => showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (_) => ModalControl(
      onSwipeDown: () => Navigator.pop(context),
      child: Container(
        height: 300,
        color: Colors.white,
        alignment: Alignment.center,
        child: Text("Swipe Down to Close", style: TextStyle(fontSize: 18)),
      ),
    ),
  ),
  child: Text("Open Modal"),
),
```

## Authors

- [@SufiyanRazaq](https://github.com/SufiyanRazaq/gesture_navigation_plugin)

