import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/memoByCategory.dart';

class TabViewCategory extends StatelessWidget {
  const TabViewCategory(
      {Key key,
      @required this.countCategory,
      @required this.categoryList,
      @required this.dbHelper,
      @required this.updateListViewCategory,
      @required this.updateListViewMemo,
      @required this.navigateToEntryFormCategory})
      : super(key: key);

  final int countCategory;
  final List<Category> categoryList;
  final DbHelper dbHelper;
  final Function updateListViewCategory;
  final Function updateListViewMemo;
  final Function navigateToEntryFormCategory;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: countCategory,
      itemBuilder: (BuildContext context, int index) {
        return Dismissible(
          key: new Key(categoryList[index].name),
          onDismissed: (direction) {
            // Menghapus data category dari tabel
            dbHelper.deleteCategory(this.categoryList[index].id);
            //Ketika Kategorinya dihapus, maka memo yang bersangkutan dengan kategori tersebut akan dihapus juga
            dbHelper.deleteMemoByCategory(this.categoryList[index].id);
            updateListViewCategory();
            updateListViewMemo();
            // Menampilkan snackbar.
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Category Item deleted")));
          },
          // Menampilkan background saat item telah di-swipe (hapus).
          background: Container(
            color: categoryColors[(index % categoryColors.length).floor()],
            margin: EdgeInsets.only(top: 10, bottom: 10),
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
            //menavigasi ke halaman memo berdasarkan kategori dengan mengirimkan nilai id kategori
            onTap: () => Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) =>
                        new MemoByCategory(category: categoryList[index].id))),
            child: Container(
              height: 80,
              margin: EdgeInsets.only(top: 8, left: 10, right: 10, bottom: 10),
              // color: Colors.white,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
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
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: categoryColors[
                                  (index % categoryColors.length).floor()],
                              width: 4),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            "Tap for show memos",
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
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  "Category",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: Container(
                                  height: 290.0,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Name:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: categoryColors[
                                                (index % categoryColors.length)
                                                    .floor()],
                                            border: Border.all(
                                                width: 2, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        margin: EdgeInsets.only(
                                            top: 5, bottom: 20.0),
                                        child: TextField(
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            // labelText: 'Category Name',
                                            hintText:
                                                this.categoryList[index].name,
                                            hintStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.view_list_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "Description:",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 5.0),
                                        decoration: BoxDecoration(
                                            color: categoryColors[
                                                (index % categoryColors.length)
                                                    .floor()],
                                            border: Border.all(
                                                width: 2, color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        child: TextField(
                                          enabled: false,
                                          keyboardType: TextInputType.text,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            // labelText: 'Description',
                                            hintText: this
                                                .categoryList[index]
                                                .description,
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
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
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        side: BorderSide(
                                            color: Colors.black, width: 2.0)),
                                    color: categoryColors[
                                        (index % categoryColors.length)
                                            .floor()],
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
                        child: Icon(
                          Icons.remove_red_eye_outlined,
                          color: categoryColors[
                              (index % categoryColors.length).floor()],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          var categoryItem = await navigateToEntryFormCategory(
                              context, this.categoryList[index]);

                          dbHelper.updateCategory(categoryItem);
                          updateListViewCategory();
                        },
                        child: Icon(
                          Icons.edit_outlined,
                          color: categoryColors[
                              (index % categoryColors.length).floor()],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        color: categoryColors[
                            (index % categoryColors.length).floor()],
                        height: double.infinity,
                        width: 10,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
