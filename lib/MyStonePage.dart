import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collezione/Widgets/LoadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


import 'persistance/RetrieveParameters.dart';

class MyStonePage extends StatefulWidget {
  final DocumentSnapshot stone;

  MyStonePage(this.stone) : super();

  @override
  State<StatefulWidget> createState() => _MyStonePageState();
}

class _MyStonePageState extends State<MyStonePage> {
  List<Widget> _stoneViewWidgets;

  @override
  void initState() {
    super.initState();
    _buildStoneView();
  }

  _buildStoneView() async {
    List<Widget> stoneViewWidgets = new List();

    Map stoneData = widget.stone.data;

    Future<List> futureRetrieve =
        RetrieveParameters.getAllParametersDocuments();

    String imageSrc = await FirebaseStorage()
        .ref()
        .child("images/" + stoneData["image"])
        .getDownloadURL();

    Widget image = Container(
        child: CachedNetworkImage(
          placeholder: (context, url) => Center(child:CircularProgressIndicator()),
          imageUrl: imageSrc,
        )
    );

    stoneViewWidgets.add(image);

    futureRetrieve.then((parameters) {
      parameters.forEach((parameter) {
        DocumentSnapshot doc = parameter;

        if (doc.data.containsKey("it")) {
          String labelText = doc["it"];
          Text label = Text(
              labelText[0].toUpperCase() +
                  labelText.substring(1).toLowerCase() +
                  ":",
              style: TextStyle(fontWeight: FontWeight.bold));
          Text content = Text(stoneData[doc.documentID]);

          Widget row = Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: label,
              ),
              Expanded(
                flex: 2,
                child: content,
              )
            ])
          );

          stoneViewWidgets.add(row);
        }

        setState(() {
          this._stoneViewWidgets = stoneViewWidgets;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this._stoneViewWidgets == null) {
      return LoadingWidget();
    }
    return Scaffold(
      appBar: AppBar(

      ),
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: ListView(
          children: this._stoneViewWidgets,
        ),
      ),
    );
  }
}
