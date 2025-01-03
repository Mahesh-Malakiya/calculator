import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/amount_card.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_calculator/constants/common_imports.dart';

class CompareCardWidget extends StatelessWidget {
  const CompareCardWidget({
    this.reciveAmount,
    this.spentAmount,
    this.dateTime,
    this.name,
    this.relationship,
    super.key,
  });
  final String? name;
  final String? relationship;
  final DateTime? dateTime;
  final double? spentAmount;
  final double? reciveAmount;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return GestureDetector(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(
                  AppSizes.radius_8,
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name ?? '',
                        style: AppTextStyles(context)
                            .display18w600
                            .copyWith(color: AppColors.whiteOff)),
                    SizedBox(
                      width: 2.w,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radius_12)),
                      child: Text('$relationship',
                              style: AppTextStyles(context)
                                  .display12w500
                                  .copyWith(color: AppColors.whiteOff))
                          .paddingSymmetric(horizontal: 2.w),
                    ),
                    const Spacer(),
                    Text('+${reciveAmount?.toAmount()} ${localization!.won}',
                        style: AppTextStyles(context).display12w500.copyWith(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                if (dateTime != null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(fdateTime(dateTime!),
                          style: AppTextStyles(context)
                              .display14w500
                              .copyWith(color: AppColors.mutedForground)),
                      Text('-${spentAmount?.toAmount()} ${localization.won}',
                          style: AppTextStyles(context).display12w500.copyWith(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
              ],
            ).paddingSymmetric(horizontal: 3.w, vertical: 1.5.h),
          ),
          SizedBox(height: 2.h)
        ],
      ),
    );
  }
}
