import 'package:cinepopapp/styles/app_colors.dart';
import 'package:flutter/material.dart';

class Apptextfield extends StatelessWidget {
  final Icon icon;
  final String tfhints;
  final String? errorText;
  final bool hide;
  final TextInputType? textInput;
  final Function(String)? onchanged;
  final IconButton? sufIcon;
  final bool readOnly;
  final TextEditingController? controller;

  const Apptextfield({
    super.key,
    required this.icon,
    required this.tfhints,
    this.controller,
    required this.hide,
    this.sufIcon,
    this.errorText,
    this.onchanged,
    this.textInput,
    required this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly,
      keyboardType: textInput,
      obscureText: hide,
      onChanged: onchanged,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(20),
        prefixIcon: icon,
        suffixIcon: sufIcon,
        errorText: errorText,

        prefixIconColor: Theme.of(context).colorScheme.surface,
        suffixIconColor: Theme.of(context).colorScheme.surface,

        hintText: tfhints,

        // labelText: tfTitles,
        labelStyle: const TextStyle(color: Colors.white, height: 4),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14))),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
          borderRadius: BorderRadius.all(
            Radius.circular(14),
          ),
        ),

        filled: true,
        fillColor: Color.fromARGB(255, 136, 135, 135),
      ),
    );
  }
}
