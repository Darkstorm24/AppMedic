import 'dart:convert';
import 'package:appmedic/network/api/url_api.dart';
import 'package:appmedic/pages/login_page.dart';
import 'package:appmedic/theme.dart';
import 'package:appmedic/widget/button_primary.dart';
import 'package:appmedic/widget/general_login_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _secureText = true;

  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  registerSubmit() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      var registerUrl = Uri.parse(BASEURL.apiRegister);
      final formData = _formKey.currentState?.value;
      final response = await http.post(registerUrl, body: {
        "fullname": formData!["fullname"],
        "email": formData["email"],
        "phone": formData["phone"],
        "address": formData["address"],
        "password": formData["password"],
      });

      final data = jsonDecode(response.body);
      int value = data['value'];
      String message = data['message'];
      if (value == 1) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Information"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPages()),
                    (route) => false,
                  );
                },
                child: Text("ok"),
              ),
            ],
          ),
        );
        setState(() {});
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Information"),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("ok"),
              ),
            ],
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Erreur"),
          content: Text("Veuillez vérifier les informations fournies."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("ok"),
            ),
          ],
        ),
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
                Text(
                  "REGISTER",
                  style: regularTextStyle.copyWith(fontSize: 25),
                ),
                SizedBox(height: 8),
                Text(
                  "Register your new account",
                  style: regularTextStyle.copyWith(
                      fontSize: 15, color: greyLightColor),
                ),
                SizedBox(height: 8),
                // FormBuilder
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "fullname",
                          controller: fullNameController,
                          decoration: InputDecoration(
                            labelText: "Full Name",
                            hintText: 'Full Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(50),
                          ]),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Email
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "email",
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email Address",
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Phone
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "phone",
                          controller: phoneController,
                          decoration: InputDecoration(
                            labelText: "Phone",
                            hintText: 'Phone',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.numeric(),
                            FormBuilderValidators.minLength(6),
                            FormBuilderValidators.maxLength(15),
                          ]),
                        ),
                      ),
                      SizedBox(height: 24),

                      // Address
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: FormBuilderTextField(
                          name: "address",
                          controller: addressController,
                          decoration: InputDecoration(
                            labelText: "Home Address",
                            hintText: 'Home Address',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.maxLength(100),
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
                            labelText: "Password",
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Text(
                                _secureText ? '🔒' : '🔓',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.minLength(4),
                            FormBuilderValidators.maxLength(20),
                            FormBuilderValidators.match(
                              r'^[a-zA-Z0-9]+$',
                              errorText: 'Letters and numbers only',
                            ),
                          ]),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Register Button
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: ButtonPrimary(
                          text: "REGISTER",
                          onTap: () {
                            registerSubmit();
                          },
                        ),
                      ),
                      SizedBox(height: 16),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: lightTextStyle.copyWith(
                                color: greyLightColor, fontSize: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPages()),
                                (route) => false,
                              );
                            },
                            child: Text(
                              "Login now",
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
