// ignore_for_file: constant_identifier_names, inference_failure_on_instance_creation, lines_longer_than_80_chars

import 'package:flutter_calculator/binding/app_bindings.dart';
import 'package:flutter_calculator/module/login_sign_up/view/login_sign_up_view.dart';
import 'package:flutter_calculator/module/main/view/main_view.dart';
import 'package:flutter_calculator/module/setting/view/setting_view.dart';
import 'package:flutter_calculator/module/splash/view/splash_view.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBindings(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBindings(),
    ),
    GetPage(
      name: _Paths.LOGIN_SIGNUP,
      page: () => const LoginSignUpView(),
      binding: LoginSignUpBindings(),
    ),
  ];
}
