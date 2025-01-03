import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/app_prefrance.dart';

class SplashController extends GetxController {
  final appPreferences = AppPreferences();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      checkFirstTime();
    });
  }

  Future<void> checkFirstTime() async {
    final isFirstTime = await appPreferences.getIsFirstTime();

    if (isFirstTime) {
      // Navigate to LOGIN_SIGNUP screen
      Get.offNamed(Routes.LOGIN_SIGNUP);
    } else {
      // Navigate to MAIN screen
      Get.offNamed(Routes.MAIN);
    }
  }
}
