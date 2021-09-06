import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ประเภทของการวิ่ง"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) { //เพิ่ม AsyncSnapshot เพื่อใช้ตรง return MyBox
                //var data = json.decode(snapshot.data.toString());
                return ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return MyBox(
                        //เพิ่มคำว่า snapshot.data
                          snapshot.data[index]['title'],
                          snapshot.data[index]['subtitle'],
                          snapshot.data[index]['image_url'],
                          snapshot.data[index]['detail']);
                    },
                    itemCount: snapshot.data.length);
              },
              //future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
              future: getData(),
            )));
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;

    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    return Container(
      margin: EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      //color: Colors.blue[100],
      height: 250,
      decoration: BoxDecoration(
        //color: Colors.blue[50],
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
            image: NetworkImage(image_url),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.50), BlendMode.darken)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'modsss'),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontFamily: 'modsss'),
          ),
          SizedBox(
            height: 50,
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              },
              child: Text("อ่านต่อ...",
                  style: TextStyle(
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }

//สร้างฟังก์ชัน getData เพื่อเรียกใช้ data.json ที่อัพโหลดอยู่บน github
  Future getData() async {
    //https://raw.githubusercontent.com/sutthisakw/LayoutAPI/main/data.json
    var url = Uri.https('raw.githubusercontent.com', '/sutthisakw/LayoutAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
