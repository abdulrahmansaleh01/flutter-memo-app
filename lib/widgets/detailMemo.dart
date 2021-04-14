import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';
import 'package:uts_aplikasi_catatan_memo/widgets/colors.dart';

class ShowDetailMemo extends StatelessWidget {
  const ShowDetailMemo({
    Key key,
    @required this.memoList,
    @required this.index,
  }) : super(key: key);

  final List<Memo> memoList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 23),
      child: Container(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height),
            ),
            child: Padding(
              padding: EdgeInsets.only(bottom: 250, top: 50),
              child: new Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "Detail Memo",
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: memoColors[(index % memoColors.length).floor()],
                    thickness: 3.7,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title:",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                          color:
                              memoColors[(index % memoColors.length).floor()],
                        ),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: this.memoList[index].title,
                            hintStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.text_fields,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Date:",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                          color:
                              memoColors[(index % memoColors.length).floor()],
                        ),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            // labelText: 'Category Name',
                            hintText: this.memoList[index].date,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 17,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Category:",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5, bottom: 20.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                          color:
                              memoColors[(index % memoColors.length).floor()],
                        ),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                this.memoList[index].categoryId.toString(),
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.featured_play_list,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Description:",
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 16),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.black),
                          borderRadius: BorderRadius.circular(8.0),
                          color:
                              memoColors[(index % memoColors.length).floor()],
                        ),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          maxLines: 6,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            // labelText: 'Description',
                            hintText: this.memoList[index].description,
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Colors.black, width: 2.0)),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            color:
                                memoColors[(index % memoColors.length).floor()],
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
