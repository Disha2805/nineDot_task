import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/constant/app_validation.dart';
import 'package:ninedot_task/screens/sign_up/controller/sign_up_controller.dart';
import 'package:ninedot_task/utils/extensions.dart';
import 'package:ninedot_task/widgets/app_buttons.dart';
import 'package:ninedot_task/widgets/app_conditional_widget.dart';
import 'package:ninedot_task/widgets/app_loader.dart';
import 'package:ninedot_task/widgets/app_text_field.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Back Button
                      (height * 0.01).addHSpace(),
                      const AppBackButton(),

                      ///Title
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: AppStrings.signUp.semiBold(fontSize: 24),
                      ),
                      (height * 0.02).addHSpace(),

                      /// First Name Field
                      CommonTextField(
                        controller: controller.fNameController,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return AppStrings.enterFName;
                          }
                          return null;
                        },
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        title: AppStrings.enterFName,
                        onChanged: (value) => controller.update(),
                      ),
                      (height * 0.02).addHSpace(),

                      /// Last Name Field
                      CommonTextField(
                        controller: controller.lNameController,
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        title: AppStrings.enterLName,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return AppStrings.enterLName;
                          }
                          return null;
                        },
                        onChanged: (value) => controller.update(),
                      ),
                      (height * 0.02).addHSpace(),

                      /// Email Field
                      CommonTextField(
                        controller: controller.emailController,
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.emailAddress,
                        title: AppStrings.email,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return AppStrings.email;
                          }
                          return null;
                        },
                        onChanged: (value) => controller.update(),
                      ),
                      (height * 0.02).addHSpace(),

                      /// Mobile Number Field
                      CommonTextField(
                        controller: controller.numberController,
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.phone,
                        title: AppStrings.mobNo,
                        validator: (p0) {
                          if (p0!.isEmpty) {
                            return AppStrings.mobNo;
                          } else if (p0.length < 10) {
                            return AppStrings.validMobNo;
                          }
                          return null;
                        },
                        isNumber: true,
                        onChanged: (value) => controller.update(),
                      ),
                      (height * 0.02).addHSpace(),

                      /// Password Field
                      CommonTextField(
                        controller: controller.passController,
                        textCapitalization: TextCapitalization.words,
                        textInputType: TextInputType.text,
                        title: AppStrings.password,
                        validator: validatePassword,
                        obscureText: controller.isVisible,
                        suffixIcon: InkWell(
                            overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            onTap: () {
                              controller.changeVisible();
                            },
                            child: Icon(controller.isVisible
                                ? Icons.visibility_off
                                : Icons.visibility_sharp)),
                        onChanged: (value) => controller.update(),
                      ),
                      SizedBox(
                          height: Get.height / (Platform.isIOS ? 4.5 : 4.5)),

                      ///Login Button
                      const LoginButton(),

                      ///Sign up Button
                      SignUpButton(controller: controller),
                      (height * 0.02).addHSpace(),

                      ///Bottom
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppStrings.alreadyAccount.regular(
          fontColor: Palette.greyText,
          fontSize: 12,
        ),
        (Get.width * 0.01).addWSpace(),
        InkWell(
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          onTap: () => Get.back(),
          child: AppStrings.login.medium(
            fontColor: Palette.primary,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}

class SignUpButton extends StatelessWidget {
  final SignUpController controller;

  const SignUpButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return If(
      condition: !controller.isLoading,
      child: (context) => AppFilledButton(
        padding: const EdgeInsets.only(top: 15),
        onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.onSignUpMethod();
          }
        },
        title: AppStrings.signUp,
      ),
      replacement: (context) => const AppBoxLoader(top: 15),
    );
  }
}
