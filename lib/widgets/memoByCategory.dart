import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/pages/entryform_memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/tabViewMemo.dart';

class MemoByCategory extends StatefulWidget {
  final int category;
  MemoByCategory({this.category});

  @override
  _MemoByCategoryState createState() => _MemoByCategoryState();
}

class _MemoByCategoryState extends State<MemoByCategory> {
  List<Memo> _memoList = List<Memo>();
  DbHelper dbHelper = DbHelper();
  int countMemo = 0;

  @override
  void initState() {
    updateListViewMemoCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "My Memo",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.black,
              size: 33,
            ),
          ),
        ],
        // leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: TabViewMemo(
              countMemo: countMemo,
              memoList: _memoList,
              dbHelper: dbHelper,
            ),
          ),
        ],
      ),
    );
  }

  void updateListViewMemoCategory() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        //SELECT data memo dari berdasarkan kategori dengan mengirimkan categoryId
        Future<List<Memo>> memoListFuture =
            dbHelper.getMemoListByCategory(this.widget.category);
        memoListFuture.then((memoList) {
          setState(
            () {
              this._memoList = memoList;
              this.countMemo = memoList.length;
            },
          );
        });
      },
    );
  }
}
