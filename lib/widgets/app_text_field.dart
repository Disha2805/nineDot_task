import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_text_styles.dart';

///Common Text Field
class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;
  final String title;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final bool isNumber;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatter;
  String? Function(String?)? validator;
  CommonTextField({
    super.key,
    required this.textInputType,
    this.onChanged,
    required this.controller,
    this.suffixIcon,
    required this.title,
    this.textStyle,
    this.hintStyle,
    this.textCapitalization = TextCapitalization.none,
    this.isNumber = false,
    this.obscureText = false,
    this.inputFormatter,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: TextFormField(
        textCapitalization: textCapitalization,
        validator: validator,
        cursorColor: Palette.appTextColor,
        keyboardType: textInputType,
        onChanged: onChanged,
        controller: controller,
        obscureText: obscureText,
        style: textStyle ?? CommonTextStyles.kBlack16Medium,
        inputFormatters: isNumber
            ? <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                LengthLimitingTextInputFormatter(10)
              ]
            : inputFormatter,
        decoration: InputDecoration(
          labelStyle: CommonTextStyles.kGrey16Medium,
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Palette.black, width: 1.5),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: Palette.greyText, width: 1),
          ),
          suffixIcon: suffixIcon,
          hintStyle: hintStyle ?? CommonTextStyles.kGrey16Medium,
          hintText: title,
          counterText: "",
        ),
      ),
    );
  }
}
