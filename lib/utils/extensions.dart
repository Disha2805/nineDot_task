import 'package:flutter/material.dart';
import 'package:ninedot_task/constant/app_color.dart';

extension SizedExtension on double {
  addHSpace() {
    return SizedBox(height: this);
  }

  addWSpace() {
    return SizedBox(width: this);
  }
}

extension PTextStyle on String {

  /// w400
  Widget regular({
    Color fontColor = Palette.appTextColor,
    double? fontSize,
    double? height,
    TextDecoration textDecoration = TextDecoration.none,
    TextOverflow? textOverflow,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w400,
        decoration: textDecoration,
        fontStyle:  FontStyle.normal,
      ),
    );
  }

  /// w500
  Widget medium({
    Color fontColor = Palette.appTextColor,
    double? fontSize,
    double? height,
    TextDecoration textDecoration = TextDecoration.none,
    TextOverflow? textOverflow,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w500,
        decoration: textDecoration,
        fontStyle:  FontStyle.normal,
      ),
    );
  }

  /// w600
  Widget semiBold({
    Color fontColor = Palette.appTextColor,
    double? fontSize,
    double? height,
    TextDecoration textDecoration = TextDecoration.none,
    TextOverflow? textOverflow,
    TextAlign? textAlign,
  }) {
    return Text(
      this,
      overflow: textOverflow,
      textAlign: textAlign,
      style: TextStyle(
        height: height,
        color: fontColor,
        fontSize: fontSize ?? 16,
        fontWeight: FontWeight.w600,
        decoration: textDecoration,
        fontStyle: FontStyle.normal,
      ),
    );
  }

}
