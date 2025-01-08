import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_calculator/module/add/controller/add_controller.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddController>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.radius_12),
        border: Border.all(color: AppColors.whiteOff.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Obx(() => TableCalendar(
                locale: 'ko',
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: controller.focusedDay.value,
                calendarFormat: CalendarFormat.week,
                selectedDayPredicate: (day) {
                  return isSameDay(day, controller.selectedDay.value);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  controller.onDaySelected(selectedDay);
                  controller.focusedDay.value = focusedDay;
                },
                onPageChanged: (focusedDay) {
                  controller.onPageChanged(focusedDay);
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    shape: BoxShape.rectangle,
                    color:
                        controller.isColorHide.value ? null : AppColors.primary,
                  ),
                  selectedDecoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    shape: BoxShape.rectangle,
                    color: AppColors.primary,
                  ),
                  defaultTextStyle:
                      AppTextStyles(context).display12w400.copyWith(
                            color: Colors.white,
                          ),
                  weekendTextStyle:
                      AppTextStyles(context).display12w400.copyWith(
                            color: Colors.white,
                          ),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle:
                      TextStyle(color: AppColors.whiteOff, fontSize: 16),
                  leftChevronIcon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.whiteOff,
                              width: 0.4,
                              style: BorderStyle.solid)),
                      child:
                          const Icon(Icons.chevron_left, color: Colors.white)),
                  rightChevronIcon: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: AppColors.whiteOff,
                              width: 0.4,
                              style: BorderStyle.solid)),
                      child:
                          const Icon(Icons.chevron_right, color: Colors.white)),
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekendStyle: AppTextStyles(context).display12w400.copyWith(
                        color: Colors.white,
                      ),
                  weekdayStyle: AppTextStyles(context).display12w400.copyWith(
                        color: Colors.white,
                      ),
                ),
              )),
        ],
      ).paddingSymmetric(horizontal: 5.w, vertical: 2.h),
    );
  }
}
