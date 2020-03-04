import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collezione/persitance/RetrieveParameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    if(parameters == null)
      return Text("No parameters could be found");

    return Material(
      child: ListView(
        children: parameters.map((DocumentSnapshot doc){
          String docID = doc.documentID;
          String localizedLabel = returnParamLocalizedLabel(doc);
          return new ListTile(title: Text(doc.documentID));
        }).toList(),
      ),
    );
  }

  String returnParamLocalizedLabel(DocumentSnapshot doc) {
    String label = "";

    if(doc.data.containsKey("it")){
      label = doc["it"];
    } else {
      label = doc["all"];
    }

    return label;
  }

  Future getParameters() async{
    List<DocumentSnapshot> parametersDocuments = await RetrieveParameters.getAllParametersDocuments("it");
     setState(() {
       parameters = parametersDocuments;
     });


  }
  
  Form buildParametersForm(){
    return Form(key: _formKey,child: null);
  }
}