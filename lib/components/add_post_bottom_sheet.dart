import 'dart:typed_data';

import 'package:cinepopapp/components/app_textfield.dart';
import 'package:cinepopapp/components/custom_button.dart';
import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/config/providers/user_provider.dart';
import 'package:cinepopapp/config/resources/firestore_methods.dart';
import 'package:cinepopapp/styles/app_colors.dart';
import 'package:cinepopapp/styles/app_text.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:cinepopapp/config/models/user_model.dart' as model;
import 'package:provider/provider.dart';

import '../utils/image_selector.dart';

class AddPostBottomSheet extends StatefulWidget {
  const AddPostBottomSheet({super.key});

  @override
  State<AddPostBottomSheet> createState() => _AddPostBottomSheetState();
}

class _AddPostBottomSheetState extends State<AddPostBottomSheet> {
  final descriptionController = TextEditingController();
  Uint8List? _file;
  bool isCamera = false;
  bool isLoading = false;
  String error = "";
  bool isAddClicked = false;
  bool isDescriptionFilled = true;
  bool isPicSelected = true;

  Future<String> uploadUserPost(String uid, String name, String pic) async {
    String res = "";
    if (mounted) {
      setState(() {
        isLoading = true;
      });

      try {
        res = await FirestoreMethods().uploadPost(
            _file!, uid, descriptionController.text.trim(), name, pic);

        setState(() {
          isLoading = false;
        });
        if (res == Appstrings.success) {
          res = Appstrings.posted;
        }
      } catch (err) {
        setState(() {
          isLoading = false;
          res = err.toString();
        });
      }
    }
    return res;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  void selectImage() async {
    if (isCamera == true) {
      Uint8List img = await pickImage(ImageSource.camera);

      setState(() {
        isCamera = false;
        _file = img;
      });
    } else {
      Uint8List img = await pickImage(ImageSource.gallery);

      setState(() {
        _file = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    model.User user = Provider.of<UserProvider>(context).getUser;

    return isLoading
        ? const LinearProgressIndicator(
            color: Colors.amber,
          )
        : isAddClicked
            ? Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      error,
                      style: Apptext.subtitle3,
                    )
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      Appstrings.addPostCaption,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Apptextfield(
                        icon: const Icon(Icons.description),
                        tfhints: Appstrings.addPostCaptHint,
                        hide: false,
                        errorText: isDescriptionFilled ? null : error,
                        controller: descriptionController,
                        readOnly: false),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Appstrings.addPostPickImage,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCamera = false;
                          selectImage();
                        });
                      },
                      child: _file != null
                          ? Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    width: 2),
                                image: DecorationImage(
                                  image: MemoryImage(_file!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: const Center(
                                child: Icon(Icons.add_a_photo),
                              ),
                            )
                          : Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: isPicSelected
                                        ? Theme.of(context)
                                            .colorScheme
                                            .primaryContainer
                                        : Colors.red,
                                    width: 2),
                              ),
                              child: Center(
                                child: isPicSelected
                                    ? const Icon(Icons.add_a_photo)
                                    : Text(
                                        error,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      Appstrings.addPostOr,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                      onPressed: () {
                        isCamera = true;
                        selectImage();
                      },
                      child: Text(
                        Appstrings.addPostCameraBtn,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                      btnName: Appstrings.addPostAddBtn,
                      onpressed: () async {
                        if (_file != null) {
                          if (descriptionController.text.isNotEmpty) {
                            isAddClicked = true;
                            error = await uploadUserPost(
                                user.uid, user.name, user.photoUrl);
                          } else {
                            setState(() {
                              error = "please add a description";
                              isDescriptionFilled = false;
                            });
                          }
                        } else {
                          setState(() {
                            error = "please add a photo";
                            isPicSelected = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              );
  }
}
