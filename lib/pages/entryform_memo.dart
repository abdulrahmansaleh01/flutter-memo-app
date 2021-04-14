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
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.grey[850],
            accentColor: Colors.grey[850],
            colorScheme: ColorScheme.light(primary: Colors.grey[850]),
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child,
        );
      },
    );

    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        dateController.text = DateFormat('yyyy/MM/dd').format(_pickedDate);
      });
    }
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
          InkWell(
            onTap: () {
              Navigator.pop(context, memo);
            },
            child: IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.black,
                size: 33,
              ),
            ),
          ),
          InkWell(
            onTap: () {
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
                memo.categoryId = int.parse(_selectedValue.toString());
              }

              //kembali ke layar sebelumnya dengan membawa objek memo
              Navigator.pop(context, memo);
            },
            child: IconButton(
              icon: Icon(
                Icons.check,
                color: Colors.black,
                size: 33,
              ),
            ),
          ),
        ],
        // leading: Icon(Icons.keyboard_arrow_left),
      ),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              // JUDUL
              TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                maxLength: 30,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  // labelText: 'Enter title',
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(5.0),
                  // ),
                  prefixIcon: Icon(Icons.text_fields, color: Colors.black),
                ),
                onChanged: (value) {},
              ),

              // TANGGAL
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: dateController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                  decoration: InputDecoration(
                    // labelText: 'Date',
                    hintText: 'Pick a Date',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(5.0),
                    // ),
                    prefixIcon: InkWell(
                      onTap: () {
                        _selectedDate(context);
                      },
                      child: Icon(Icons.date_range, color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {},
                ),
              ),

              // KATEGORI
              Container(
                margin: EdgeInsets.only(bottom: 7.0, left: 70, right: 70),
                child: DropdownButtonFormField(
                    value: _selectedValue,
                    items: _categories,
                    hint: Text('Select Category'),
                    onChanged: (value) {
                      setState(() {
                        _selectedValue = value;
                      });
                    }),
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
            ],
          ),
        ),
      ),
    );
  }
}
