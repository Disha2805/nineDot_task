
import 'package:get/get.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/utils/extensions.dart';

/// Common Snack bar
SnackbarController showSnackBar({String? message}) {
  return Get.showSnackbar(
    GetSnackBar(
      messageText: (message ?? AppStrings.somethingWrongText).medium(
        fontColor: Palette.white,
        fontSize: 12,
      ),
      isDismissible: true,
      snackStyle: SnackStyle.FLOATING,
      duration: const Duration(seconds: 3),
      backgroundColor: Palette.primary,
      snackPosition: SnackPosition.TOP,
    ),
  );
}
