import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ninedot_task/constant/app_color.dart';
import 'package:ninedot_task/constant/app_strings.dart';
import 'package:ninedot_task/constant/app_validation.dart';
import 'package:ninedot_task/screens/login/controller/login_controller.dart';
import 'package:ninedot_task/utils/app_routes.dart';
import 'package:ninedot_task/utils/extensions.dart';
import 'package:ninedot_task/widgets/app_buttons.dart';
import 'package:ninedot_task/widgets/app_conditional_widget.dart';
import 'package:ninedot_task/widgets/app_loader.dart';
import 'package:ninedot_task/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (height * 0.03).addHSpace(),

                    ///Title
                    Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 10),
                      child: AppStrings.login.semiBold(fontSize: 24),
                    ),
                    (height * 0.02).addHSpace(),

                    ///Email Field
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

                    ///Password Field
                    CommonTextField(
                      controller: controller.passController,
                      textCapitalization: TextCapitalization.words,
                      textInputType: TextInputType.text,
                      obscureText: controller.isVisible,
                      title: AppStrings.password,
                      validator: validatePassword,
                      suffixIcon: InkWell(
                          overlayColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          onTap: () {
                            controller.changeVisible();
                          },
                          child: Icon(controller.isVisible
                              ? Icons.visibility_off
                              : Icons.visibility_sharp)),
                      onChanged: (value) => controller.update(),
                    ),
                    const Spacer(),

                    ///Signup Button
                    const SignUpButton(),

                    ///Login Button
                    LoginButton(controller: controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppStrings.createNewAccount
            .regular(fontColor: Palette.greyText, fontSize: 12),
        (Get.width * 0.01).addWSpace(),
        InkWell(
          onTap: () => Get.toNamed(Routes.signUp),
          child: AppStrings.signUp
              .medium(fontColor: Palette.primary, fontSize: 14),
        ),
      ],
    );
  }
}

class LoginButton extends StatelessWidget {
  final LoginController controller;

  const LoginButton({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return If(
      condition: !controller.isLoading,
      child: (context) => AppFilledButton(
        padding: const EdgeInsets.only(top: 15, bottom: 30), onPressed: () {
          if (controller.formKey.currentState!.validate()) {
            controller.onLoginMethod();
          }

        },
        title: AppStrings.login,
      ),
      replacement: (context) => const AppBoxLoader(top: 15, bottom: 20),
    );
  }
}
