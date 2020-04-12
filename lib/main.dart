import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collezione/MyCameraPage.dart';
import 'package:collezione/Widgets/LoadingWidget.dart';
import 'package:collezione/persistance/RetrieveStones.dart';
import 'package:collezione/store/Store.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Collezione',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Collezione'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<DocumentSnapshot> stones;

  void _showCamera() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyCameraPage()));
  }

  @override
  void initState() {
    super.initState();
    Store.getNewStone();
    getStones();
  }

  void getStones() {
    Future futureRetrieve =  RetrieveStones.getAllStonesDocuments();
    futureRetrieve.then((onValue) => {
      setState(() {
        stones = onValue;
      })
    });
  }

  List<Widget> buildStoneList() {
    List<Widget> stoneTile = new List();

    stones.forEach((stone) {
      stoneTile.add(new ListTile(
        title: stone["name"],
        contentPadding: EdgeInsets.symmetric(horizontal: 6.0),
      ));
    });

    return stoneTile;
  }

  @override
  Widget build(BuildContext context) {
    if (stones == null) return LoadingWidget();

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: ListView(
          children: buildStoneList(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCamera,
        tooltip: 'Aggiungi alla collezione',
        child: Icon(Icons.add),
      ),
    );
  }
}
