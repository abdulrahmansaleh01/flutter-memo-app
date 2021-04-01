class Category {
  int _id;
  String _name;
  String _description;

  int get id => _id;

  String get name => this._name;
  set name(String value) => this._name = value;

  String get description => this._description;
  set description(String value) => this._description = value;

  /** 
   * - Konstruktor versi 1 -
   * untuk mengeset nilai name dan description secara bersama-sama
   */
  Category(this._name, this._description);

  /** 
   * - Konstruktor versi 2: konversi dari Map ke Category -
   * untuk mengambil data dari sql yang tersimpan berbentuk Map 
   * setelah itu akan disimpan kembali dalam bentuk variabel
   */
  Category.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._description = map['description'];
  }

  /** 
   * - Konversi dari Category ke Map -
   * membuat method Map untuk melakukan update dan insert.
   */
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['description'] = description;

    return map;
  }
}
