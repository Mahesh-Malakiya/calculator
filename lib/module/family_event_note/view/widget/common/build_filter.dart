import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/family_event_note/view/widget/common/select_filter.dart';
import 'package:flutter_calculator/constants/common_imports.dart';

class BuildFilter extends StatelessWidget {
  const BuildFilter({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FamilyEventNoteController>();
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(AppSizes.radius_8),
      ),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 4,
        padding: EdgeInsets.symmetric(vertical: 2.h),
        itemBuilder: (context, index) => Obx(
          () => SelectFilter(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              controller.isSelected.value = index;
              controller.textEditingController.clear();
            },
            isSelecte: index == controller.isSelected.value ? true : false,
            title: controller.filterItems[index],
          ),
        ),
      ),
    );
  }
}
