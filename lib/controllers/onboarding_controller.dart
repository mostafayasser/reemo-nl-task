import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../services/cache_service.dart';
import '../utils/app_constants.dart';
import 'user_controller.dart';

class OnboardingController extends GetxController {
  final UserController _userController = Get.find();
  // Tracks the current page index (0 for first, 1 for second, etc.)
  var currentPage = 0.obs;

  RxString selectedSeniority = "".obs;
  RxString selectedIndustry = "".obs;
  RxString selectedJobType = "".obs;

  TextEditingController otherIndustryController = TextEditingController();

  @override
  void onClose() {
    otherIndustryController.dispose();
    super.onClose();
  }

  // Moves to the next screen
  void nextPage() {
    if (currentPage < 2) {
      currentPage++;
    }
  }

  // Moves to the previous screen
  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
    }
  }

  String validateStep() {
    if (currentPage.value == 0) {
      if (selectedIndustry.isEmpty) {
        return "Please select an industry";
      } else if (selectedIndustry.value == "Other" &&
          otherIndustryController.text.isEmpty) {
        return "Please write your industry";
      }
    } else if (currentPage.value == 1) {
      if (selectedSeniority.isEmpty) {
        return "Please select a seniority level";
      }
    } else if (currentPage.value == 2) {
      if (selectedJobType.isEmpty) {
        return "Please select a job type";
      }
    }
    return "";
  }

  UserModel getUserFromCache() {
    UserModel user = UserModel.empty();
    String encodedUser = CacheService.getString(AppConstants.userData);
    if (encodedUser.isNotEmpty) {
      user = UserModel.fromJson(jsonDecode(encodedUser));
    }
    return user;
  }

  submitAnswers() async {
    UserModel user = getUserFromCache();
    user.industry = selectedIndustry.value;
    user.seniority = selectedSeniority.value;
    user.jobType = selectedJobType.value;
    if (selectedIndustry.value == "Other") {
      user.industry = otherIndustryController.text;
    }
    await _userController.updateUserOnboardingData(user);
  }
}
