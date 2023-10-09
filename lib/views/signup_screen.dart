import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:recyclo/config/ext.dart';
import 'package:recyclo/constants/color_constants.dart';
import 'package:recyclo/controllers/signup_screen_contoller.dart';
import 'package:recyclo/routes/approutes.dart';
import 'package:recyclo/utils/custom_button.dart';
import 'package:recyclo/utils/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  Map sendingBody = {};
  final SignUpScreenController signUpScreenController =
      Get.put(SignUpScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GetBuilder<SignUpScreenController>(
      builder: (controller) {
        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Form(
            key: _formKey2,
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                Row(
                  children: [
                    Text('Name',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InputField(
                    controller: name,
                    errorText: null,
                    hintText: 'Enter your name',
                    keywordType: TextInputType.name,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return ('Required');
                      }
                      if (value.length < 3) {
                        return ('Name must of atleast 3 digits');
                      }

                      if (!RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Enter the correct name';
                      }
                    },
                    obscureText: false,
                    isPrefix: true,
                    prefixIcon: const Icon(
                      Icons.person_2_outlined,
                      color: ColorConstants.kIconColor,
                    ),
                    readonly: false),
                SizedBox(
                  height: 20.h,
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
                    Text('Phone Number',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InputField(
                    controller: phonenumber,
                    errorText: null,
                    hintText: 'Enter your phone number',
                    keywordType: TextInputType.phone,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      } else if (value.length != 10 || value.length > 10) {
                        return 'The phone number must be 10 digits long.';
                      }
                    },
                    obscureText: false,
                    isPrefix: true,
                    prefixIcon: const Icon(
                      Icons.phone_outlined,
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
                    controller: password,
                    errorText: null,
                    hintText: 'Enter your password',
                    keywordType: TextInputType.visiblePassword,
                    validation: (value) {
                      if (value == null || value.isEmpty || value.length < 8) {
                        return 'Your password must be at least 8 characters';
                      } else if (RegExp(r"\s").hasMatch(value)) {
                        return 'Spaces are not allowed';
                      } else {
                        return null;
                      }
                    },
                    obscureText: signUpScreenController.passwordVisbility,
                    isPrefix: true,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: ColorConstants.kIconColor,
                    ),
                    readonly: false),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Text(' Confirm Password',
                        style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                InputField(
                    controller: confirmpassword,
                    errorText: null,
                    hintText: 'Confirm your password',
                    keywordType: TextInputType.visiblePassword,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please re-enter your password';
                      } else if (RegExp(r"\s").hasMatch(value)) {
                        return 'Spaces are not allowed';
                      } else if (value != password.text) {
                        return ' Passwords donot match';
                      } else {
                        return null;
                      }
                    },
                    obscureText: signUpScreenController.passwordVisbility,
                    isPrefix: true,
                    prefixIcon: const Icon(
                      Icons.key_outlined,
                      color: ColorConstants.kIconColor,
                    ),
                    suffix: IconButton(
                      splashRadius: 5,
                      onPressed: (() {
                        signUpScreenController.signupVisibility();
                      }),
                      icon: Icon(
                          signUpScreenController.passwordVisbility
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
                    final isvalid = _formKey2.currentState!.validate();
                    if (isvalid) {
                      FocusScope.of(context).unfocus();
                      // LoadingDialog.show(context);}?
                      sendingBody = {
                        "email": email.text,
                        "password": password.text,
                        "confirm_password": confirmpassword.text,
                        "name": name.text,
                        "phone_number": "+977${phonenumber.text}"
                      };
                      signUpScreenController.signUpRequest(
                          context, sendingBody);
                    }
                  },
                  text: 'Sign Up',
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account ?",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: ColorConstants.KtextColor),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.loginscreen);
                        },
                        child: Text(
                          'Login',
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
    ));
  }
}
