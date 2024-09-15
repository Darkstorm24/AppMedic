import 'dart:convert';
import 'package:appmedic/network/api/url_api.dart';
import 'package:appmedic/pages/main_page.dart';
import 'package:appmedic/pages/register_page.dart';
import 'package:appmedic/theme.dart';
import 'package:appmedic/widget/general_login_space.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;
import '../widget/button_primary.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart'; // Import du package d'animation

class LoginPages extends StatefulWidget {
  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final _formKey = GlobalKey<FormBuilderState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  submitLogin() async {
  if (_formKey.currentState?.saveAndValidate() ?? false) {
    var urlLogin = Uri.parse(BASEURL.apiLogin);
    final response = await http.post(urlLogin, body: {
      "email": emailController.text,
      "password": passwordController.text,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ClassicGeneralDialogWidget(
            titleText: 'Information',
            contentText: message,
            positiveTextStyle: TextStyle(color: Colors.black),
            onPositiveClick: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainPage()),
                (route) => false,
              );
            },
            positiveText: 'OK',
          );
        },
      );
    } else {
      showAnimatedDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return ClassicGeneralDialogWidget(
            titleText: 'Information',
            contentText: message,
            positiveTextStyle: TextStyle(color: Colors.black),
            onPositiveClick: () {
              Navigator.pop(context); // Ferme le dialogue
            },
            positiveText: 'OK',
          );
        },
      );
    }
  } else {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return ClassicGeneralDialogWidget(
          titleText: 'Warning !!',
          contentText: 'Please fill all the fields.',
          positiveTextStyle: TextStyle(color: Colors.black),
          onPositiveClick: () {
            Navigator.pop(context); // Ferme le dialogue
          },
          positiveText: 'OK',
        );
      },
    );
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: ListView(
        children: [
          Container(
            child: GeneralLoginSpace(),
          ),
          SizedBox(height: 8),
          Container(
            child: Column(
              children: [
                SizedBox(height: 80),
                Text(
                  "LOGIN",
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(height: 8),
                Text(
                  "Login to your account",
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(height: 8),
                // FormBuilder
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "email",
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            errorText: _formKey.currentState?.fields["email"]?.errorText,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Email is required"),
                            FormBuilderValidators.email(errorText: "Invalid email format"),
                          ]),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Password
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "password",
                          controller: passwordController,
                          obscureText: _secureText,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: _secureText
                                  ? Icon(Icons.visibility_off, color: purpleColor, size: 20)
                                  : Icon(Icons.visibility, color: purpleColor, size: 20),
                            ),
                            errorText: _formKey.currentState?.fields["password"]?.errorText,
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(errorText: "Password is required"),
                            FormBuilderValidators.minLength(4, errorText: "Minimum length is 4 characters"),
                            FormBuilderValidators.maxLength(20, errorText: "Maximum length is 20 characters"),
                          ]),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Login Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonPrimary(
                          text: "LOGIN",
                          onTap: () {
                            submitLogin();
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Register Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Don't have an account? ",
                            style: lightTextStyle.copyWith(
                                color: greyLightColor, fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (context) => RegisterPage()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Register now",
                              style: boldTextStyle.copyWith(
                                  color: purpleColor, fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
