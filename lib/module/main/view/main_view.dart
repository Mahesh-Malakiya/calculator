import 'package:flutter/material.dart';
import 'package:flutter_calculator/common/widget/app_bottom_bar.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/module/add/view/add_view.dart';
import 'package:flutter_calculator/module/family_event_note/view/family_event_note_view.dart';
import 'package:flutter_calculator/module/main/controller/main_controller.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: MainController(),
      builder: (controller) => Scaffold(
        backgroundColor: AppColors.blackBackGround,
        body: Obx(() => controller.selectedIndex.value == 0
            ? const FamilyEventNoteView()
            : const AddView()),
        bottomNavigationBar: AppBottomBar(),
      ),
    );
  }
}
