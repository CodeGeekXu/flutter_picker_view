# flutter_picker_view

A  Flutter picker view like iOS UIPickerView support multiple pickers

## Getting Started

First, add flutter_picker_view as a dependency in your pubspec.yaml file.

## Demo
![image](https://github.com/CodeGeekXu/flutter_picker_view/blob/master/flutter_picker_view.gif)

## Example
```dart
import 'package:flutter_picker_view/flutter_picker_view.dart';
```

```dart
enum PickerShowMode {
    AlertDialog,
    BottomSheet
}
```
### AlertDialog
![image](https://github.com/CodeGeekXu/flutter_picker_view/blob/master/alert_dialog.jpeg)

### BottomSheet
![image](https://github.com/CodeGeekXu/flutter_picker_view/blob/master/bottom_sheet.jpeg)

```dart
void _showPicker() {
    PickerController pickerController = PickerController(count: 3, selectedItems: [5,2,1]);
    
    PickerViewPopup.showMode(
        PickerShowMode.AlertDialog, // AlertDialog or BottomSheet
        controller: pickerController,
        context: context,
        title: Text('AlertDialogPicker',style: TextStyle(fontSize: 14),),
        cancel: Text('cancel', style: TextStyle(color: Colors.grey),),
        onCancel: () {
            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('AlertDialogPicker.cancel'))
            );
        },
        confirm: Text('confirm', style: TextStyle(color: Colors.blue),),
        onConfirm: (controller) {
            List<int> selectedItems = [];
            selectedItems.add(controller.selectedRowAt(section: 0));
            selectedItems.add(controller.selectedRowAt(section: 1));
            selectedItems.add(controller.selectedRowAt(section: 2));

            Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('AlertDialogPicker.selected:$selectedItems'))
            );
        },
        builder: (context, popup) {
            return Container(
                height: 150,
                child: popup,
            );
        },
        itemExtent: 40,
        numberofRowsAtSection: (section) {
            return 10;
        },
        itemBuilder: (section, row) {
            return Text('$row',style: TextStyle(fontSize: 12),);
        }
    );
}
```

### Custom PickerView
![image](https://github.com/CodeGeekXu/flutter_picker_view/blob/master/custom.jpeg)

```dart

PickerController controller = PickerController(count: 2);

PickerView(
    itemExtent: 40,
    numberofRowsAtSection: (section) {
        return 10;
    },
    itemBuilder: (section, row) {
        if (0 == section) {
            return Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('$row',style: TextStyle(fontSize: 14),),
                        Icon(Icons.face)
                    ],
                ),
            );
        } else {
            return Padding(
                padding: EdgeInsets.only(right: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Text('$row',style: TextStyle(fontSize: 14),),
                        Icon(Icons.thumb_up)
                    ],
                )
            );
        }
    },
    controller: controller
)
```

