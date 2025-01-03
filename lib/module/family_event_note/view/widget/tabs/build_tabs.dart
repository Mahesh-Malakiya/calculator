import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/tabs/compare_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/tabs/contact_widget.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/monet_spent_reacive.dart';
import 'package:flutter_calculator/constants/common_imports.dart';

class BuildAllTabs extends StatelessWidget {
  const BuildAllTabs({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final controller = Get.find<FamilyEventNoteController>();
    return Obx(
      () => controller.isSelected.value == 0
          ? MonetSpentReacive(
              title: localizations!.moneyReceived,
              total: '${controller.totalReceived.value}',
            )
          : controller.isSelected.value == 1
              ? MonetSpentReacive(
                  isSpent: true,
                  title: localizations!.moneySpent,
                  total: '${controller.totalSpent.value}',
                )
              : controller.isSelected.value == 2
                  ? CompareWidget()
                  : ContactWidget(),
    );
  }
}
