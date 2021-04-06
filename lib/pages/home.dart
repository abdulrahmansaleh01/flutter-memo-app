import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/pages/entryform_category.dart';
import 'package:uts_aplikasi_catatan_memo/pages/entryform_memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                        // NetworkImage('https://iconfair.com/cepsools/2020/11/Artboard-30-10.png'),
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
                Center(
                  child: Text("List Memo"),
                ),

                // TAB VIEW CATEGORY MEMO
                ListView.builder(
                  itemCount: countCategory,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      key: new Key(categoryList[index].name),
                      onDismissed: (direction) {
                        // Menghapus data category dari tabel
                        dbHelper.deleteCategory(this.categoryList[index].id);
                        updateListViewCategory();

                        // Menampilkan snackbar.
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Category Item deleted")));
                      },
                      // Menampilkan background saat item telah di-swipe (hapus).
                      background: Container(
                        color: categoryColors[
                            (index % categoryColors.length).floor()],
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Category"),
                                content: Container(
                                  height: 290.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("Name:"),
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: 5, bottom: 20.0),
                                        child: TextField(
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            // labelText: 'Category Name',
                                            hintText:
                                                this.categoryList[index].name,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.view_list_outlined),
                                          ),
                                        ),
                                      ),
                                      Text("Description:"),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0),
                                        child: TextField(
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          maxLength: 200,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            // labelText: 'Description',
                                            hintText: this
                                                .categoryList[index]
                                                .description,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  MaterialButton(
                                    color: Colors.blue[400],
                                    textColor: Colors.white,
                                    elevation: 5.0,
                                    child: Text("OK"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          );
                        },
                        child: Container(
                          height: 80,
                          margin: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          // color: Colors.white,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                offset: Offset(0, 9),
                                blurRadius: 20,
                                spreadRadius: 1)
                          ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: categoryColors[
                                              (index % categoryColors.length)
                                                  .floor()],
                                          width: 4),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        this.categoryList[index].name,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        "Tap for show detail",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      var categoryItem =
                                          await navigateToEntryFormCategory(
                                              context,
                                              this.categoryList[index]);

                                      dbHelper.updateCategory(categoryItem);
                                      updateListViewCategory();
                                    },
                                    child: Icon(Icons.edit_outlined),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    color: categoryColors[
                                        (index % categoryColors.length)
                                            .floor()],
                                    height: double.infinity,
                                    width: 4,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
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
