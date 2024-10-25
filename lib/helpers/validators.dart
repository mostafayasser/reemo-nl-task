// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/widgets.dart';

class Validators {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }

    // Regex to allow only letters
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]+$');
    if (!nameRegExp.hasMatch(value)) {
      return 'Name must contain only letters';
    }

    return null;
  }

  static String? validateRequired(String? value, String type) {
    if (value != null) {
      value = value.replaceAll(" ", "");
    }
    if (value == null || value.isEmpty) {
      return "$type is Required";
    }
    return null;
  }

  static String? validate() {
    return null;
  }

  static String? validateEmail(String value) {
    debugPrint("Email :: $value");
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)";
    RegExp regExp = RegExp(pattern);
    debugPrint("Email :: ${regExp.hasMatch(value)}");
    if (value == null || value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validatePassword(String value) {
    if (value.isEmpty) {
      return "Password is Required";
    }

    if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }

    // Regex to check for at least one letter, one number, and no spaces
    String pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d@$!%*?&]{6,}$';
    RegExp regExp = RegExp(pattern);

    if (!regExp.hasMatch(value) || value.contains(' ')) {
      return "Password must contain both letters and numbers and no spaces";
    }

    return null;
  }

  static String? validateConfirmPassword(String value1, String value2) {
    if (value1.isEmpty) {
      return "Confirm Password is Required";
    } else if (value1 != value2) {
      return "Password & Confirm Password does not match.";
    }
    return null;
  }
}
