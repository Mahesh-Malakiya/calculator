import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_svg/svg.dart';

class AppAppBar extends StatelessWidget {
  const AppAppBar({
    this.istappedSetting = true,
    super.key,
  });
  final bool? istappedSetting;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.blackBackGround,
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            Assets.images.png.appbarLogo.path,
            height: 38,
            width: 25,
            fit: BoxFit.contain,
          ),
          GestureDetector(
              onTap: () {
                if (istappedSetting == true) {
                  Get.toNamed(Routes.SETTING);
                }
              },
              child: SvgPicture.asset(Assets.images.icons.setting)),
        ],
      ),
    );
  }
}
