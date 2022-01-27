import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todos/data/models/todo_models.dart';
import 'package:todos/data/storage/db_helper.dart';

class ListTileItem extends StatefulWidget {
  final TodoModels product;
  ListTileItem({this.product});
  @override
  _ListTileItemState createState() => new _ListTileItemState();
}

class _ListTileItemState extends State<ListTileItem> {
  int _itemCount = 0;
  List<int> value = [];

  @override
  void initState() {
    super.initState();
  }

  increment() {
    
    setState(() {
      _itemCount++;
      addItem(
        widget.product.userId,
        widget.product.id,
        widget.product.title,
        _itemCount,
      );
    });
  }

  Future<Null> addItem(int userId, int id, String name, int qty) async {
    await DatabaseHelper()
        .insert(TodoModels(userId: userId, id: id, title: name, qty: qty));
  }

  decrement() {
    setState(() {
      _itemCount--;
      addItem(
        widget.product.userId,
        widget.product.id,
        widget.product.title,
        _itemCount,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Row(
      children: <Widget>[
        _itemCount != 0
            ? IconButton(icon: new Icon(Icons.remove), onPressed: decrement)
            : Container(),
        Text(_itemCount.toString()),
        IconButton(icon: new Icon(Icons.add), onPressed: increment)
      ],
    );
  }
}
