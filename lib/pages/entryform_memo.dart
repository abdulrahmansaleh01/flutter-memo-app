import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';

class EntryMemo extends StatefulWidget {
  final Memo memo;

  EntryMemo(this.memo);

  @override
  _EntryMemoState createState() => _EntryMemoState(this.memo);
}

class _EntryMemoState extends State<EntryMemo> {
  Memo memo;

  _EntryMemoState(this.memo);

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (memo != null) {
      titleController.text = memo.title;
      dateController.text = memo.date;
      descriptionController.text = memo.description;
      categoryController.text = memo.categoryId;
    }
    return Scaffold(
      appBar: AppBar(
        title: memo == null
            ? Text(
                'Create Memo',
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            : Text(
                'Update Memo',
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
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            // JUDUL
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: Icon(Icons.text_fields),
                ),
                onChanged: (value) {},
              ),
            ),

            // TANGGAL
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: dateController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Date (DD/MM/YYYY)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: Icon(Icons.date_range),
                ),
                onChanged: (value) {},
              ),
            ),

            // kategori
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: categoryController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Enter Category',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: Icon(Icons.text_fields),
                ),
                onChanged: (value) {},
              ),
            ),

            // DESKRIPSI
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                maxLength: 200,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),

            // BUTTON
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: <Widget>[
                  //BUTTON "Simpan"
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      child: Text(
                        'Save',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        if (memo == null) {
                          //tambah data
                          memo = Memo(
                              titleController.text,
                              dateController.text,
                              descriptionController.text,
                              int.parse(categoryController.text));
                        } else {
                          //ubah data
                          memo.title = titleController.text;
                          memo.date = dateController.text;
                          memo.description = descriptionController.text;
                          memo.categoryId = int.parse(categoryController.text);
                        }

                        //kembali ke layar sebelumnya dengan membawa objek memo
                        Navigator.pop(context, memo);
                      },
                    ),
                  ),

                  Container(
                    width: 5.0,
                  ),

                  //BUTTON "Batal"
                  Expanded(
                    child: RaisedButton(
                      color: Colors.blue[400],
                      textColor: Colors.white,
                      child: Text(
                        'Cancel',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        Navigator.pop(context, memo);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
