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
          onPressed: () => Navigator.of(context).pop(),
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
            // NAMA
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  prefixIcon: Icon(Icons.view_list_outlined),
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
                        Navigator.pop(context, category);
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
