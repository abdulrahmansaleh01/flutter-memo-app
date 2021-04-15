import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/detailMemo.dart';

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
    updateListViewMemoByCategory();
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
      body: memoList.length > 0
          ? Container(
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: StaggeredGridView.countBuilder(
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      itemCount: countMemo,
                      itemBuilder: (BuildContext context, int index) {
                        final descMemoText = this.memoList[index].description;
                        return InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  topLeft: Radius.circular(30),
                                ),
                              ),
                              builder: (BuildContext bc) {
                                return ShowDetailMemo(
                                    memoList: memoList,
                                    index: index,
                                    getCategoryName: getCategoryName);
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              padding: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                  color: memoColors[
                                      (index % memoColors.length).floor()],
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Text(
                                            this.memoList[index].title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                                color: Colors.white),
                                            // style: Theme.of(context).textTheme.body1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 25.0, right: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            /**
                                     * Membatasi jumlah karakter huruf(substring) dari isi deskripsi ketika melebihi dari 100,
                                     * maka karakter selanjutnya akan direplace dengan (...)
                                     */
                                            descMemoText.length > 100
                                                ? '${descMemoText.substring(0, 100)}...'
                                                : descMemoText,
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Expanded(
                                          child: Text(
                                            '[ ' +
                                                getCategoryName(this
                                                    .memoList[index]
                                                    .categoryId) +
                                                ' ]',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          this.memoList[index].date,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white,
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ])
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 17),
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/memo-icon.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("No memo yet :(",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                          color: Colors.grey[850]))
                ],
              ),
            ),
    );
  }

  void updateListViewMemoByCategory() {
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
