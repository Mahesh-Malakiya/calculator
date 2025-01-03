import 'package:flutter/material.dart';
import 'package:flutter_calculator/config/color/app_color.dart';
import 'package:flutter_calculator/config/color/app_text_style.dart';
import 'package:flutter_calculator/config/theme/screen_utils.dart';
import 'package:flutter_calculator/constants/common_imports.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class SquareBorderTextField extends StatelessWidget {
  const SquareBorderTextField({
    required this.textEditingController,
    required this.searchTap,
    this.hintText,
    this.labelText,
    this.enabled = true,
    this.keyboardType,
    this.withoutSerchIcon = false,
    this.focusNode,
    this.onChanged,
    this.validator, // Add validator property
    super.key,
  });

  final void Function()? searchTap;
  final TextEditingController textEditingController;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? withoutSerchIcon;
  final bool? enabled;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? Function(String?)? validator; // Validation function

  @override
  Widget build(BuildContext context) {
    TextStyle whiteTextStyle = AppTextStyles(context)
        .display20w700
        .copyWith(color: AppColors.whiteOff);

    TextStyle hintTextStyle = AppTextStyles(context)
        .display18w600
        .copyWith(color: AppColors.mutedForground);

    if (withoutSerchIcon == true) {
      return TextFormField(
        enabled: enabled,
        keyboardType: keyboardType,
        controller: textEditingController,
        style: whiteTextStyle,
        cursorColor: AppColors.primary,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 14,
          ),
          labelText: labelText,
          hintText: hintText,
          hintStyle: hintTextStyle,
          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2),
            borderRadius:
                BorderRadius.all(Radius.circular(AppSizes.radius_12 * 0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(AppSizes.radius_12 * 0.5)),
            borderSide: BorderSide(
              color: AppColors.mutedForground.withOpacity(0.4),
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: AppColors.mutedForground.withOpacity(0.4),
            ),
            borderRadius:
                BorderRadius.all(Radius.circular(AppSizes.radius_12 * 0.5)),
          ),
        ),
        validator: validator, // Use the validator here
      );
    }

    return Row(
      children: [
        Expanded(
          child: SizedBox(
            child: TextFormField(
              onChanged: onChanged,
              focusNode: focusNode,
              controller: textEditingController,
              style: whiteTextStyle,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 14,
                ),
                labelText: labelText,
                hintText: hintText,
                hintStyle: hintTextStyle,
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 2),
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius_12 * 0.5)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(AppSizes.radius_12 * 0.5)),
                  borderSide: BorderSide(
                    color: AppColors.mutedForground.withOpacity(0.4),
                    width: 2.0,
                  ),
                ),
              ),
              validator: validator,
            ),
          ),
        ),
        SizedBox(
          width: 4.w,
        ),
        GestureDetector(
          onTap: searchTap,
          child: SvgPicture.asset(Assets.images.icons.search),
        ),
      ],
    );
  }
}
