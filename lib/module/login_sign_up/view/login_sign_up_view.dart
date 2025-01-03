import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/app_prefrance.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/login_sign_up/controller/login_sign_up_controller.dart';

class LoginSignUpView extends StatelessWidget {
  const LoginSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final appPreferences = AppPreferences();
    final localization = AppLocalizations.of(context);
    return GetBuilder(
      init: LoginSignUpController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                Assets.images.png.newSplash.path,
                fit: BoxFit.cover,
              ),
              Image.asset(
                Assets.images.png.newSplashShadow.path,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 40.h,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.png.calcuatorLogo.path,
                      height: 200,
                      width: 130,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await appPreferences.setIsFirstTime(false);
                        Get.offNamed(Routes.MAIN);
                      },
                      child: Text(
                        localization!.continueWithoutRestore,
                        style: AppTextStyles(context)
                            .display14w500
                            .copyWith(color: AppColors.whiteOff),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await appPreferences.setIsFirstTime(false);
                        final dbHelper = DatabaseHelper();
                        await dbHelper.importData();
                      },
                      child: Text(
                        localization.restoreData,
                        style: AppTextStyles(context)
                            .display14w500
                            .copyWith(color: AppColors.whiteOff),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      '© ${localization.allRights}',
                      style: AppTextStyles(context)
                          .display10w500
                          .copyWith(color: AppColors.whiteOff),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
