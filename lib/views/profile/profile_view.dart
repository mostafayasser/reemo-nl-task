import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/user_controller.dart';
import 'widgets/user_data_widget.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final UserController _userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            UserDataWidget(
              title: "industry".tr,
              value: _userController.currentUser.value.industry,
            ),
            const SizedBox(height: 40),
            UserDataWidget(
              title: "seniority".tr,
              value: _userController.currentUser.value.seniority,
            ),
            const SizedBox(height: 40),
            UserDataWidget(
              title: "type".tr,
              value: _userController.currentUser.value.jobType,
            ),
          ],
        ),
      ),
    );
  }
}
