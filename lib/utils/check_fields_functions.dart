class CheckFields {
  bool isPassLengthOk(int length) {
    if (length >= 8) {
      return true;
    } else {
      return false;
    }
  }

  bool validateEmail(String val) {
    bool result = false;
    if (val.isNotEmpty) {
      if (val.contains('@')) {
      } else {
        result = true;
      }
    } else {
      result = true;
    }
    return result;
  }

  bool checkNameField(String val) {
    bool result = false;
    if (val.isNotEmpty) {
    } else {
      result = true;
    }
    return result;
  }

  bool checkContactField(String val) {
    bool result = false;
    if (val.isNotEmpty && val.length >= 6) {
    } else {
      result = true;
    }
    return result;
  }

  bool checklocAndBirthField(String val) {
    bool result = false;
    if (val.isNotEmpty) {
    } else {
      result = true;
    }
    return result;
  }

  String capitalize(String input) {
    if (input.isEmpty) {
      return input;
    }
    return input[0].toUpperCase() + input.substring(1);
  }
}
