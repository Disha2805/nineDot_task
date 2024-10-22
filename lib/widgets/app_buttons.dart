import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/utils/extensions.dart';


/// App Fill Button
class AppFilledButton extends StatelessWidget {
  final double? width;
  final String title;
  final double? fontSize;
  final Widget? icon;
  final Function() onPressed;
  final EdgeInsets padding;
  const AppFilledButton({
    super.key,
    this.width,
    this.title = AppStrings.continueText,
    required this.onPressed,
    this.padding = EdgeInsets.zero, this.fontSize, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: const WidgetStatePropertyAll(Palette.primary),
          fixedSize: WidgetStatePropertyAll(Size(width ?? Get.width, 48)),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: icon ?? const SizedBox(),
            ),
            Center(
              child: title.semiBold(
                fontColor: Palette.white,
                fontSize: fontSize ?? 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


///App Back Button
class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios,
        ),
      ),
    );
  }
}
