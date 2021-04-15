import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/detailMemo.dart';

class TabViewMemo extends StatelessWidget {
  const TabViewMemo({
    Key key,
    @required this.countMemo,
    @required this.memoList,
    @required this.categoryList,
    @required this.dbHelper,
    @required this.updateListViewMemo,
    @required this.navigateToEntryFormMemo,
  }) : super(key: key);

  final int countMemo;
  final List<Memo> memoList;
  final List<Category> categoryList;
  final DbHelper dbHelper;
  final Function updateListViewMemo;
  final Function navigateToEntryFormMemo;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
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
                  color: memoColors[(index % memoColors.length).floor()],
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                color: Color.fromRGBO(255, 255, 255, 0.38)),
                            child: InkWell(
                              onTap: () async {
                                var memoItem = await navigateToEntryFormMemo(
                                    context, this.memoList[index]);

                                dbHelper.updateMemo(memoItem);
                                updateListViewMemo();
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                    bottomLeft: Radius.circular(30),
                                    bottomRight: Radius.circular(30)),
                                color: Color.fromRGBO(255, 255, 255, 0.38)),
                            child: InkWell(
                              onTap: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                            "Are you sure to delete this memo?"),
                                        actions: [
                                          //BUTTON "Yes"
                                          MaterialButton(
                                            color: memoColors[
                                                (index % memoColors.length)
                                                    .floor()],
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              dbHelper.deleteMemo(
                                                  this.memoList[index].id);

                                              Navigator.of(context).pop();
                                              updateListViewMemo();
                                            },
                                          ),

                                          //BUTTON "Cancel"
                                          MaterialButton(
                                            color: memoColors[
                                                (index % memoColors.length)
                                                    .floor()],
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 8.0, bottom: 25.0, left: 8.0, right: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                            style: TextStyle(fontSize: 13, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            '[ ' +
                                getCategoryName(
                                    this.memoList[index].categoryId) +
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
    );
  }

  String getCategoryName(int categoryId) {
    for (Category c in categoryList) {
      if (c.id == categoryId) {
        return c.name;
      }
    }
  }
}
