import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_picker_view/flutter_picker_view.dart';

class CustomPickerView extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return CustomPickerViewState();
  }
}

class CustomPickerViewState extends State<CustomPickerView> {
  
  PickerController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = PickerController(count: 2, selectedItems: []);
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text('CustomPickerView'),),
      body: Container(
        height: 250,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black.withAlpha(20))
        ),
        child: Column(
          children: <Widget>[
            _PickerToolBar(),
            Container(
              height: 150,
              child: PickerView(
                numberofRowsAtSection: (section) {
                  return 10;
                },
                itemBuilder: (section, row) {
                  return Text('$row',style: TextStyle(fontSize: 14),);
                },
                controller: _controller
              ),
            )
          ],
        ),
      )
    );
  }
  
  Widget _PickerToolBar() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 30),
      child: Row(
        children: <Widget>[
          _PickerControl(
            controller: TextEditingController(),
            onDone: (index) {
              _controller.animateToRow(index, atSection: 0);
            }
          ),
          _PickerControl(
            controller: TextEditingController(),
            onDone: (index) {
              _controller.animateToRow(index, atSection: 1);
            }
          ),
        ],
      ),
    );
  }
  
  Widget _PickerControl({TextEditingController controller, ValueChanged<int> onDone}) {
    return  Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: CupertinoTextField(
                controller: controller,
                keyboardType: TextInputType.number,
                placeholder: '请输入',
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                style: TextStyle(fontSize: 14),
              ),
            ),
            InkWell(
              onTap: (){
                if (onDone != null) {
                  String text = controller.text;
                  onDone(int.parse(text));
                  controller.clear();
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 30,
                padding: EdgeInsets.symmetric(horizontal: 10),
                color: Colors.blue,
                child: Text('Go', style: TextStyle(color: Colors.white),),
              )
            )
          ],
        )
      )
    );
  }
}