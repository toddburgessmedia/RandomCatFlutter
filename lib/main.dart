import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Random Cat',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Random Cat Photo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String _file = "https:\/\/purr.objects-us-east-1.dream.io\/i\/rd0Nc.jpg";

  void _getCatPhoto() async {
    //String url = "https://aws.random.cat/meow"; // other server
    String host = "http://10.0.2.2:5000";
    String url =  host + "/getpic";

    http.Response response = await http.get(url);
    setState(() {
      final fileJSON = json.decode(response.body);
      _file = host + fileJSON["file"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.network(_file)
            ,
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _getCatPhoto,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
