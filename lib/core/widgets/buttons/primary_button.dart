import 'package:clean_architecture_template/core/style/colors.dart';
import 'package:clean_architecture_template/core/style/text_styles.dart';
import 'package:clean_architecture_template/core/widgets/buttons/button_filled.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onTap,
      this.active = true,
      this.textColor = CColors.white,
      this.backgroundColor = CColors.green,
      this.icon});

  final String title;
  final VoidCallback? onTap;
  final bool active;
  final Color textColor;
  final Color backgroundColor;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return BaseFilledButton(
      active: active,
      enabledColor: backgroundColor,
      disabledColor: CColors.grayDisabledLink,
      padding: EdgeInsets.zero,
      tapColor: CColors.grey.withOpacity(0.2),
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          if (icon != null)
            const SizedBox(
              width: 10,
            ),
          Text(
            title,
            style: CTextStyle.buttonsText
                .copyWith(color: active ? textColor : CColors.black),
          ),
        ],
      ),
    );
  }
}
