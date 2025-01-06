import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calculator/common/widget/app_appbar.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/add/view/widget/calander.dart';
import 'package:flutter_calculator/module/add/view/widget/title_with_textfield.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/select_filter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class AddView extends StatelessWidget {
  const AddView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    return GetBuilder(
      init: AddController(),
      builder: (controller) {
        return Obx(
          () => PopScope(
            canPop: controller.mainController.selectedIndex.value == 0
                ? true
                : false,
            onPopInvoked: (didPop) {
              if (didPop) {
                // Exit App : show snackbar : Tap again to exit app
                // controller.mainController.showExitSnackBar(context);
                // exit(0);
              } else {
                if (controller.isEditable.value) {
                  log('before : controller.mainController.selectedIndex ::: ${controller.mainController.selectedIndex.value}');
                  controller.mainController.changeIndex(0);
                  controller.isEditable.value = false;
                  controller.clearForm();
                  controller.isSelectedFamily.value = -1;
                  controller.isSelectedRelation.value = -1;
                  controller.isTappedEditSave.value = 0;
                  log('after : controller.mainController.selectedIndex ::: ${controller.mainController.selectedIndex.value}');
                }
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AppAppBar(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                          color: AppColors.blackBackGround,
                          borderRadius:
                              BorderRadius.circular(AppSizes.radius_8)),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                controller.isEditable.value
                                    ? localization!.edit
                                    : localization!.add,
                                style: AppTextStyles(context)
                                    .display20w700
                                    .copyWith(color: AppColors.whiteOff),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radius_8)),
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.filterItems.length,
                                  padding: EdgeInsets.symmetric(vertical: 2.h),
                                  itemBuilder: (context, index) => Obx(
                                    () => SelectFilter(
                                      onTap: () {
                                        controller.isSelected.value = index;

                                        controller.updateTransactionType(
                                          index: index,
                                        );
                                      },
                                      isSelecte:
                                          index == controller.isSelected.value
                                              ? true
                                              : false,
                                      title: controller.filterItems[index],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 4.w),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            color: AppColors.accent,
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: localization.date,
                                      style: AppTextStyles(context)
                                          .display20w700
                                          .copyWith(
                                              color: AppColors
                                                  .whiteOff), // 'name' is white
                                    ),
                                    TextSpan(
                                        text: ' *',
                                        style: AppTextStyles(context)
                                            .display20w700
                                            .copyWith(
                                                color: Colors.red) // '*' is red
                                        ),
                                  ],
                                ),
                              ),
                            ],
                          ).paddingSymmetric(horizontal: 4.w),
                          SizedBox(
                            height: 2.h,
                          ),
                          CalendarView().paddingSymmetric(horizontal: 4.w),
                          SizedBox(
                            height: 2.h,
                          ),
                          TitleWithTextfield(
                            withoutSerchIcon: true,
                            title: localization.name,
                            hintText: localization.enterName,
                            textEditingController: controller.nameController,
                            showErrorMessage: controller
                                .showErrorMessageName, // Pass RxBool here

                            onChanged: (value) {
                              controller.clearErrorStates('name');
                            },
                          ),
                          TitleWithTextfield(
                            keyboardType: TextInputType.number,
                            withoutSerchIcon: true,
                            title: localization.amount,
                            hintText: localization.entAmount,
                            textEditingController: controller.amountController,
                            showErrorMessage: controller
                                .showErrorMessageAmount, // Pass RxBool here
                            onChanged: (value) {
                              if (value == null || value.isEmpty) {
                                controller.showErrorMessageAmount.value = true;
                                return 'Name cannot be empty';
                              }
                              controller.showErrorMessageAmount.value = false;
                              return null;
                            },
                          ),
                          TitleWithTextfield(
                            keyboardType: TextInputType.phone,
                            withoutSerchIcon: true,
                            title: localization.phoneNumber,
                            hintText: localization.onlyNumbers,
                            textEditingController:
                                controller.phoneNumberController,
                            showErrorMessage: controller
                                .showErrorMessagePhone, // Pass RxBool here
                            onChanged: (value) {
                              controller.clearErrorStates('amount');
                            },
                          ),
                          TitleWithTextfield(
                            enabled: true,
                            withoutSerchIcon: true,
                            title: localization.familyEventsSelect,
                            hintText: localization.enterFamilyEvent,

                            textEditingController:
                                controller.familyEventSelectController.value,
                            showErrorMessage: controller
                                .showErrorMessageevent, // Pass RxBool here
                            onChanged: (value) {
                              if (value == null || value.isEmpty) {
                                controller.showErrorMessageevent.value = true;
                                return 'Name cannot be empty';
                              }
                              controller.showErrorMessageevent.value = false;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radius_8)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.eventSelect.length,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              itemBuilder: (context, index) => Obx(
                                () => SelectFilter(
                                  onTap: () {
                                    controller.isSelectedFamily.value = index;
                                    controller.familyEventSelectController.value
                                        .text = controller.eventSelect[index];
                                  },
                                  isSelecte:
                                      index == controller.isSelectedFamily.value
                                          ? true
                                          : false,
                                  title: controller.eventSelect[index],
                                ),
                              ),
                            ),
                          ).paddingSymmetric(horizontal: 4.w),
                          TitleWithTextfield(
                            enabled: true,
                            withoutSerchIcon: true,
                            title: localization.relationshipSelect,
                            hintText: localization.enterrelationship,
                            textEditingController:
                                controller.relationShipSelectController.value,
                            onChanged: (inputText) {
                              controller.isSelectedRelation.value = -1;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radius_8)),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: controller.relationshipSelect.length,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              itemBuilder: (context, index) => Obx(
                                () => SelectFilter(
                                  onTap: () {
                                    controller.isSelectedRelation.value = index;
                                    controller.relationShipSelectController
                                            .value.text =
                                        controller.relationshipSelect[index];
                                  },
                                  isSelecte: index ==
                                          controller.isSelectedRelation.value
                                      ? true
                                      : false,
                                  title: controller.relationshipSelect[index],
                                ),
                              ),
                            ),
                          ).paddingSymmetric(horizontal: 4.w),
                          TitleWithTextfield(
                            withoutSerchIcon: true,
                            title: localization.note,
                            hintText: localization.enterNote,
                            textEditingController: controller.noteController,
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                controller.validateForm();
                              },
                              child: Container(
                                width: 92.w,
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(
                                        AppSizes.radius_12)),
                                child: Text(
                                  controller.isEditable.value
                                      ? localization.edit
                                      : localization.save,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles(context)
                                      .display20w700
                                      .copyWith(color: AppColors.whiteOff),
                                ).paddingSymmetric(vertical: 1.5.h),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
