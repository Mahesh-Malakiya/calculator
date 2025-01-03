import 'package:flutter_calculator/module/login_sign_up/controller/login_sign_up_controller.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:flutter_calculator/module/setting/controller/setting_controller.dart';
import 'package:flutter_calculator/module/splash/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      SplashController.new,
    );
  }
}

class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      MainController.new,
    );
  }
}

class SettingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingController>(
      SettingController.new,
    );
  }
}

class LoginSignUpBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginSignUpController>(
      LoginSignUpController.new,
    );
  }
}
