import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/module/splash/controller/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    // final localization = AppLocalizations.of(context);
    return GetBuilder(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
            body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Image.asset(
                Assets.images.png.newSplash.path,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Image.asset(
                Assets.images.png.newSplashShadow.path,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              child: Center(
                child: Image.asset(
                  height: 200,
                  width: 130,
                  Assets.images.png.calcuatorLogo.path,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ));
      },
    );
  }
}
