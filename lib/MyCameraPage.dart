import 'dart:io';

import 'package:collezione/store/Store.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import 'MyParametersPage.dart';
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

  void _showForm() async{
    String fileName = p.basename(_image.path);
    final StorageReference storageReference = FirebaseStorage().ref().child(
        "images").child(fileName);

    final StorageUploadTask uploadTask = storageReference.putFile(_image);

    await uploadTask.onComplete;
    Store.stone.put("image", fileName);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => MyParametersPage()));
  }

  @override
  Widget build(BuildContext context) {
    if(_image == null) {
      return LoadingWidget();
    }

    return Scaffold(
      backgroundColor: Colors.black54,
      body: SafeArea(
        minimum: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: _image == null ? LoadingWidget() : Image.file(_image),
              ),
            ),
            Row(
              children: <Widget>[
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    child: Icon(Icons.clear),
                    onPressed: getImage,
                  ),
                ),
                Center(
                  child: RaisedButton(
                    color: Colors.white,
                    child: Icon(Icons.check),
                    onPressed: _showForm,
                  ),
                )
              ],
            )

          ],
        ),
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


