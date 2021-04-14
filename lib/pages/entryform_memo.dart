import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uts_aplikasi_catatan_memo/dbhelper.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
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
  DbHelper dbHelper = DbHelper();
  Category selectedCategory;

  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  var _selectedValue;
  var _categories = List<DropdownMenuItem>();

  @override
  void initState() {
    _loadCategories();
    super.initState();
  }

  _loadCategories() async {
    //variabel untuk memanggil data kategori untuk ditampilkan pada DropdownMenuItem
    var categories = await dbHelper.getCategoryList();
    categories.forEach((category) {
      setState(() {
        _categories.add(DropdownMenuItem(
          child: Text(category.name),
          value: category.id,
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        dateController.text = DateFormat('yyyy/MM/dd').format(_pickedDate);
      });
    }
  }

  void callback(Category _selectedCategory) {
    setState(() {
      selectedCategory = _selectedCategory;
      print(selectedCategory.name);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (memo != null) {
      titleController.text = memo.title;
      dateController.text = memo.date;
      descriptionController.text = memo.description;
      memo.categoryId = memo.categoryId;
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, memo),
        ),
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
                  labelText: 'Date',
                  hintText: 'Pick a Date',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: InkWell(
                    onTap: () {
                      _selectedDate(context);
                    },
                    child: Icon(Icons.date_range),
                  ),
                ),
                onChanged: (value) {},
              ),
            ),

            // KATEGORI
            DropdownButtonFormField(
                value: _selectedValue,
                items: _categories,
                hint: Text('Select Category'),
                onChanged: (value) {
                  setState(() {
                    _selectedValue = value;
                  });
                }),

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
                              int.parse(_selectedValue.toString()));
                        } else {
                          //ubah data
                          memo.title = titleController.text;
                          memo.date = dateController.text;
                          memo.description = descriptionController.text;
                          memo.categoryId =
                              int.parse(_selectedValue.toString());
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
