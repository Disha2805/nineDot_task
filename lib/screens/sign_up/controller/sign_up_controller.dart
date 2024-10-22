import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ninedot_task/api/repo/auth_repo.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/models/response_item.dart';
import 'package:ninedot_task/models/sign_up_response_model.dart';
import 'package:ninedot_task/utils/app_routes.dart';
import 'package:ninedot_task/utils/shared_prefs.dart';
import 'package:ninedot_task/widgets/app_snackbar.dart';

class SignUpController extends GetxController {

  ///TextEditing Controller
  TextEditingController numberController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();

  bool isLoading = false;
  bool isVisible = true;
  changeVisible() {
    isVisible = !isVisible;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    numberController.clear();
    fNameController.clear();
    lNameController.clear();
    emailController.clear();
    passController.clear();
  }

  /// SIGN UP METHOD
  Future<void> onSignUpMethod() async {
    isLoading = true;
    update();
    ResponseItem result = await AuthRepo.register(
      body: {
        "first_name": fNameController.text.trim(),
        "last_name": lNameController.text.trim(),
        "email_id": emailController.text.trim(),
        "mobile_no": numberController.text.trim(),
        "password": passController.text.trim(),
        "device_type": Platform.isAndroid ? "ANDROID" : "IOS",
        "device_token": preferences.getString(SharedPreference.fcmToken),
      },
    );

    try {
      if (result.status && result.data != null) {
        SignUpResModel resModel = SignUpResModel.fromJson(result.data);
        if (resModel.status!) {
          isLoading = false;
          showSnackBar(message: AppStrings.signUpSuccessText);
          preferences.putString(SharedPreference.accessToken, resModel.data!.token!.toString());
          preferences.putString(SharedPreference.userId, resModel.data!.id!.toString());
          preferences.putBool(SharedPreference.isLogin, true);
          Get.offAllNamed(Routes.home);
          update();
        } else {
          isLoading = false;
          showSnackBar(message: result.message.toString());
          update();
        }
      } else {
        isLoading = false;
        showSnackBar(message: result.message.toString());
        update();
      }
    } catch (e) {
      isLoading = false;
      showSnackBar(message: result.message.toString());
      update();
    }

    update();
  }
}
