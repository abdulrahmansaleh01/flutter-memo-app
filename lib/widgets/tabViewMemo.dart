import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/detailMemo.dart';

class TabViewMemo extends StatelessWidget {
  const TabViewMemo({
    Key key,
    @required this.countMemo,
    @required this.memoList,
    @required this.dbHelper,
    @required this.updateListViewMemo,
    @required this.navigateToEntryFormMemo,
  }) : super(key: key);

  final int countMemo;
  final List<Memo> memoList;
  final DbHelper dbHelper;
  final Function updateListViewMemo;
  final Function navigateToEntryFormMemo;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
      child: GridView.builder(
        itemCount: countMemo,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          final descMemoText = this.memoList[index].description;
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: memoColors[(index % memoColors.length).floor()],
            child: InkWell(
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
                    );
                  },
                );
                // DetailMemo(context, index);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(bottom: 7),
                            child: Text(
                              "Kategori",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                        Container(
                          width: 90,
                          margin: EdgeInsets.only(bottom: 7),
                          padding: EdgeInsets.only(
                              left: 10, right: 10, top: 5, bottom: 5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30)),
                              color: Color.fromRGBO(255, 255, 255, 0.38)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () async {
                                  var memoItem = await navigateToEntryFormMemo(
                                      context, this.memoList[index]);

                                  dbHelper.updateMemo(memoItem);
                                  updateListViewMemo();
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 27,
                                ),
                              ),
                              InkWell(
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
                                  size: 27,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.memoList[index].title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          /**
                           * Membatasi jumlah karakter huruf(substring) dari isi deskripsi ketika melebihi dari 100,
                           * maka karakter selanjutnya akan direplace dengan (...)
                           */
                          descMemoText.length > 100
                              ? '${descMemoText.substring(0, 100)}...'
                              : descMemoText,
                          style: TextStyle(fontSize: 13, color: Colors.white),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 10, bottom: 10),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          this.memoList[index].date,
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Future DetailMemo(BuildContext context, int index) {
  //   return showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.only(
  //         topRight: Radius.circular(30),
  //         topLeft: Radius.circular(30),
  //       ),
  //     ),
  //     builder: (BuildContext bc) {
  //       return Padding(
  //         padding: EdgeInsets.only(left: 25, right: 25),
  //         child: Container(
  //           child: SingleChildScrollView(
  //             child: ConstrainedBox(
  //               constraints: BoxConstraints(
  //                 minHeight: (MediaQuery.of(context).size.height),
  //               ),
  //               child: Padding(
  //                 padding: EdgeInsets.only(bottom: 250, top: 50),
  //                 child: new Column(
  //                   children: <Widget>[
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                       children: [
  //                         Text(
  //                           "Detail Memo",
  //                           style: TextStyle(
  //                             fontSize: 20.00,
  //                             fontWeight: FontWeight.w500,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                     Divider(
  //                       color: memoColors[(index % memoColors.length).floor()],
  //                       thickness: 2.5,
  //                     ),
  //                     SizedBox(
  //                       height: 20,
  //                     ),
  //                     Column(
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: [
  //                         Text(
  //                           "Title:",
  //                           style: TextStyle(fontWeight: FontWeight.w500),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(top: 5, bottom: 20.0),
  //                           child: TextField(
  //                             enabled: false,
  //                             keyboardType: TextInputType.text,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             decoration: InputDecoration(
  //                               hintText: this.memoList[index].title,
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5.0),
  //                               ),
  //                               prefixIcon: Icon(
  //                                 Icons.text_fields,
  //                                 color: memoColors[
  //                                     (index % memoColors.length).floor()],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Text(
  //                           "Date:",
  //                           style: TextStyle(fontWeight: FontWeight.w500),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(top: 5, bottom: 20.0),
  //                           child: TextField(
  //                             enabled: false,
  //                             keyboardType: TextInputType.text,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             decoration: InputDecoration(
  //                               // labelText: 'Category Name',
  //                               hintText: this.memoList[index].date,
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5.0),
  //                               ),
  //                               prefixIcon: Icon(
  //                                 Icons.date_range,
  //                                 color: memoColors[
  //                                     (index % memoColors.length).floor()],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Text(
  //                           "Category:",
  //                           style: TextStyle(fontWeight: FontWeight.w500),
  //                         ),
  //                         Container(
  //                           padding: EdgeInsets.only(top: 5, bottom: 20.0),
  //                           child: TextField(
  //                             enabled: false,
  //                             keyboardType: TextInputType.text,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             decoration: InputDecoration(
  //                               hintText:
  //                                   this.memoList[index].categoryId.toString(),
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5.0),
  //                               ),
  //                               prefixIcon: Icon(
  //                                 Icons.featured_play_list,
  //                                 color: memoColors[
  //                                     (index % memoColors.length).floor()],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Text(
  //                           "Description:",
  //                           style: TextStyle(fontWeight: FontWeight.w500),
  //                         ),
  //                         Padding(
  //                           padding: EdgeInsets.only(top: 5.0),
  //                           child: TextField(
  //                             enabled: false,
  //                             keyboardType: TextInputType.text,
  //                             maxLength: 200,
  //                             maxLines: 5,
  //                             style: TextStyle(
  //                               fontWeight: FontWeight.w500,
  //                             ),
  //                             decoration: InputDecoration(
  //                               // labelText: 'Description',
  //                               hintText: this.memoList[index].description,
  //                               border: OutlineInputBorder(
  //                                 borderRadius: BorderRadius.circular(5.0),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Row(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           children: [
  //                             MaterialButton(
  //                               child: Text(
  //                                 'OK',
  //                                 style: TextStyle(
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.bold,
  //                                   color: Colors.white,
  //                                 ),
  //                               ),
  //                               color: memoColors[
  //                                   (index % memoColors.length).floor()],
  //                               onPressed: () {
  //                                 Navigator.pop(context);
  //                               },
  //                             ),
  //                           ],
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
