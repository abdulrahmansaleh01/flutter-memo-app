class Memo {
  int _id;
  String _title;
  String _date;
  String _description;
  int _categoryId;

  int get id => _id;

  String get title => this._title;
  set title(String value) => this._title = value;

  String get date => this._date;
  set date(String value) => this._date = value;

  String get description => this._description;
  set description(String value) => this._description = value;

  get categoryId => this._categoryId;
  set categoryId(value) => this._categoryId = value;

  /** 
   * - Konstruktor versi 1 -
   * untuk mengeset nilai title, date, description, dan categoryId secara bersama-sama
   */
  Memo(this._title, this._date, this._description, this._categoryId);

  /** 
   * - Konstruktor versi 2: konversi dari Map ke Memo -
   * untuk mengambil data dari sql yang tersimpan berbentuk Map 
   * setelah itu akan disimpan kembali dalam bentuk variabel
   */
  Memo.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._date = map['date'];
    this._description = map['description'];
    this._categoryId = map['categoryId'];
  }

  /** 
   * - Konversi dari Memo ke Map -
   * membuat method Map untuk melakukan update dan insert.
   */
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['title'] = title;
    map['date'] = date;
    map['description'] = description;
    map['categoryId'] = categoryId;
    return map;
  }
}
