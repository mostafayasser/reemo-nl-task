// create a custom get snackbar that takes title and returns get snackbar

import 'package:get/get.dart';

SnackbarController customSnackBar({
  required String message,
  required bool isError,
}) {
  return Get.snackbar(
    isError ? 'error'.tr : 'success'.tr,
    message,
    backgroundColor: Get.theme.scaffoldBackgroundColor.withOpacity(0.7),
    colorText: Get.theme.textTheme.bodyMedium!.color,
  );
}
