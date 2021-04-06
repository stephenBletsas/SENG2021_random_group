import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/home_nav_bar.dart';
import 'package:flutter/services.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmailPage> {
  // for error message if invalid emailID or password
  bool error = false;
  final _formKey = GlobalKey<FormState>();

  // Text controller to retrieve the current value of the TextField.
  TextEditingController verificationCodeController = new TextEditingController();

  bool _obscureText = true;

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: SizedBox(
                width: 240,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TITLE
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "VERIFY EMAIL",
                          style: buildRobotoTextStyle(30.0, Colors.black),
                        ),
                      ),
                      
                      SizedBox(height: 10),
                      
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          "A verification code has been sent to your registered email ID.",
                          style: buildRobotoTextStyle(14.0, Colors.black),
                        ),
                      ),
                      
                      SizedBox(height: 200),

                      

                      Form(
                          key: _formKey,
                          child: 
                            buildTextField(context, "Enter code",
                                verificationCodeController, _obscureText, false),
                          ),

                      Container(
                        width: 120.0,
                        height: 48.0,
                        margin: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: RaisedButton(
                          color: seafoamGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          textColor: Colors.white,
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              verify();
                            }
                          },
                          child: Text(
                            "NEXT",
                            style: buildRobotoTextStyle(14.0, Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
          padding: EdgeInsets.only(top: 0.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Didn\'t receive your code? ',
                  style: buildRobotoTextStyle(14.0, Colors.black),
                ),
                SizedBox(height:2,),
                InkWell(
                    onTap: () {},
                    child: Text(
                      'Resend it',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        decoration:
                        TextDecoration.underline,
                        color: seafoamGreen,
                      ),
                    )),
              ])),

                      

                      

                       
                    ]))));
  }

  verify() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeNavBarPage()),
      (Route<dynamic> route) => false,
    );
  }

  Widget buildTextField(BuildContext context, String label,
      TextEditingController controller, bool obscureText, bool isEmail) {
    return Column(children: [
      Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 20.0, bottom: 8.0),
        child: Text(
          label,
          style: buildRobotoTextStyle(14.0, Colors.black),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          child: Theme(
            data: ThemeData(
              primaryColor: seafoamGreen,
            ),
            child: SizedBox(
                width: 240.0,
                height: 36.0,
                child: buildPasswordTextFormField(controller, obscureText)),
          ))
    ]);
  }

  Widget buildPasswordTextFormField(
      TextEditingController controller, bool obscureText) {
    return TextFormField(
      maxLines: 1,
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your verification code';
        }
        return null;
      },
      obscureText: obscureText,
      showCursor: true,
      decoration: InputDecoration(
        errorStyle: TextStyle(height: 0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        filled: true,
        fillColor: Colors.grey[200].withOpacity(0.75),
      ),
      style: buildRobotoTextStyle(14.0, Colors.black),
    );
  }

  
}