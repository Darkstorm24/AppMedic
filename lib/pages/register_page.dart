import 'dart:convert';

import 'package:appmedic/network/api/url_api.dart';
import 'package:appmedic/pages/login_page.dart';
import 'package:appmedic/theme.dart';
import 'package:appmedic/widget/button_primary.dart';
import 'package:appmedic/widget/general_login_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;


class RegisterPage extends StatefulWidget {

 @override
 _RegisterPagesState createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPage>{

  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController(); 


  bool _secureText = true;
  showHide(){
    setState(() {
        _secureText = !_secureText;
    });
  }

  registerSubmit() async {
    var registerUrl = Uri.parse(BASEURL.apiRegister);
    final response = await http.post(registerUrl, body: {
      "fullname" : fullNameController.text,
      "email" : emailController.text,
      "phone" : phoneController.text,
      "address" : addressController.text,
      "password" : passwordController.text,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if(value == 1 ){
      showDialog(
        context: context,
         builder: (context) => AlertDialog(
              title: Text("Information"),
              content: Text(message),
              actions: [TextButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, 
                MaterialPageRoute(builder: (context)=>LoginPages()), 
                (route) => false);
              }, child: Text("ok"))],
         ));
         setState(() {
           
         });
    }else {
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
                 child: Text("ok"))],
         ));
    }
    setState(() {
      
    });

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
           SizedBox(height: 8,
                ),
          Container(
            child: Column(
              children: [
                Text(
                  "REGISTER", 
                  style: regularTextStyle.copyWith(fontSize: 25),),
                SizedBox(height: 8,
                ),
                Text("Register your new account", 
                style: regularTextStyle.copyWith(fontSize: 15, color: greyLightColor),
                ),

                SizedBox(
                  height: 8,
                ),

                //TextField
                Container(
                  padding: EdgeInsets.only(left: 16),
                  height: 50,
                  margin: EdgeInsets.only(left: 20,right: 20),
                  decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0)
                    ],
                    color: whiteColor),
                    width:  MediaQuery.of(context).size.width,
                    
                   
                    
                  child: TextField(
                    controller: fullNameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,color: greyLightColor
                      )
                    ),
                  ),
                ),

                SizedBox(
                  height: 24,
                ),

                Container(
                  padding: EdgeInsets.only(left: 16),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0)
                    ],
                    color: whiteColor),
                    width:  MediaQuery.of(context).size.width,
                  
                    
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email Adress',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,color: greyLightColor
                      )
                    ),
                  ),
                ),


              SizedBox(
                  height: 24,
                ),

                Container(
                  padding: EdgeInsets.only(left: 16),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0)
                    ],
                    color: whiteColor),
                    width:  MediaQuery.of(context).size.width,
                    
                    
                  child: TextField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,color: greyLightColor
                      )
                    ),
                  ),
                ),

                SizedBox(
                  height: 24,
                ),

                Container(
                  padding: EdgeInsets.only(left: 16),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0)
                    ],
                    color: whiteColor),
                    width:  MediaQuery.of(context).size.width,
                    
                    
                  child: TextField(
                    controller: addressController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Home Adress',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,color: greyLightColor
                      )
                    ),
                  ),
                ),

                SizedBox(
                  height: 24,
                ),

                Container(
                  padding: EdgeInsets.only(left: 16),
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x40000000),
                        offset: Offset(0, 1),
                        blurRadius: 4,
                        spreadRadius: 0)
                    ],
                    color: whiteColor),
                    width:  MediaQuery.of(context).size.width,
                  
                  child: TextField(
                    controller: passwordController,
                    obscureText: _secureText,
                    decoration: InputDecoration(
                      suffixIcon: IconButton
                      (onPressed: showHide, 
                      icon: _secureText 
                      ? Icon(Icons.visibility_off, color: purpleColor,size: 20,) 
                      : Icon(Icons.visibility, color: purpleColor, size: 20,),
                      ),
                      border: InputBorder.none,
                      hintText: 'Password',
                      hintStyle: lightTextStyle.copyWith(
                        fontSize: 15,color: greyLightColor
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 30,
                ),

                Container(
                  padding: EdgeInsets.only(right: 20,left: 20),
                  width: MediaQuery.of(context).size.width,
                  child: ButtonPrimary(
                  text: "REGISTER",
                  onTap: (){
                    if( fullNameController.text.isEmpty || 
                        emailController.text.isEmpty || 
                        phoneController.text.isEmpty || 
                        addressController.text.isEmpty || 
                        passwordController.text.isEmpty){
                           showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(" Warning !! "),
                                    content: Text("Please fill all the fields."),
                                    actions: [
                                      TextButton(
                                        onPressed: () { 
                                          Navigator.pop(context);
                                        }, child: Text("ok"))],
                                        ));
                    }else{
                      registerSubmit();
                    }
                  },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: lightTextStyle.copyWith(
                        color: greyLightColor, fontSize: 15
                      ),),
                    Text(
                      "Login now",
                      style: boldTextStyle.copyWith(
                        color: purpleColor, fontSize: 15,
                      ),)
                  ],
                )
             
               

                


                
              ],
            ),
          )
        ],
      ),
    );
  }
}
