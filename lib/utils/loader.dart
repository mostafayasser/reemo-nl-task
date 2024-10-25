import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../styles/app_colors.dart';

class Loader {
  static void showLoader() {
    if (Get.isSnackbarOpen) {
      Get.closeAllSnackbars();
    }
    Get.dialog(const LoadingWidget(), barrierDismissible: false);
  }

  static void hideLoader() {
    if (Get.isSnackbarOpen) {
      Get.back(closeOverlays: true);
    } else if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
          child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        width: 300,
        height: 80,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.textColor,
                )),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              'loading'.tr,
              style: Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      )),
    );
  }
}
