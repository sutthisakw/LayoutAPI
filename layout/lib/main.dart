import 'package:flutter/material.dart';
import 'package:layout/pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //primaryColor: Colors.blue,
        fontFamily: 'modsss'
      ),
      debugShowCheckedModeBanner: false,
      title: "ประเภทของการวิ่ง",
      home: HomePage(),
    );
  }
}
