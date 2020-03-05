import 'dart:io';

import 'package:collezione/MyParametersPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Widgets/LoadingWidget.dart';

class MyCameraPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyCameraPageState();
}

class _MyCameraPageState extends State<MyCameraPage> {
  File _image;

  @override
  void initState() {
    super.initState();
    getImage();
  }

  void _showForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyParametersPage()));
  }

  @override
  Widget build(BuildContext context) {
    if(_image == null) {
      return LoadingWidget();
    }

    return Material(
      child: Column(
        children: <Widget>[
          Expanded(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Image.file(_image),
            ),
          ),
          RaisedButton(
            child: Text("Continua"),
            onPressed: _showForm,
          )
        ],
      ),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }
}


