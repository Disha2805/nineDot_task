import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninedot_task/api/repo/auth_repo.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/models/login_response_model.dart';
import 'package:ninedot_task/models/response_item.dart';
import 'package:ninedot_task/utils/app_routes.dart';
import 'package:ninedot_task/utils/shared_prefs.dart';
import 'package:ninedot_task/widgets/app_snackbar.dart';

class LoginController extends GetxController {
  ///TextEditing Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoading = false;

  /// Password Visibility
  bool isVisible = true;
  changeVisible() {
    isVisible = !isVisible;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    emailController.clear();
    passController.clear();
  }

  /// LOGIN METHOD
  Future<void> onLoginMethod() async {
    isLoading = true;
    update();
    ResponseItem result = await AuthRepo.login(body: {
      "email": emailController.text.trim(),
      "password": passController.text.trim()
    });
    try {
      if (result.status && result.data != null) {
        LoginResModel resModel = LoginResModel.fromJson(result.data);
        if (result.data["status"]) {
          isLoading = false;
          showSnackBar(message: AppStrings.loginSuccessText);
          preferences.putString(
              SharedPreference.accessToken, resModel.data!.token!.toString());
          preferences.putString(
              SharedPreference.userId, resModel.data!.id!.toString());
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
      update();
    } catch (e) {
      isLoading = false;
      showSnackBar(message: result.message.toString());
      update();
    }
    update();
  }
}
