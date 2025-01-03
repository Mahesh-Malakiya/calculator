import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/gen/assets.gen.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AppBottomBar extends StatelessWidget {
  AppBottomBar({
    super.key,
  });
  final controller = Get.find<MainController>();
  final familyController = Get.isRegistered<FamilyEventNoteController>()
      ? Get.find<FamilyEventNoteController>()
      : Get.put<FamilyEventNoteController>(FamilyEventNoteController());
  final addController = Get.isRegistered<AddController>()
      ? Get.find<AddController>()
      : Get.put<AddController>(AddController());

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Container(
      height: 8.h,
      color: AppColors.darkBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              familyController.totalSpent = RxDouble(0);
              familyController.totalReceived = RxDouble(0);
              controller.selectedIndex.value = 0;
              addController.transactionType.value =
                  TransactionType.RECIVED_MONEY;
              addController.relationship.value = Relationship.WORK.name;
              addController.familyEvent.value = FamilyEvent.FIFA_ONLINE.name;
              familyController.getAddFunction();
              addController.isEditable.value = false;
              addController.nameController.clear();
              addController.amountController.clear();
              addController.phoneNumberController.clear();
              addController.noteController.clear();
            },
            child: SizedBox(
              width: 50.w,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.icons.menu,
                      // 'assets/images/icons/menu.svg',
                      color: controller.selectedIndex.value == 0
                          ? AppColors.primary
                          : AppColors.whiteOff,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      localization!.familyEventsNote,
                      style: TextStyle(
                        color: controller.selectedIndex.value == 0
                            ? AppColors.primary
                            : AppColors.whiteOff,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.selectedIndex.value = 1;
            },
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 50.w,
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      Assets.images.icons.add,
                      // 'assets/images/icons/add.svg',
                      color: controller.selectedIndex.value == 1
                          ? AppColors.primary
                          : AppColors.whiteOff,
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      localization!.add,
                      style: TextStyle(
                        color: controller.selectedIndex.value == 1
                            ? AppColors.primary
                            : AppColors.whiteOff,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
