import 'package:flutter/material.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/amount_card.dart';
import 'package:flutter_calculator/utils/extantion/enum.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FamilyEventNameWidget extends StatelessWidget {
  FamilyEventNameWidget({super.key});
  final controller = Get.find<FamilyEventNoteController>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    if (controller.selectedEventName.value == localization!.fifaOnline) {
      return ListView.separated(
        itemBuilder: (context, index) => AmountViewWiget(
          isSpent: controller.filterFifaOnlineList[index].type ==
              TransactionType.SPENT_MONEY,
          amount: controller.filterFifaOnlineList[index].amount,
          dateTime: controller.filterFifaOnlineList[index].date,
          name: controller.filterFifaOnlineList[index].name,
          relationship: controller.filterFifaOnlineList[index].relationship,
          onTap: () {
            controller.tapAmountWidget(
                index: index,
                transactionEntey: controller.filterFifaOnlineList[index]);
          },
        ).paddingSymmetric(horizontal: 4.w),
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemCount: controller.filterFifaOnlineList.length,
      );
    } else if (controller.selectedEventName.value ==
        localization.firstBirthday) {
      return ListView.separated(
        itemBuilder: (context, index) => AmountViewWiget(
          amount: controller.filterFirstBirthdayPartylIST[index].amount,
          dateTime: controller.filterFirstBirthdayPartylIST[index].date,
          name: controller.filterFirstBirthdayPartylIST[index].name,
          relationship:
              controller.filterFirstBirthdayPartylIST[index].relationship,
          onTap: () {
            controller.tapAmountWidget(
                index: index,
                transactionEntey:
                    controller.filterFirstBirthdayPartylIST[index]);
          },
        ).paddingSymmetric(horizontal: 4.w),
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemCount: controller.filterFirstBirthdayPartylIST.length,
      );
    } else {
      return ListView.separated(
        itemBuilder: (context, index) => AmountViewWiget(
          amount: controller.filterWeddingList[index].amount,
          dateTime: controller.filterWeddingList[index].date,
          name: controller.filterWeddingList[index].name,
          relationship: controller.filterWeddingList[index].relationship,
          onTap: () {
            controller.tapAmountWidget(
                index: index,
                transactionEntey: controller.filterWeddingList[index]);
          },
        ).paddingSymmetric(horizontal: 4.w),
        separatorBuilder: (context, index) => SizedBox(
          height: 1.h,
        ),
        itemCount: controller.filterWeddingList.length,
      );
    }
  }
}
