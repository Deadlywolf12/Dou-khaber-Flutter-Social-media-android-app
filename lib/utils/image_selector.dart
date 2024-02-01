import 'dart:io';

import 'package:cinepopapp/utils/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _img = ImagePicker();
  final file = await _img.pickImage(source: source);
  if (file != null) {
    File? img = File(file.path);
    img = await cropImage(imageFile: img);

    if (img != null) {
      return await img.readAsBytes();
    }
  }
}
