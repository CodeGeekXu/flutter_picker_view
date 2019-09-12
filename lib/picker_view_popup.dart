import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'picker_view.dart';

typedef PickerViewBuilder = Widget Function(BuildContext context, PickerViewPopup pickerViewPopup);

enum PickerShowMode {
  AlertDialog,
  BottomSheet
}

class PickerViewPopup extends StatelessWidget {
  
  final PickerRowCallBack numberofRowsAtSection;
  final PickerItemBuilder itemBuilder;
  final PickerVoidCallBack onSelectRowChanged;
  final ValueChanged<PickerController> onConfirm;
  final VoidCallback onCancel;
  final PickerController controller;
  final double itemExtent;
  final Widget cancel;
  final Widget confirm;
  final PickerShowMode mode;
  final Widget title;

  PickerViewPopup._({
    @required this.numberofRowsAtSection,
    @required this.itemBuilder,
    @required this.controller,
    this.mode = PickerShowMode.BottomSheet,
    this.itemExtent,
    this.onSelectRowChanged,
    this.title,
    this.cancel,
    this.onCancel,
    this.confirm,
    this.onConfirm,
  }) : super();
  
  static Future<T> showMode<T>(PickerShowMode mode,{
    @required BuildContext context,
    @required PickerViewBuilder builder,
    @required PickerController controller,
    @required PickerRowCallBack numberofRowsAtSection,
    @required PickerItemBuilder itemBuilder,
    PickerVoidCallBack onSelectRowChanged,
    double itemExtent,
    Widget title,
    Widget cancel,
    VoidCallback onCancel,
    Widget confirm,
    ValueChanged<PickerController> onConfirm,
  }) {
    PickerViewPopup pickerView = PickerViewPopup._(
      numberofRowsAtSection: numberofRowsAtSection,
      itemBuilder: itemBuilder,
      controller: controller,
      itemExtent: itemExtent,
      onSelectRowChanged: onSelectRowChanged,
      mode: mode,
      title: title,
      cancel: cancel,
      onCancel: () {
        Navigator.of(context).pop();
        if (onCancel != null) onCancel();
      },
      confirm: confirm,
      onConfirm: (controller) {
        Navigator.of(context).pop();
        if (onConfirm != null) onConfirm(controller);
      },
    );

    if (mode == PickerShowMode.AlertDialog) {
      return showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: title,
            content: builder(context, pickerView),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  if (onCancel != null) onCancel();
                },
                child: cancel ?? Text('取消',style: TextStyle(color: Colors.grey))),
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  if (onConfirm != null) {
                    onConfirm(controller);
                  }
                },
                child: confirm ?? Text('确定',style: TextStyle(color: Theme.of(context).accentColor)))
            ],
          );
        });
    } else {
      return showModalBottomSheet(
        context: context,
        builder: (context) {
          return builder(context, pickerView);
        }
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {

    if (mode == PickerShowMode.AlertDialog) {
      return _buildDialogContent(context);
    } else {
      return _buildBottomSheetContent(context);
    }
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(height: 200),
      child: PickerView(
        numberofRowsAtSection: numberofRowsAtSection,
        itemBuilder: itemBuilder,
        controller: controller,
        onSelectRowChanged: onSelectRowChanged,
        itemExtent: itemExtent,
      )
    );
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tightFor(height: 280),
      child: Column(
        children: <Widget>[
          _buildToolBar(context),
          Expanded(
            child: PickerView(
              numberofRowsAtSection: numberofRowsAtSection,
              itemBuilder: itemBuilder,
              controller: controller,
              onSelectRowChanged: onSelectRowChanged,
              itemExtent: itemExtent,
            ),
          )
        ],
      ),
    );
  }
  
  Widget _buildToolBar(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildInkWellButton(
            child: cancel ?? Text('取消',style: TextStyle(color: Colors.grey)),
            onTap: onCancel
          ),
          Expanded(
            child: Offstage(
              offstage: title == null,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: title,
              ),
            ),
          ),
          _buildInkWellButton(
            child: confirm ?? Text('确定',style: TextStyle(color: Theme.of(context).accentColor)),
            onTap: () {
              if(onConfirm != null) {
                onConfirm(controller);
              }
            }
          ),
        ],
      ),
    );
  }
  
  Widget _buildInkWellButton({
    Widget child,
    VoidCallback onTap
  }) {
    return Material(
      child: InkWell(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: child,
        ),
        onTap: onTap,
      ),
    );
  }
}
