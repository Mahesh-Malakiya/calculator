import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles(this.context) {
    display10w500 = const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w500,
      fontFamily: 'Pretendard',
    );
    display12w400 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Pretendard',
    );
    display12w500 = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: 'Pretendard',
    );
    display14w400 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      fontFamily: 'Pretendard',
    );
    display14w500 = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Pretendard',
    );
    display16w700 = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Pretendard',
    );
    display18w600 = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      fontFamily: 'Pretendard',
    );
    display20w400 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      fontFamily: 'Pretendard',
    );
    display20w700 = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'Pretendard',
    );
  }
  final BuildContext? context;
  late final TextStyle display10w500;
  late final TextStyle display12w400;
  late final TextStyle display12w500;
  late final TextStyle display14w400;
  late final TextStyle display14w500;
  late final TextStyle display16w700;
  late final TextStyle display18w600;
  late final TextStyle display20w400;
  late final TextStyle display20w700;
}
