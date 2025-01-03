import 'package:flutter/material.dart';
import 'package:flutter_calculator/common/widget/app_appbar.dart';
import 'package:flutter_calculator/common/widget/common_textfield.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/amount_card.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/compare_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/contact_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/family_event_name_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/monet_spent_reacive.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/select_filter.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FamilyEventNoteView extends StatelessWidget {
  const FamilyEventNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final controller = Get.put(FamilyEventNoteController());

    return PopScope(
      onPopInvoked: (didPop) {
        controller.isSelectedFamilyCard.value = false;
      },
      canPop: false,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppAppBar(),
            controller.isSelectedFamilyCard.value
                ? Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.isSelectedFamilyCard.value = false;
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.whiteOff,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            controller.selectedEventName.value,
                            style: AppTextStyles(context)
                                .display20w700
                                .copyWith(color: AppColors.whiteOff),
                          )
                        ],
                      ).paddingSymmetric(
                        horizontal: 4.w,
                      ),
                    ],
                  )
                : SizedBox(height: 2.h),
            controller.isSelectedFamilyCard.value
                ? Expanded(child: FamilyEventNameWidget())
                : Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  localizations!.searchCriteria,
                                  style: AppTextStyles(context)
                                      .display20w700
                                      .copyWith(color: AppColors.whiteOff),
                                ),
                                SizedBox(height: 1.5.h),
                                SquareBorderTextField(
                                  onChanged: (p0) {
                                    controller.searchTransactions(
                                        controller.textEditingController.text);
                                    controller
                                            .textEditingController.text.isEmpty
                                        ? controller.filteredTransactions
                                            .clear()
                                        : null;
                                  },
                                  // focusNode: controller.textFocusNode,
                                  hintText: localizations.searchByName,
                                  searchTap: () {
                                    // controller.textFocusNode.unfocus();
                                    controller.searchTransactions(
                                        controller.textEditingController.text);
                                    controller
                                            .textEditingController.text.isEmpty
                                        ? controller.filteredTransactions
                                            .clear()
                                        : null;
                                  },
                                  textEditingController:
                                      controller.textEditingController,
                                ),
                                SizedBox(height: 2.h),
                                controller.filteredTransactions.isNotEmpty
                                    ? Column(
                                        children: List.generate(
                                          controller
                                              .filteredTransactions.length,
                                          (index) => AmountViewWiget(
                                            onTap: () {
                                              controller.tapAmountWidget(
                                                  index: index,
                                                  transactionEntey: controller
                                                          .filteredTransactions[
                                                      index]);
                                            },
                                            amount: controller
                                                .filteredTransactions[index]
                                                .amount,
                                            dateTime: controller
                                                .filteredTransactions[index]
                                                .date,
                                            name: controller
                                                .filteredTransactions[index]
                                                .name,
                                            relationship: controller
                                                .filteredTransactions[index]
                                                .relationship,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                Obx(
                                  () => controller.filteredTransactions.isEmpty
                                      ? Container(
                                          height: 25.h,
                                          decoration: BoxDecoration(
                                            color: AppColors.accent,
                                            borderRadius: BorderRadius.circular(
                                                AppSizes.radius_8),
                                          ),
                                          child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: 4,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 2.h),
                                            itemBuilder: (context, index) =>
                                                Obx(
                                              () => SelectFilter(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          FocusNode());
                                                  controller.isSelected.value =
                                                      index;
                                                  controller
                                                      .textEditingController
                                                      .clear();
                                                },
                                                isSelecte: index ==
                                                        controller
                                                            .isSelected.value
                                                    ? true
                                                    : false,
                                                title: controller
                                                    .filterItems[index]
                                                    .toFilterItemsAppLocalizations(
                                                        context),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ),
                                Obx(() =>
                                    controller.filteredTransactions.isEmpty
                                        ? SizedBox(height: 2.h)
                                        : const SizedBox.shrink()),
                              ],
                            ),
                          ),
                          if (controller.filteredTransactions.isEmpty)
                            Container(
                              height: 1.h,
                              color: AppColors.accent,
                            ),
                          Obx(
                            () => controller.filteredTransactions.isEmpty
                                ? Obx(
                                    () => controller.isSelected.value == 0
                                        ? MonetSpentReacive(
                                            title: localizations.moneyReceived,
                                            total:
                                                '${controller.totalReceived.value}',
                                          )
                                        : controller.isSelected.value == 1
                                            ? MonetSpentReacive(
                                                isSpent: true,
                                                title: localizations.moneySpent,
                                                total:
                                                    '${controller.totalSpent.value}',
                                              )
                                            : controller.isSelected.value == 2
                                                ? CompareWidget()
                                                : ContactWidget(),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          SizedBox(
                            height: 2.h,
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class TransactionListScreen extends StatelessWidget {
  final AddController addController = Get.find();

  TransactionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (addController.transaction.isEmpty) {
        return Center(
            child: Text(
          "No transactions available.",
          style: TextStyle(color: AppColors.whiteOff),
        ));
      }

      return ListView.builder(
        itemCount: addController.transaction.length,
        itemBuilder: (context, index) {
          final transaction = addController.transaction[index];
          return ListTile(
            title: Text(transaction.name),
            subtitle: Text(
              "${transaction.amount} - ${transaction.type.toString().split('.').last}",
            ),
            leading: const Icon(Icons.monetization_on),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Handle tap if needed (e.g., navigate to details screen)
            },
          );
        },
      );
    });
  }
}
