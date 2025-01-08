import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/app_prefrance.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/login_sign_up/controller/login_sign_up_controller.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class LoginSignUpView extends StatelessWidget {
  const LoginSignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    const mockUpHeight = 896;
    const mockUpWidth = 414;
    final width = MediaQuery.of(context).size.width;

    // Scale factor based on mockup width vs screen width
    final scale = mockUpWidth / width;
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
                top: 39.5.h,
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Assets.images.png.calcuatorLogo.path,
                      height: 185, // Fixed height for the logo
                      width: 119, // Fixed width for the logo
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await appPreferences.setIsFirstTime(false);
                        Get.offNamed(Routes.MAIN);
                      },
                      child: Text(
                        localization!.continueWithoutRestore,
                        style: AppTextStyles(context).display20w700.copyWith(
                            color: AppColors.whiteOff, letterSpacing: 0.1),
                      ),
                    ),
                    SizedBox(
                      height: 4.8.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await appPreferences.setIsFirstTime(false);
                        final dbHelper = DatabaseHelper();
                        await dbHelper.importData();
                      },
                      child: Text(
                        localization.restoreData,
                        style: AppTextStyles(context).display20w700.copyWith(
                            color: AppColors.whiteOff, letterSpacing: 0.1),
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      '© ${localization.allRights}',
                      style: AppTextStyles(context).display10w500.copyWith(
                          color: AppColors.whiteOff, letterSpacing: 0.1),
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
