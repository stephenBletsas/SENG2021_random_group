import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plus_one/src/styling/custom_text_styles.dart';
import 'package:plus_one/src/styling/color_palettes.dart';
import 'package:plus_one/src/pages/home_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:plus_one/src/utils/auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  @override
  _VerifyEmailState createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmailPage> {
  bool _emailVerified = true;

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
                          'A verification link has been sent to your registered email ID\n\n'
                          'After you have verified your email, click NEXT',
                          style: buildRobotoTextStyle(14.0, Colors.black),
                        ),
                      ),

                      SizedBox(height: 200),

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
                            verify();
                          },
                          child: Text(
                            "NEXT",
                            style: buildRobotoTextStyle(14.0, Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 0.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Didn\'t receive your code? ',
                                  style:
                                      buildRobotoTextStyle(14.0, Colors.black),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Resend it',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline,
                                        color: seafoamGreen,
                                      ),
                                    )),
                              ])),
                    ]))));
  }

  verify() {
    if (AuthService().isEmailVerified()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomeNavBarPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      // TODO: show error message if the user hasn't verified email yet
      setState(() => {
            _emailVerified = false,
            print(_emailVerified),
            Fluttertoast.showToast(
                msg: "Email not verified. Please verify your email and try again.",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 2,
                backgroundColor: Colors.grey,
                textColor: Colors.black)
          });
    }
  }
}
