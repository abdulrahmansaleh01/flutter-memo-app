import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';

class EntryCategory extends StatefulWidget {
  final Category category;

  EntryCategory(this.category);

  @override
  _EntryCategoryState createState() => _EntryCategoryState(this.category);
}

class _EntryCategoryState extends State<EntryCategory> {
  Category category;

  _EntryCategoryState(this.category);

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (category != null) {
      nameController.text = category.name;
      descriptionController.text = category.description;
    }

    //Rubah
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, category),
        ),
        title: category == null
            ? Text(
                'Create Category',
                style: TextStyle(fontSize: 20, color: Colors.black),
              )
            : Text(
                'Update Category',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {
              Navigator.pop(context, category);
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
              if (category == null) {
                //tambah data
                category = Category(
                  nameController.text,
                  descriptionController.text,
                );
              } else {
                //ubah data
                category.name = nameController.text;
                category.description = descriptionController.text;
              }

              //kembali ke layar sebelumnya dengan membawa objek category
              Navigator.pop(context, category);
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
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            // NAMA
            Container(
              padding: EdgeInsets.only(top: 7.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                maxLength: 15,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
                decoration: InputDecoration(
                  hintText: "Category Name",
                  hintStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                  prefixIcon:
                      Icon(Icons.view_list_outlined, color: Colors.black),
                ),
                onChanged: (value) {},
              ),
            ),

            // DESKRIPSI
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: TextField(
                controller: descriptionController,
                keyboardType: TextInputType.text,
                maxLength: 200,
                maxLines: 5,
                style: TextStyle(fontWeight: FontWeight.w500),
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
    );
  }
}
