import 'package:flutter/material.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';
import 'custom_picker_view.dart';

class ExamplePage extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return ExamplePageState();
  }
}

class ExamplePageState extends State<ExamplePage> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('flutter picker view'),),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _Button(
              title: 'AlertDialogPicker',
              onPressed: () {
                _showDialogPicker();
              }
            ),
            _Button(
              title: 'BottomSheetPicker',
              onPressed: () {
                _showBottomSheetPicekr();
              }
            ),
            _Button(
              title: 'CustomPicker',
              onPressed: () {
                _showCustomPicker();
              }
            )
          ],
        ),
      ),
    );
  }
  
  Widget _Button({String title, VoidCallback onPressed}) {
    return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: FlatButton(
        color: Colors.blue,
        onPressed: onPressed,
        child: Text(title, style: TextStyle(color: Colors.white),)
      ),
    );
  }
  
  void _showDialogPicker() {
    
    PickerController pickerController = PickerController(count: 3, selectedItems: [5,2,1]);
    
    PickerViewPopup.showMode(
      PickerShowMode.AlertDialog,
      controller: pickerController,
      context: context,
      title: Text('alert dialog',style: TextStyle(fontSize: 14),),
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
          height: 280,
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
  
  void _showBottomSheetPicekr() {
    PickerController pickerController = PickerController(count: 3, selectedItems: [5,2,1]);
  
    PickerViewPopup.showMode(
      PickerShowMode.BottomSheet,
      controller: pickerController,
      context: context,
      title: Text('bottom sheet',style: TextStyle(fontSize: 14),),
      cancel: Text('cancel', style: TextStyle(color: Colors.grey),),
      onCancel: () {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('BottomSheetPicker.cancel'))
        );
      },
      confirm: Text('confirm', style: TextStyle(color: Colors.blue),),
      onConfirm: (controller) {
        List<int> selectedItems = [];
        selectedItems.add(controller.selectedRowAt(section: 0));
        selectedItems.add(controller.selectedRowAt(section: 1));
        selectedItems.add(controller.selectedRowAt(section: 2));
        
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text('BottomSheetPicker.selected:$selectedItems'))
        );
      },
      builder: (context, popup) {
        return Container(
          height: 250,
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
  
  void _showCustomPicker() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> CustomPickerView()));
  }
}