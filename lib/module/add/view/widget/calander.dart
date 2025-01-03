import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: true,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius_12),
          border: Border.all(color: AppColors.whiteOff.withOpacity(0.5)),
        ),
        child: Column(
          children: [
            TableCalendar(
              locale: 'ko',
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: DateTime.now(),
              calendarFormat: CalendarFormat.week,
              selectedDayPredicate: (day) {
                return isSameDay(day, DateTime.now());
              },
              onDaySelected: (_, __) {},
              onPageChanged: (_) {},
              availableGestures: AvailableGestures.none, // Disable gestures
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: AppColors.primary,
                ),
                selectedDecoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  shape: BoxShape.rectangle,
                  color: AppColors.primary,
                ),
                defaultTextStyle: AppTextStyles(context).display12w400.copyWith(
                      color: Colors.white,
                    ),
                weekendTextStyle: AppTextStyles(context).display12w400.copyWith(
                      color: Colors.white,
                    ),
              ),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: TextStyle(color: Colors.white, fontSize: 16),
                leftChevronVisible: false, // Disable left navigation
                rightChevronVisible: false, // Disable right navigation
              ),
              daysOfWeekStyle: DaysOfWeekStyle(
                weekendStyle: AppTextStyles(context).display12w400.copyWith(
                      color: Colors.white,
                    ),
                weekdayStyle: AppTextStyles(context).display12w400.copyWith(
                      color: Colors.white,
                    ),
              ),
            )
          ],
        ).paddingSymmetric(horizontal: 5.w, vertical: 2.h),
      ),
    );
  }
}
