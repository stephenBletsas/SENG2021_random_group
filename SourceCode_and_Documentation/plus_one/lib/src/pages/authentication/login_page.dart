import 'package:flutter/material.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/authentication/sign_up_page.dart';
import 'package:plus_one/src/pages/home_nav_bar.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // for error message if invalid emailID or password
  bool error = false;
  final _formKey = GlobalKey<FormState>();

  // Create a list of text controller and use it to retrieve the current value of the TextField.
  TextEditingController emailIDTextController = new TextEditingController();
  TextEditingController passwordTextController = new TextEditingController();

  bool _obscureText = true;
  void _onCheck(bool value) => setState(() => {_obscureText = !value});

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Center(
            child: SizedBox(
                width: 240,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // TITLE
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 40.0),
                        child: Text(
                          "LOG IN",
                          style: buildRobotoTextStyle(30.0, Colors.black),
                        ),
                      ),

                      Form(
                          key: _formKey,
                          child: Column(children: [
                            buildTextField(context, "Email ID",
                                emailIDTextController, _obscureText, true),
                            buildTextField(context, "Password",
                                passwordTextController, _obscureText, false),
                            SizedBox(height: 5,),
                            // checkbox to show password
                            buildCheckBoxColumn(context, _obscureText, _onCheck,
                                'Show password'),
                          ])),

                      Container(
                        width: 120.0,
                        height: 48.0,
                        margin: const EdgeInsets.only(top: 30.0, bottom: 30.0),
                        child: RaisedButton(
                          color: seafoamGreen,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50.0))),
                          textColor: Colors.white,
                          onPressed: () {
                            // Validate returns true if the form is valid, otherwise false.
                            if (_formKey.currentState.validate()) {
                              logIn();
                            }
                          },
                          child: Text(
                            "LOG IN",
                            style: buildRobotoTextStyle(14.0, Colors.black),
                          ),
                        ),
                      ),

                      Row(children: <Widget>[
                        Expanded(child: Divider(color: Colors.grey[700])),
                        Text("OR",
                            style: buildRobotoTextStyle(12.0, Colors.black)),
                        Expanded(child: Divider(color: Colors.grey[700])),
                      ]),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          buildGoogleSigninButton(),
                          buildFacebookSigninButton(),
                        ],
                      ),

                      Container(
                          padding: EdgeInsets.only(top: 30.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'New to Plus One?  ',
                                  style:
                                      buildRobotoTextStyle(14.0, Colors.black),
                                ),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        register();
                                      });
                                    },
                                    child: Text(
                                      'Register',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline
                                      ),
                                    )),
                              ])),
                    ]))));
  }

  logIn() async {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeNavBarPage()),
      (Route<dynamic> route) => false,
    );
    print("LOGGING IN");
  }

  register() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
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
                child: isEmail
                    ? buildEmailTextFormField(controller)
                    : buildPasswordTextFormField(controller, obscureText)),
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
          return 'Please enter your password';
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

  Widget buildEmailTextFormField(TextEditingController controller) {
    return TextFormField(
      inputFormatters: [FilteringTextInputFormatter.deny(RegExp('[ ]'))],
      maxLines: 1,
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter a valid email ID';
        }
        return null;
      },
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

  Widget buildCheckBoxColumn(
      BuildContext context, bool value, Function onChanged, String label) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child: Row(children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: Colors.grey),
          child: Row(children: [
            SizedBox(
              height: 30.0,
              width: 20.0,
              child: Checkbox(
                value: !value,
                onChanged: onChanged,
                checkColor: Colors.white,
                activeColor: seafoamGreen,
              ),
            ),

            // Horizontal padding
            SizedBox(
              width: 10.0,
            ),

            Text(
              label,
              style: buildRobotoTextStyle(14.0, Colors.black),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget buildGoogleSigninButton() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070)),
          borderRadius: BorderRadius.circular(50.0),
          color: Colors.white,
        ),
        margin: const EdgeInsets.only(top: 20.0),
        child: GestureDetector(
            onTap: () {
              logIn();
            },
            child: Image.asset(
              'assets/images/google_icon.png',
              width: 50.0,
              height: 50.0,
            )));
  }



  Widget buildFacebookSigninButton() {
    return Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xff707070)),
          borderRadius: BorderRadius.circular(50.0),
          color: Color.fromRGBO(59, 89, 153, 1),
        ),
        margin: const EdgeInsets.only(top: 20.0),
        child: GestureDetector(
            onTap: () {
              logIn();
            },
            child: Image.asset(
              'assets/images/facebook_icon2.png',
              width: 50.0,
              height: 50.0
            )));
  }
}