import 'dart:io';

import 'package:image_cropper/image_cropper.dart';

Future<File?> cropImage({required File imageFile}) async {
  CroppedFile? croppedImage = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));

  if (croppedImage != null) {
    return File(croppedImage.path);
  } else {
    return null;
  }
}
