import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/pages/entryform_category.dart';
import 'package:uts_aplikasi_catatan_memo/pages/entryform_memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/tabViewMemo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/tabviewCategory.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int indexTab = 0;
  TabController _tabController;

  DbHelper dbHelper = DbHelper();
  List<Category> categoryList;
  int countCategory = 0;

  List<Memo> memoList;
  int countMemo = 0;

  void initState() {
    // TODO: implement initState
    _tabController = new TabController(length: 2, vsync: this, initialIndex: 0)
      ..addListener(() {});
    updateListViewCategory();
    updateListViewMemo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (memoList == null || categoryList == null) {
      memoList = List<Memo>();
      categoryList = List<Category>();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "My Memo",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.black,
              size: 33,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 35, top: 15, bottom: 15),
            height: 100,
            width: double.infinity,
            child: Row(
              children: [
                Image(
                    image:
                        // NetworkImage(
                        //     'https://iconfair.com/cepsools/2020/11/Artboard-30-10.png'),
                        NetworkImage(
                            'https://cdn.pixabay.com/photo/2016/10/06/19/02/clipboard-1719736_960_720.png')
                    //
                    ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hi !",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Make your day enjoy by making reminders :)",
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200],
            ),
            child: TabBar(
              isScrollable: true,
              indicatorPadding: EdgeInsets.all(10),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blue[400],
              labelStyle: TextStyle(fontSize: 20),
              labelPadding:
                  EdgeInsets.only(left: 35, right: 35, top: 12, bottom: 12),
              indicator: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(20)),
              controller: _tabController,
              indicatorColor: Color(0xFF417BFB),
              onTap: (index) {
                setState(() {
                  indexTab = index;
                });
              },
              tabs: [
                Text("Your Memo"),
                Text("Category"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // TAB VIEW MEMO
                TabViewMemo(
                    countMemo: countMemo,
                    memoList: memoList,
                    dbHelper: dbHelper,
                    updateListViewMemo: updateListViewMemo,
                    navigateToEntryFormMemo: navigateToEntryFormMemo),

                // TAB VIEW CATEGORY MEMO
                TabViewCategory(
                    countCategory: countCategory,
                    categoryList: categoryList,
                    dbHelper: dbHelper,
                    updateListViewCategory: updateListViewCategory,
                    updateListViewMemo: updateListViewMemo,
                    navigateToEntryFormCategory: navigateToEntryFormCategory),
              ],
            ),
          )
        ],
      ),
      floatingActionButton: _bottomButtons(),
    );
  }

  Widget _bottomButtons() {
    return indexTab == 0
        ? FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: () async {
              var memo = await navigateToEntryFormMemo(context, null);
              if (memo != null) {
                //Memanggil Fungsi untuk Insert ke DB
                int result = await dbHelper.insertMemo(memo);
                if (result > 0) {
                  updateListViewMemo();
                }
              }
            },
            backgroundColor: Colors.blue[400],
            child: Icon(Icons.post_add_sharp),
          )
        : FloatingActionButton(
            shape: StadiumBorder(),
            onPressed: () async {
              var category = await navigateToEntryFormCategory(context, null);
              if (category != null) {
                //Memanggil Fungsi untuk Insert ke DB
                int result = await dbHelper.insertCategory(category);
                if (result > 0) {
                  updateListViewCategory();
                }
              }
            },
            backgroundColor: Colors.blue[400],
            child: Icon(
              Icons.add,
            ),
          );
  }

//------------------ CATEGORY MEMO ---------------------
  Future<Category> navigateToEntryFormCategory(
      BuildContext context, Category category) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryCategory(category);
        },
      ),
    );
    return result;
  }

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

  //----------------------- MEMO --------------------------
  Future<Memo> navigateToEntryFormMemo(BuildContext context, Memo memo) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return EntryMemo(memo);
        },
      ),
    );
    return result;
  }

  void updateListViewMemo() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then(
      (database) {
        //SELECT data memo dari DB
        Future<List<Memo>> memoListFuture = dbHelper.getMemoList();
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
}
