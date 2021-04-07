import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';

class DropdownCategory extends StatefulWidget {
  List<Category> category;

  Function callback;

  DropdownCategory(
    this.category,
    this.callback, {
    Key key,
  }) : super(key: key);

  @override
  _DropdownCategoryState createState() => _DropdownCategoryState();
}

class _DropdownCategoryState extends State<DropdownCategory> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
        hint: Text('Select category'),
        onChanged: (Category value) {
          setState(() {
            widget.callback(value);
          });
        },
        items: widget.category.map((category) {
          return DropdownMenuItem(
            value: category,
            child: Text(category.name),
          );
        }).toList());
  }
}
