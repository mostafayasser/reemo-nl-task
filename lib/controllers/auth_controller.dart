import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> signUp({
    required UserModel userModel,
    required String password,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: password,
      );

      return "";
    } on FirebaseAuthException catch (e) {
      log("eeee${e.code}");
      if (e.code == "weak-email-already-in-use") {
        return "email is already exist";
      }
      return e.message!;
    }
  }

  Future<String> signInWithEmail({
    required String email,
    required String password,
  }) async {
    String errorMessage = "";
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (_auth.currentUser == null || _auth.currentUser!.uid.isEmpty) {
        errorMessage = "Enter valid email and password";
      }
      return errorMessage;
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credential") {
        errorMessage = "invalid email or password";
      } else {
        log("eeee${e.code}");
        errorMessage = e.code;
      }
      return errorMessage;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
