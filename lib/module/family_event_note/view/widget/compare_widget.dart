import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/compare_card_widget.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CompareWidget extends StatelessWidget {
  CompareWidget({super.key});
  final controller = Get.find<FamilyEventNoteController>();
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 2.h),
          Row(
            children: [
              Text(localization!.total,
                  style: AppTextStyles(context)
                      .display20w700
                      .copyWith(color: AppColors.whiteOff)),
              const Spacer(),
              Obx(
                () => Text(
                    '${controller.calculateAmountTotal.value.toAmount()} ${localization.won}',
                    style: AppTextStyles(context)
                        .display20w400
                        .copyWith(color: AppColors.mutedForground)),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              Text(localization.moneyReceived,
                  style: AppTextStyles(context)
                      .display20w700
                      .copyWith(color: AppColors.whiteOff)),
              const Spacer(),
              Obx(
                () => Text(
                    '${controller.totalReceived.value.toAmount()} ${localization.won}',
                    style: AppTextStyles(context)
                        .display20w400
                        .copyWith(color: AppColors.mutedForground)),
              ),
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            children: [
              Text(localization.moneySpent,
                  style: AppTextStyles(context)
                      .display20w700
                      .copyWith(color: AppColors.whiteOff)),
              const Spacer(),
              Obx(
                () => Text(
                    '-${controller.totalSpent.value.toAmount()} ${localization.won}',
                    style: AppTextStyles(context)
                        .display20w400
                        .copyWith(color: AppColors.mutedForground)),
              ),
            ],
          ),
          SizedBox(height: 3.h),
          Column(
            children: List.generate(
              controller.compareList.length,
              (index) => CompareCardWidget(
                dateTime: DateTime.now(),
                spentAmount: controller.compareList[index].totalSpent,
                name: controller.compareList[index].name,
                reciveAmount: controller.compareList[index].totalReceived,
                relationship: controller.compareList[index].relationship,
              ),
            ),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
