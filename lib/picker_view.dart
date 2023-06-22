import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef PickerRowCallBack = int Function(int section);
typedef PickerItemBuilder = Widget Function(int section,int row);
typedef PickerVoidCallBack = void Function(int section, int row);

class PickerView extends StatefulWidget {
  
  final PickerRowCallBack numberofRowsAtSection;
  final PickerItemBuilder itemBuilder;
  final PickerVoidCallBack? onSelectRowChanged;
  final double? itemExtent;
  final PickerController controller;

  PickerView({
    required this.numberofRowsAtSection,
    required this.itemBuilder,
    required this.controller,
    this.itemExtent = 40,
    this.onSelectRowChanged,
  }) : super();

  @override
  State<StatefulWidget> createState() {
    return PickerViewState();
  }
}

class PickerViewState extends State<PickerView> {
  
  late PickerController _controller;
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void didUpdateWidget(PickerView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      _controller = widget.controller;
    }
  }
  
  @override
  void didChangeDependencies() {
    _controller = widget.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Container(
          color: Colors.white,
          child: Row(
            children: _buildPickers()
          )
        ),
    );
  }
  
  List<Widget> _buildPickers() {
    List<Widget> children = [];
    
    for (int section = 0; section < _controller.count; section++) {
      children.add(
        Expanded (flex: 1, child: _buildPickerItem (section: section))
      );
    }
    
    return children;
  }

  Widget _buildPickerItem({required int section}) {
  
    FixedExtentScrollController scrollController = _controller.scrollControllers[section];
    
    return Container(
      child: CupertinoPicker.builder(
        backgroundColor: Colors.white,
        scrollController: scrollController,
        diameterRatio: 1,
        itemExtent: widget.itemExtent ?? 40,
        childCount: widget.numberofRowsAtSection(section),
        onSelectedItemChanged: (row) {
          if(widget.onSelectRowChanged != null) {
            widget.onSelectRowChanged!(section, row);
          }
        },
        itemBuilder: (context,row) {
          return Container(
            alignment: Alignment.center,
            child: widget.itemBuilder(section,row)
          );
        },
      ),
    );
  }
}

class PickerController  {
  
  final int count;
  final List<FixedExtentScrollController> scrollControllers;

  PickerController({required this.count, List<int>? selectedItems}) :  scrollControllers = [] {
    for (int i = 0; i< count; i++) {
      if (selectedItems != null && i < selectedItems.length) {
        scrollControllers.add(FixedExtentScrollController(initialItem: selectedItems[i]));
      } else {
        scrollControllers.add(FixedExtentScrollController());
      }
    }
  }
  
  void dispose() {
    scrollControllers.forEach((item){
      item.dispose();
    });
  }
  
  int? selectedRowAt({required int section}) {
    try {
      FixedExtentScrollController scrollController = scrollControllers[section];
      if (scrollController != null) {
        return scrollController.selectedItem;
      } else {
        return null;
      }
    } catch(err) {
      return null;
    }
  }

  void jumpToRow(int row, {required int atSection}) {
    try {
      if (scrollControllers.length <= atSection) {
        return;
      }
      FixedExtentScrollController scrollController = scrollControllers[atSection];
      scrollController.jumpToItem(row);
    } catch(err) {
    
    }
  }

  Future<void> animateToRow(
      int row, {
      required int atSection,
      Duration duration = const Duration(milliseconds: 300),
      Curve curve = Curves.easeInOut,
  }) async {
    try {
      if (scrollControllers.length <= atSection) {
        return;
      }
      FixedExtentScrollController scrollController = scrollControllers[atSection];
      await scrollController.animateToItem(row, duration: duration, curve: curve);
    } catch(err) {
    
    }
  }
}