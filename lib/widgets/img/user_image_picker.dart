import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker(this.setImg);

  final Function setImg;

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImg;

  void getImg() async {
    final pickedImgFile = await ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50, maxHeight: 150);
    setState(() {
      _pickedImg = File(pickedImgFile.path);
    });
    widget.setImg(_pickedImg);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.grey,
          backgroundImage: _pickedImg != null ? FileImage(_pickedImg) : null,
        ),
        TextButton.icon(
          onPressed: getImg,
          icon: Icon(Icons.image),
          label: Text('Upload image'),
        )
      ],
    );
  }
}
