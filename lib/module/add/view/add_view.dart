import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_calculator/common/widget/app_appbar.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/add/view/widget/calander.dart';
import 'package:flutter_calculator/module/add/view/widget/title_with_textfield.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/select_filter.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

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
            canPop: false,
            onPopInvoked: (didPop) {
              if (didPop) {
                if (controller.isEditable.value) {
                  controller.mainController.changeIndex(0);
                  log('message');
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
                                          index: controller.isSelected.value,
                                        );
                                      },
                                      isSelecte:
                                          index == controller.isSelected.value
                                              ? true
                                              : false,
                                      title: controller.filterItems[index]
                                          .toTransactionTyoeLocalization(
                                              context),
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
                            labelText: '',
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
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radius_8)),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.eventSelect.length,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              itemBuilder: (context, index) => Obx(
                                () => SelectFilter(
                                  onTap: () {
                                    controller.updateFamilyTextField(context);
                                  },
                                  isSelecte:
                                      index == controller.isSelectedFamily.value
                                          ? true
                                          : false,
                                  title: controller.eventSelect[index]
                                      .toEventExtensionApplocalizations(
                                          context),
                                ),
                              ),
                            ),
                          ).paddingSymmetric(horizontal: 4.w),
                          TitleWithTextfield(
                            enabled: false,
                            withoutSerchIcon: true,
                            title: localization.relationshipSelect,
                            hintText: localization.relationshipSelect,
                            textEditingController:
                                controller.relationShipSelectController.value,
                            showErrorMessage: controller
                                .showErrorMessagerelation, // Pass RxBool here
                            onChanged: (value) {
                              if (value == null || value.isEmpty) {
                                controller.showErrorMessagerelation.value =
                                    true;
                                return 'Name cannot be empty';
                              }
                              controller.showErrorMessagerelation.value = false;
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: AppColors.accent,
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radius_8)),
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: controller.relationshipSelect.length,
                              padding: EdgeInsets.symmetric(vertical: 2.h),
                              itemBuilder: (context, index) => Obx(
                                () => SelectFilter(
                                  onTap: () {
                                    controller.isSelectedRelation.value = index;
                                    controller.updateRelationTextField();
                                    controller.updaterelationship(
                                        controller.isSelectedRelation.value);
                                  },
                                  isSelecte: index ==
                                          controller.isSelectedRelation.value
                                      ? true
                                      : false,
                                  title: controller.relationshipSelect[index]
                                      .toRelationExtensionApplocalizations(
                                          context),
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
