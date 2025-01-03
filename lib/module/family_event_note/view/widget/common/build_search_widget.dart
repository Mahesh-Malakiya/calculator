import 'package:flutter_calculator/common/widget/common_textfield.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/amount_card.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/build_filter.dart';

class BuildSearchWidget extends StatelessWidget {
  const BuildSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final controller = Get.find<FamilyEventNoteController>();
    return Padding(
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
              controller
                  .searchTransactions(controller.textEditingController.text);
              controller.textEditingController.text.isEmpty
                  ? controller.filteredTransactions.clear()
                  : null;
            },
            // focusNode: controller.textFocusNode,
            hintText: localizations.searchByName,
            searchTap: () {
              // controller.textFocusNode.unfocus();
              controller
                  .searchTransactions(controller.textEditingController.text);
              controller.textEditingController.text.isEmpty
                  ? controller.filteredTransactions.clear()
                  : null;
            },
            textEditingController: controller.textEditingController,
          ),
          SizedBox(height: 2.h),
          controller.filteredTransactions.isNotEmpty
              ? Column(
                  children: List.generate(
                    controller.filteredTransactions.length,
                    (index) => AmountViewWiget(
                      onTap: () {
                        controller.tapAmountWidget(
                            index: index,
                            transactionEntey:
                                controller.filteredTransactions[index]);
                      },
                      amount: controller.filteredTransactions[index].amount,
                      dateTime: controller.filteredTransactions[index].date,
                      name: controller.filteredTransactions[index].name,
                      relationship:
                          controller.filteredTransactions[index].relationship,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
          Obx(
            () => controller.filteredTransactions.isEmpty
                ? const BuildFilter()
                : const SizedBox.shrink(),
          ),
          Obx(() => controller.filteredTransactions.isEmpty
              ? SizedBox(height: 2.h)
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
