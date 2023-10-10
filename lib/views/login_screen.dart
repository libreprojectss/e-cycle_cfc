import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/controllers/login_screen_controller.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/utils/custom_button.dart';
import 'package:recyclo/utils/input_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginScreenController loginScreenController =
      Get.put(LoginScreenController());
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  Map sendingBody = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<LoginScreenController>(
        builder: (controller) {
          return SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  SizedBox(
                    height: 100.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Login to your account',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: ColorConstants.KtextColor,
                                  fontSize: 26.fontSize)),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    children: [
                      Text('Email',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                      onChanged: (value) {},
                      controller: email,
                      errorText: null,
                      hintText: 'Enter your email',
                      keywordType: TextInputType.emailAddress,
                      validation: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email required ';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Invalid format';
                        } else {
                          return null;
                        }
                      },
                      obscureText: false,
                      isPrefix: true,
                      prefixIcon: const Icon(
                        Icons.email,
                        color: ColorConstants.kIconColor,
                      ),
                      readonly: false),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text('Password',
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  InputField(
                      onChanged: (value) {},
                      controller: password,
                      errorText: null,
                      hintText: 'Enter your password',
                      keywordType: TextInputType.visiblePassword,
                      validation: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 8) {
                          return 'Your password must be at least 8 characters';
                        } else if (RegExp(r"\s").hasMatch(value)) {
                          return 'Spaces are not allowed';
                        } else {
                          return null;
                        }
                      },
                      obscureText: loginScreenController.passwordVisbility,
                      isPrefix: true,
                      prefixIcon: const Icon(
                        Icons.key,
                        color: ColorConstants.kIconColor,
                      ),
                      suffix: IconButton(
                        splashRadius: 5,
                        onPressed: (() {
                          loginScreenController.loginVisibility();
                        }),
                        icon: Icon(
                            loginScreenController.passwordVisbility
                                ? Icons.visibility_off_sharp
                                : Icons.visibility_sharp,
                            color: ColorConstants.kIconColor),
                      ),
                      readonly: false),
                  SizedBox(
                    height: 40.h,
                  ),
                  CustomButton(
                    onClick: () {
                      final isvalid = _formKey1.currentState!.validate();
                      if (isvalid) {
                        FocusScope.of(context).unfocus();
                        // LoadingDialog.show(context);}?
                        sendingBody = {
                          "email": email.text,
                          "password": password.text
                        };
                        loginScreenController.loginRequest(
                            context, sendingBody);
                      }
                    },
                    text: 'Login',
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account ?",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ColorConstants.KtextColor),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.signupscreen);
                          },
                          child: Text(
                            'Sign up',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ColorConstants.kPrimaryColor),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ));
        },
      ),
    );
  }
}
