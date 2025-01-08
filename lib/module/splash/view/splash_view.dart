import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/module/splash/controller/splash_controller.dart';
import 'package:pixel_perfect/pixel_perfect.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    const mockUpHeight = 896;
    const mockUpWidth = 414;
    final width = MediaQuery.of(context).size.width;

    // Scale factor based on mockup width vs screen width
    final scale = mockUpWidth / width;

    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                child: Image.asset(
                  Assets.images.png.newSplash.path,
                  fit: BoxFit
                      .cover, // Use BoxFit.cover to ensure it scales properly
                ),
              ),
              Positioned(
                child: Image.asset(
                  Assets.images.png.newSplashShadow.path,
                  fit: BoxFit
                      .cover, // Use BoxFit.cover to ensure it scales properly
                ),
              ),
              // Remove Positioned here and just center the logo directly
              Center(
                child: Image.asset(
                  Assets.images.png.calcuatorLogo.path,
                  height: 185, // Fixed height for the logo
                  width: 119, // Fixed width for the logo
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
