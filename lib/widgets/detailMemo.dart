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
      padding: EdgeInsets.only(left: 25, right: 25),
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
                          fontSize: 20.00,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: memoColors[(index % memoColors.length).floor()],
                    thickness: 2.5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Title:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 20.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText: this.memoList[index].title,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.text_fields,
                              color: memoColors[
                                  (index % memoColors.length).floor()],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Date:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 20.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            // labelText: 'Category Name',
                            hintText: this.memoList[index].date,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.date_range,
                              color: memoColors[
                                  (index % memoColors.length).floor()],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Category:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 5, bottom: 20.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            hintText:
                                this.memoList[index].categoryId.toString(),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            prefixIcon: Icon(
                              Icons.featured_play_list,
                              color: memoColors[
                                  (index % memoColors.length).floor()],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Description:",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: TextField(
                          enabled: false,
                          keyboardType: TextInputType.text,
                          maxLength: 200,
                          maxLines: 5,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            // labelText: 'Description',
                            hintText: this.memoList[index].description,
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
