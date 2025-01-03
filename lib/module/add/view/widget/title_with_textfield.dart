import 'package:flutter_calculator/common/widget/common_textfield.dart';
import 'package:flutter_calculator/constants/common_imports.dart';

class TitleWithTextfield extends StatelessWidget {
  const TitleWithTextfield({
    this.labelText,
    required this.textEditingController,
    required this.hintText,
    this.keyboardType,
    this.enabled = true,
    this.searchTap,
    this.title,
    this.withoutSerchIcon,
    this.validator,
    this.showErrorMessage,
    this.onChanged,
    super.key,
  });

  final TextEditingController textEditingController;
  final void Function()? searchTap;
  final String? labelText;
  final String? title;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? withoutSerchIcon;
  final bool? enabled;
  final RxBool? showErrorMessage;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: title ?? '',
                style: AppTextStyles(context)
                    .display20w700
                    .copyWith(color: AppColors.whiteOff),
              ),
              title == localization!.note
                  ? TextSpan(
                      text: '',
                      style: AppTextStyles(context)
                          .display20w700
                          .copyWith(color: Colors.red),
                    )
                  : TextSpan(
                      text: ' *',
                      style: AppTextStyles(context)
                          .display20w700
                          .copyWith(color: Colors.red),
                    ),
            ],
          ),
        ),
        SizedBox(height: 2.h),
        Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SquareBorderTextField(
            enabled: enabled,
            labelText: labelText,
            keyboardType: keyboardType,
            withoutSerchIcon: withoutSerchIcon,
            hintText: hintText,
            searchTap: searchTap,
            textEditingController: textEditingController,
            validator: validator,
            onChanged: onChanged,
          ),
        ),
      ],
    ).paddingSymmetric(horizontal: 4.w);
  }
}
