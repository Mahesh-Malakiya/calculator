import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_calculator/constants/common_imports.dart';

class SelectFilter extends StatelessWidget {
  const SelectFilter({
    required this.isSelecte,
    required this.title,
    this.onTap,
    super.key,
  });

  final bool isSelecte;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h),
        child: Row(
          children: [
            SizedBox(width: 3.w),
            isSelecte
                ? SizedBox(
                    width: 4.w,
                    child: SvgPicture.asset(
                      Assets.images.icons.check,
                    ))
                : SizedBox(
                    width: 4.w,
                  ),
            SizedBox(width: 3.w),
            Text(title,
                style: AppTextStyles(context).display18w600.copyWith(
                    color: isSelecte
                        ? AppColors.whiteOff
                        : AppColors.mutedForground)),
          ],
        ),
      ),
    );
  }
}
