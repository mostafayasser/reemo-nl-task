import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/cache_service.dart';
import '../utils/app_constants.dart';

class UserController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Rx<UserModel> currentUser = UserModel.empty().obs;

  @override
  void onInit() async {
    super.onInit();
    getUserFromCache();
  }

  setUserData(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.email)
        .set(user.toJson());
    currentUser.value = UserModel.fromJson(user.toJson());
    await cacheUserData();
  }

  updateUserOnboardingData(UserModel user) async {
    await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.email)
        .update(user.toJson());
    currentUser.value = UserModel.fromJson(user.toJson());
    await cacheUserData();
  }

  cacheUserData() async {
    String encodedUser = jsonEncode(currentUser.value.toJson());
    await CacheService.setString(AppConstants.userData, encodedUser);
  }

  getUserFromCache() {
    String encodedUser = CacheService.getString(AppConstants.userData);
    if (encodedUser.isNotEmpty) {
      currentUser.value = UserModel.fromJson(jsonDecode(encodedUser));
    }
  }

  getUserFromFirestore(String email) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(email)
        .get();
    if (userDoc.exists) {
      currentUser.value = UserModel.fromJson(userDoc.data()!);
      await cacheUserData();
    }
  }

  clearUserData() async {
    CacheService.clear();
    currentUser.value = UserModel.empty();
  }
}
