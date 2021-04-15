import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/tabViewMemo.dart';

class MemoByCategory extends StatefulWidget {
  final int category;
  MemoByCategory({this.category});

  @override
  _MemoByCategoryState createState() => _MemoByCategoryState();
}

class _MemoByCategoryState extends State<MemoByCategory> {
  List<Memo> memoList = List<Memo>();
  List<Category> categoryList = List<Category>();
  DbHelper dbHelper = DbHelper();
  int countMemo = 0;
  int countCategory = 0;

  @override
  void initState() {
    updateListViewCategory();
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
          getCategoryName(this.widget.category).toString(),
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
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: TabViewMemo(
                countMemo: countMemo,
                memoList: memoList,
                categoryList: categoryList,
                dbHelper: dbHelper,
              ),
            ),
          ],
        ),
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
              this.memoList = memoList;
              this.countMemo = memoList.length;
            },
          );
        });
      },
    );
  }

  //Memanggil data kategori untuk menyesuaikan antara nama kategori dengan id kategori memo
  void updateListViewCategory() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        //SELECT data category dari DB
        Future<List<Category>> categoryListFuture = dbHelper.getCategoryList();
        categoryListFuture.then((categoryList) {
          setState(
            () {
              this.categoryList = categoryList;
              this.countCategory = categoryList.length;
            },
          );
        });
      },
    );
  }

  /**
   * Tipe String yang digunakan untuk mengambil nama kategori yang memiliki parameter 
   * untuk menerima nilai yang dikirimkan oleh id kategori memo 
   */
  String getCategoryName(int categoryId) {
    for (Category c in categoryList) {
      if (c.id == this.widget.category) {
        return c.name;
      }
    }
  }
}
