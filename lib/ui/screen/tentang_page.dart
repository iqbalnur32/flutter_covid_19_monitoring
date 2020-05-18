import 'package:flutter/material.dart';
import 'package:sample/ui/screen/home_views.dart';
import 'package:sample/ui/untils/style_app.dart';

class AboutPage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Tentang Aplikasi Ini ?"),
        backgroundColor: AppStyle.bgr,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.backspace),
            onPressed: () => {
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (BuildContext context) => HomePage(), 
                )
              )
            },
          )
        ],
      ),
      body: Container(
        color: AppStyle.bgr,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                title: Text("Covid 19 Statatic"),
                subtitle: Text("Powerded By Iqbal Nur"),
                trailing: Icon(Icons.label_outline),
              ),
            ),
            SizedBox(height: 30.0,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.0)),
            Card(
              child: ListTile(
                title: Text("Iqbal Nur"),
                subtitle: Text("Refrence Devindo Channel Youtube"),
                trailing: Icon(Icons.label_outline),
              ),
            )
          ],
        ),
      ),
    );
  }
}