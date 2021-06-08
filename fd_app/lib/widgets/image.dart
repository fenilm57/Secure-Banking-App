import 'package:fd_app/utils/imageutil.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePick extends StatefulWidget {
  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  File _image;
  final _picker = ImagePicker();
  Image imagefrompref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadImage();
  }

  void loadImage() {
    Utility.getImageFromPreferences().then((img) {
      if (img == null) {
        return;
      }
      setState(() {
        imagefrompref = Utility.imageFromBase64String(img);
      });
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final pickedFile = await _picker.getImage(source: ImageSource.camera);
    Utility.saveImageToPreferences(
        Utility.base64String(File(pickedFile.path).readAsBytesSync()));
  }

  _imgFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    Utility.saveImageToPreferences(
        Utility.base64String(File(pickedFile.path).readAsBytesSync()));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 32,
        ),
        Center(
          child: GestureDetector(
            onTap: () {
              _showPicker(context);
            },
            child: CircleAvatar(
              radius: 55,
              backgroundColor: Colors.white,
              child: imagefrompref != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: imagefrompref,
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
          ),
        )
      ],
    );
  }
}
