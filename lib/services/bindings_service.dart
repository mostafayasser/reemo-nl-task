import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../controllers/user_controller.dart';
import '../theme/theme_service.dart';

class BindingsService extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(UserController(), permanent: true);
    Get.put(ThemeService(), permanent: true);
  }
}
