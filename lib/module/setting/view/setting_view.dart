import 'package:flutter_calculator/common/widget/app_appbar.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/data/database_helper.dart';
import 'package:flutter_calculator/module/family_event_note/controller/family_event_note_controller.dart';
import 'package:flutter_calculator/module/setting/controller/setting_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final familyController = Get.find<FamilyEventNoteController>();
    return GetBuilder(
        init: SettingController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.blackBackGround,
              body: Column(
                children: [
                  const AppAppBar(
                    istappedSetting: false,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              color: AppColors.whiteOff,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            localizations!.setting,
                            style: AppTextStyles(context)
                                .display20w700
                                .copyWith(color: AppColors.whiteOff),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(
                              'assets/images/icons/app_setting.svg'),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            localizations.appsettings,
                            style: AppTextStyles(context)
                                .display18w600
                                .copyWith(color: AppColors.mutedForground),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final dbHelper = DatabaseHelper();
                          // Use Future.microtask to delay the operation slightly
                          Future.microtask(() async {
                            await dbHelper.importData();
                            familyController.getAddFunction();
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              localizations.restoreData,
                              style: AppTextStyles(context)
                                  .display18w600
                                  .copyWith(color: AppColors.whiteOff),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                                    'assets/images/icons/right_arrow.svg')
                                .paddingSymmetric(horizontal: 2.w),
                          ],
                        ).paddingOnly(
                          left: 2.w,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final dbHelper = DatabaseHelper();
                          await dbHelper.requestStoragePermission(context);
                        },
                        child: Row(
                          children: [
                            Text(
                              localizations.backupdata,
                              style: AppTextStyles(context)
                                  .display18w600
                                  .copyWith(color: AppColors.whiteOff),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                                    'assets/images/icons/right_arrow.svg')
                                .paddingSymmetric(horizontal: 2.w),
                          ],
                        ).paddingOnly(
                          left: 2.w,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // Show a confirmation dialog before resetting
                          Get.dialog(
                            AlertDialog(
                              title: Text('확인'),
                              content: Text('데이터를 재설정하시겠습니까?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back(); // Close the dialog if the user cancels
                                  },
                                  child: Text('취소'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    final dbHelper = DatabaseHelper();
                                    await controller.appPreferences
                                        .setIsFirstTime(true);
                                    await dbHelper.deleteAllTransactions().then(
                                      (value) {
                                        familyController.getAddFunction();
                                        familyController.totalReceived.value =
                                            0;
                                        familyController.totalSpent.value = 0;

                                        Get.offAllNamed(Routes.LOGIN_SIGNUP);
                                      },
                                    );
                                  },
                                  child: Text('확인'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              localizations.reset,
                              style: AppTextStyles(context)
                                  .display18w600
                                  .copyWith(color: AppColors.whiteOff),
                            ),
                            Spacer(),
                            SvgPicture.asset(
                                    'assets/images/icons/right_arrow.svg')
                                .paddingSymmetric(horizontal: 2.w),
                          ],
                        ).paddingOnly(left: 2.w),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Row(
                        children: [
                          Text(
                            localizations.appversion,
                            style: AppTextStyles(context)
                                .display18w600
                                .copyWith(color: AppColors.whiteOff),
                          ),
                          const Spacer(),
                          Obx(
                            () {
                              if (controller.appVersionStatus.value
                                      ?.localVersion.isNotEmpty ??
                                  false) {
                                return Text(
                                  controller.appVersionStatus.value
                                          ?.localVersion ??
                                      '',
                                  style: AppTextStyles(context)
                                      .display18w600
                                      .copyWith(color: AppColors.whiteOff),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ).paddingOnly(
                        left: 2.w,
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 4.w),
                ],
              ),
            ));
  }
}
