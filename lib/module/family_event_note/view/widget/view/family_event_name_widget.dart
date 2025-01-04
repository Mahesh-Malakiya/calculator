import 'package:flutter/material.dart';
import 'package:flutter_calculator/module/add/model/add_model.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/amount_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class FamilyEventNameWidget extends StatelessWidget {
  FamilyEventNameWidget({super.key});
  final controller = Get.find<FamilyEventNoteController>();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);

    // Get the selected event's transactions from the controller
    List<TransactionEntry> selectedTransactions = controller
            .categorizedTransactions[controller.selectedEventName.value] ??
        [];

    return ListView.separated(
      itemBuilder: (context, index) {
        // Get the transaction at the current index
        TransactionEntry transaction = selectedTransactions[index];

        return AmountViewWiget(
          amount: transaction.amount,
          dateTime: transaction.date,
          name: transaction.name,
          relationship: transaction.relationship,
          onTap: () {
            controller.isSelectedFamilyCard.value = false;
            controller.tapAmountWidget(
                index: index, transactionEntey: transaction);
          },
        ).paddingSymmetric(horizontal: 4.w);
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 1.h,
      ),
      itemCount: selectedTransactions.length,
    );
  }
}
