import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/amount_card.dart';
import 'package:flutter_calculator/utils/extantion/app_extantion.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MonetSpentReacive extends StatelessWidget {
  MonetSpentReacive({
    required this.total,
    required this.title,
    this.isSpent = false,
    super.key,
  });
  final String title;
  final String total;
  final bool isSpent;
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
              Text(
                title,
                style: AppTextStyles(context)
                    .display20w700
                    .copyWith(color: AppColors.whiteOff),
              ),
              const Spacer(),
              Text(
                isSpent
                    ? '- ${total.toDoubleOrNull()?.toAmount()} ${localization!.won}'
                    : '${controller.totalReceived.value.toAmount()} ${localization!.won}',
                style: AppTextStyles(context)
                    .display20w400
                    .copyWith(color: AppColors.mutedForground),
              ),
            ],
          ),
          SizedBox(
            height: 1.h,
          ),
          Obx(
            () => isSpent == true
                ? Column(
                    children: List.generate(
                      controller.spentMoneyList.length,
                      (index) {
                        final transaction = controller.spentMoneyList[index];
                        return AmountViewWiget(
                          onTap: () {
                            controller.tapAmountWidget(
                              transactionEntey: transaction,
                              index: index,
                            );
                          },
                          amount: transaction.amount,
                          dateTime: transaction.date,
                          isSpent: true,
                          name: transaction.name,
                          relationship: transaction.relationship,
                        );
                      },
                    ),
                  )
                : Column(
                    children: List.generate(
                      controller.reciveMoneyList.length,
                      (index) {
                        final transaction = controller.reciveMoneyList[index];
                        return AmountViewWiget(
                          onTap: () {
                            controller.tapAmountWidget(
                                index: index, transactionEntey: transaction);
                          },
                          amount: transaction.amount,
                          dateTime: transaction.date,
                          isSpent: false,
                          name: transaction.name,
                          relationship: transaction.relationship,
                        );
                      },
                    ),
                  ),
          )
          //
        ],
      ),
    );
  }
}
