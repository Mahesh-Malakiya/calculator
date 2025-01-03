import 'package:flutter/material.dart';
import 'package:flutter_calculator/common/widget/app_appbar.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/build_search_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/view/family_event_name_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/tabs/build_tabs.dart';
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
                          BuildSearchWidget(),
                          if (controller.filteredTransactions.isEmpty)
                            Container(
                              height: 1.h,
                              color: AppColors.accent,
                            ),
                          Obx(
                            () => controller.filteredTransactions.isEmpty
                                ? const BuildAllTabs()
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
            onTap: () {},
          );
        },
      );
    });
  }
}
