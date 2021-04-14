import 'package:flutter/material.dart';
import 'package:uts_aplikasi_catatan_memo/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memo Application',
      theme: ThemeData(primaryColor: Colors.black),
      home: Home(),
    );
  }
}
