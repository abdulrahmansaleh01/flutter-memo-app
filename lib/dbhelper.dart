import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uts_aplikasi_catatan_memo/models/categoryMemo.dart';
import 'package:uts_aplikasi_catatan_memo/models/memo.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'memo.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 4, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //Membuat Tabel baru dengan nama memo dan categoryMemo
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE categoryMemo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE memo(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        date TEXT,
        description TEXT,
        categoryId INTEGER,
        FOREIGN KEY(categoryId) REFERENCES categoryMemo(id) ON DELETE CASCADE ON UPDATE CASCADE
      )
    ''');
  }

//------------------- TABEL CATEGORY MEMO -----------------------
  //SELECT
  Future<List<Map<String, dynamic>>> selectCategory() async {
    Database db = await this.initDb();
    var mapListCategory = await db.query('categoryMemo', orderBy: 'name');

    return mapListCategory;
  }

  //CREATE
  Future<int> insertCategory(Category object) async {
    Database db = await this.initDb();
    int countCategory = await db.insert('categoryMemo', object.toMap());

    return countCategory;
  }

  //UPDATE
  Future<int> updateCategory(Category object) async {
    Database db = await this.initDb();
    int countCategory = await db.update(
      'categoryMemo',
      object.toMap(),
      where: 'id=?',
      whereArgs: [object.id],
    );

    return countCategory;
  }

  //DELETE
  Future<int> deleteCategory(int id) async {
    Database db = await this.initDb();
    int countCategory = await db.delete(
      'categoryMemo',
      where: 'id=?',
      whereArgs: [id],
    );

    return countCategory;
  }

  // DELETE MEMO BERDASARKAN KATEGORI
  // (Ketika Kategorinya dihapus, maka memo yang bersangkutan dengan kategori tersebut akan dihapus juga)
  Future<int> deleteMemoByCategory(int id) async {
    Database db = await this.initDb();
    int countMemo = await db.delete(
      'memo',
      where: 'categoryId=?',
      whereArgs: [id],
    );

    return countMemo;
  }

  Future<List<Category>> getCategoryList() async {
    var categoryMapList = await selectCategory();
    int countCategory = categoryMapList.length;
    List<Category> categoryList = List<Category>();

    for (int i = 0; i < countCategory; i++) {
      categoryList.add(Category.fromMap(categoryMapList[i]));
    }

    return categoryList;
  }
//---------------------------------------------------------------

// ----------------------- TABEL MEMO ---------------------------
  //SELECT
  Future<List<Map<String, dynamic>>> selectMemo() async {
    Database db = await this.initDb();
    var mapListMemo = await db.query('memo', orderBy: 'date');

    return mapListMemo;
  }

  //CREATE
  Future<int> insertMemo(Memo object) async {
    Database db = await this.initDb();
    int countMemo = await db.insert('memo', object.toMap());

    return countMemo;
  }

  //UPDATE
  Future<int> updateMemo(Memo object) async {
    Database db = await this.initDb();
    int countMemo = await db.update(
      'memo',
      object.toMap(),
      where: 'id=?',
      whereArgs: [object.id],
    );

    return countMemo;
  }

  //DELETE
  Future<int> deleteMemo(int id) async {
    Database db = await this.initDb();
    int countMemo = await db.delete(
      'memo',
      where: 'id=?',
      whereArgs: [id],
    );

    return countMemo;
  }

  Future<List<Memo>> getMemoList() async {
    var memoMapList = await selectMemo();
    int countMemo = memoMapList.length;
    List<Memo> memoList = List<Memo>();

    for (int i = 0; i < countMemo; i++) {
      memoList.add(Memo.fromMap(memoMapList[i]));
    }

    return memoList;
  }
//---------------------------------------------------------------

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }

    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }

    return _database;
  }
}
