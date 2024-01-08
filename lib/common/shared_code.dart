import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SharedCode {
  final BuildContext context;
  SharedCode(this.context);

  static Future<File?> addImage({ImageSource? source}) async {
    final ImagePicker picker = ImagePicker();
    final File imagePicked =
        File((await picker.pickImage(source: source!, imageQuality: 15))!.path);
    return File(imagePicked.path);
  }
}
