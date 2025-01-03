import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ContactWidget extends StatelessWidget {
  ContactWidget({super.key});

  final controller = Get.find<FamilyEventNoteController>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return Column(
      children: [
        Obx(
          () => controller.filterFifaOnlineList.isNotEmpty
              ? Column(
                  children: List.generate(
                    1,
                    (index) => familyCard(
                      localization: localization!,
                      context: context,
                      lenth: controller.filterFifaOnlineList.length,
                      familyEvent: localization!.fifaOnline,
                      onTap: () {
                        controller.selectedEventName.value =
                            localization.fifaOnline;
                        controller.isSelectedFamilyCard.value = true;
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.filterFirstBirthdayPartylIST.isNotEmpty
              ? Column(
                  children: List.generate(
                    1,
                    (index) => familyCard(
                      localization: localization!,
                      context: context,
                      lenth: controller.filterFirstBirthdayPartylIST.length,
                      familyEvent: localization!.firstBirthday,
                      onTap: () {
                        controller.selectedEventName.value =
                            localization.firstBirthday;
                        controller.isSelectedFamilyCard.value = true;
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Obx(
          () => controller.filterWeddingList.isNotEmpty
              ? Column(
                  children: List.generate(
                    1,
                    (index) => familyCard(
                      localization: localization!,
                      context: context,
                      lenth: controller.filterWeddingList.length,
                      familyEvent: localization!.wedding,
                      onTap: () {
                        controller.selectedEventName.value =
                            localization.wedding;
                        controller.isSelectedFamilyCard.value = true;
                      },
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget familyCard({
    required BuildContext context,
    required String familyEvent,
    required int lenth,
    required AppLocalizations localization,
    required void Function()? onTap,
  }) {
    return GestureDetector(
      // borderRadius: BorderRadius.circular(AppSizes.radius_12),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.accent,
            borderRadius: BorderRadius.circular(AppSizes.radius_8)),
        child: Row(
          children: [
            Text(
              familyEvent,
              style: AppTextStyles(context)
                  .display18w600
                  .copyWith(color: AppColors.whiteOff),
            ),
            Spacer(),
            Text('${lenth} ${localization.cases}',
                style: AppTextStyles(context)
                    .display20w400
                    .copyWith(color: AppColors.mutedForground)),
          ],
        ).paddingSymmetric(horizontal: 3.w, vertical: 2.h),
      ),
    ).paddingOnly(left: 4.w, right: 4.w, top: 2.h);
  }
}
