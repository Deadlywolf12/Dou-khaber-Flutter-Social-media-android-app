import 'dart:typed_data';

import 'package:cinepopapp/components/app_textfield.dart';

import 'package:cinepopapp/config/resources/app_strings.dart';
import 'package:cinepopapp/components/app_snack_bar.dart';
import 'package:cinepopapp/utils/check_fields_functions.dart';

import 'package:cinepopapp/utils/auth_functions.dart';
import 'package:cinepopapp/utils/image_selector.dart';
import 'package:country_picker/country_picker.dart';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../components/custom_button.dart';

import '../config/resources/app_routes.dart';

class UserDetails extends StatefulWidget {
  final String getEmail;
  final String getPassword;
  final String getPassword2;
  const UserDetails(
      {key,
      required this.getEmail,
      required this.getPassword,
      required this.getPassword2})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<UserDetails> createState() =>
      _UserDetailsState(getEmail, getPassword, getPassword2);
}

class _UserDetailsState extends State<UserDetails> {
  final String _getEmail;
  final String _getpass;
  final String _getpass2;
  _UserDetailsState(this._getEmail, this._getpass, this._getpass2);

  bool _isFieldNotFilled3 = false;

  bool _isFieldNotFilled4 = false;

  bool _isFieldNotFilled5 = false;

  bool _isFieldNotFilled6 = false;

  final _firstNameController = TextEditingController();

  final _locationController = TextEditingController();

  final _birthDateController = TextEditingController();

  final _phoneController = TextEditingController();
  bool _isloading = false;

  DateTime _date = DateTime.now();

  Uint8List? userAvatar;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      userAvatar = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 30,
                      width: 50,
                      child: GestureDetector(
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          size: 40,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Almost there!",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 9),
                        child: userAvatar != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(userAvatar!),
                              )
                            : CircleAvatar(
                                radius: 64,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                child: const Text(
                                  "Pick Image",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          iconSize: 30,
                          color: Theme.of(context).colorScheme.outline,
                          icon: const Icon(Icons.add_a_photo_rounded),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Text(
                    "Fill all the blanks",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: 270,
                    child: Apptextfield(
                      readOnly: false,
                      icon: const Icon(Icons.person),
                      errorText:
                          _isFieldNotFilled3 ? Appstrings.firstNameError : null,
                      tfhints: Appstrings.fullNameHint,
                      controller: _firstNameController,
                      hide: false,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    width: 270,
                    child: Apptextfield(
                      readOnly: false,
                      icon: const Icon(Icons.phone),
                      textInput: TextInputType.phone,
                      errorText:
                          _isFieldNotFilled4 ? Appstrings.phoneError : null,
                      tfhints: Appstrings.phoneNumHint,
                      controller: _phoneController,
                      hide: false,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    width: 270,
                    child: Apptextfield(
                      readOnly: true,
                      sufIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () async {
                          showCountryPicker(
                              context: context,
                              showPhoneCode: false,
                              onSelect: (Country country) {
                                _locationController.text = country.name;
                              });
                        },
                      ),
                      errorText:
                          _isFieldNotFilled5 ? Appstrings.locError : null,
                      icon: const Icon(Icons.location_on),
                      tfhints: Appstrings.locHint,
                      controller: _locationController,
                      hide: false,
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  SizedBox(
                    width: 270,
                    child: Apptextfield(
                      readOnly: true,
                      errorText:
                          _isFieldNotFilled6 ? Appstrings.birthError : null,
                      icon: const Icon(Icons.child_friendly_rounded),
                      sufIcon: IconButton(
                        onPressed: () async {
                          DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(1990),
                            lastDate: DateTime(2025),
                          );
                          if (newDate == null) {
                            return;
                          }
                          setState(() {
                            _date = newDate;
                            _birthDateController.text =
                                DateFormat.yMMMd().format(_date);
                          });
                        },
                        icon: const Icon(Icons.calendar_month),
                      ),
                      tfhints: Appstrings.datehint,
                      controller: _birthDateController,
                      hide: false,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 300,
                    height: 50,
                    child: _isloading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            btnName: Appstrings.done,
                            onpressed: () {
                              setState(() {
                                signUp();
                              });
                            },
                          ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp() async {
    String res = "";

    setState(() {
      _isloading = true;
    });

    _firstNameController.text =
        CheckFields().capitalize(_firstNameController.text.trim());

    if (checkAllFields() && userAvatar != null) {
      res = await AuthFunctions().signup(
          context,
          _getpass,
          _getpass2,
          _firstNameController.text,
          _phoneController.text.trim(),
          _locationController.text.trim(),
          _birthDateController.text.trim(),
          _getEmail,
          userAvatar!);
    } else {
      res = Appstrings.selectPhotoerror;
    }

    setState(() {
      _isloading = false;
    });

    if (mounted) {
      if (res != Appstrings.success) {
        AppSnackBar().showSnackBar(res, context);
      } else {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, Approutes.userAuth);
      }
    }
  }

  bool checkAllFields() {
    bool validate = false;
    final t = CheckFields();

    _isFieldNotFilled3 = t.checkNameField(_firstNameController.text);
    _isFieldNotFilled4 = t.checkContactField(_phoneController.text);
    _isFieldNotFilled5 = t.checklocAndBirthField(_locationController.text);
    _isFieldNotFilled6 = t.checklocAndBirthField(_birthDateController.text);

    if (!_isFieldNotFilled3 &&
        !_isFieldNotFilled4 &&
        !_isFieldNotFilled5 &&
        !_isFieldNotFilled6) {
      validate = true;
    }
    return validate;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _phoneController.dispose();
    _birthDateController.dispose();
    _locationController.dispose();

    super.dispose();
  }
}
