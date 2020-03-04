import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: _image == null
          ? Text('No image selected.')
          : Image.file(_image),
    );
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

}