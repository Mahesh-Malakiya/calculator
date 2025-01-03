import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AmountViewWiget extends StatelessWidget {
  const AmountViewWiget({
    this.amount,
    this.dateTime,
    this.name,
    this.relationship,
    required this.onTap,
    this.isSpent = false,
    super.key,
  });
  final String? name;
  final String? relationship;
  final DateTime? dateTime;
  final double? amount;
  final bool isSpent;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      children: [
        GestureDetector(
          // borderRadius: BorderRadius.circular(AppSizes.radius_12),
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.accent,
                borderRadius: BorderRadius.circular(AppSizes.radius_8)),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                          child: Text(
                                  '${relationship?.relationshipToLocalizedString(relationship!, context)}',
                                  style: AppTextStyles(context)
                                      .display12w500
                                      .copyWith(color: AppColors.whiteOff))
                              .paddingSymmetric(horizontal: 2.w),
                        ),
                      ],
                    ),
                    if (dateTime != null)
                      Text(fdateTime(dateTime!),
                          style: AppTextStyles(context)
                              .display14w500
                              .copyWith(color: AppColors.mutedForground)),
                  ],
                ),
                const Spacer(),
                if (isSpent == true)
                  Text('- ${amount?.toAmount()} ${localization!.won}',
                      style: AppTextStyles(context)
                          .display20w400
                          .copyWith(color: AppColors.mutedForground))
                else
                  Text('${amount?.toAmount()} ${localization!.won}',
                      style: AppTextStyles(context)
                          .display20w400
                          .copyWith(color: AppColors.mutedForground))
              ],
            ).paddingSymmetric(horizontal: 3.w, vertical: 1.5.h),
          ),
        ),
        SizedBox(height: 0.8.h)
      ],
    );
  }
}

String fdateTime(DateTime date) {
  // Specify the locale as 'ko_KR' (Korean)
  return DateFormat("EEE, dd MMM. yyyy", 'ko_KR').format(date);
}
