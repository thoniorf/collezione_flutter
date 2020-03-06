import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collezione/main.dart';
import 'package:collezione/persistance/RetrieveParameters.dart';
import 'package:collezione/store/Store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/LoadingWidget.dart';
import 'model/Stones.dart';

class MyParametersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyParametersState();
}

class _MyParametersState extends State<MyParametersPage> {
  List<DocumentSnapshot> parameters;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getParameters();
  }

  @override
  Widget build(BuildContext context) {
    if (parameters == null) return LoadingWidget();

    return Material(
      child: buildParametersForm(),
    );
  }

  String returnParamLocalizedLabel(DocumentSnapshot doc) {
    String label = "";

    if (doc.data.containsKey("it")) {
      label = doc["it"];
    }

    return label;
  }

  getParameters() {
    Future futureRetrieve = RetrieveParameters.getAllParametersDocuments("it");
    futureRetrieve.then((onValue) => {
          setState(() {
            parameters = onValue;
          })
        });
  }

  Form buildParametersForm() {
    List<Widget> formInputs = new List();

    List<Widget> formTextInputs = parameters
        .map((DocumentSnapshot doc) {
          String docID = doc.documentID;
          String localizedLabel = returnParamLocalizedLabel(doc);
          if (localizedLabel.isEmpty) return null;
          return new TextFormField(
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
                labelText: localizedLabel[0].toUpperCase() +
                    localizedLabel.substring(1).toLowerCase()),
            onSaved: (String value) {
              Store.stone.put(docID, value);
            },
          );
        })
        .where((field) => field != null)
        .toList();

    Widget submitButton = RaisedButton(
      child: Text("Invia"),
      onPressed: _saveForm,
    );

    formInputs.addAll(formTextInputs);
    formInputs.add(submitButton);

    return Form(
        key: _formKey,
        child: Column(
          children: formInputs,
        ));
  }

  void _saveForm() {
    _formKey.currentState.save();
    Store.saveStone().then((value) => _showHome());
  }

  void _showHome() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Collezione')));
  }
}
